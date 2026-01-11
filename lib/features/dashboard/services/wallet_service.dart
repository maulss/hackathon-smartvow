import 'dart:convert';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../core/abi/contract_abi.dart';
import '../models/wallet_model.dart';
import '../models/partner_profile_model.dart';

/// Wallet Service
/// Service untuk berinteraksi dengan smart contract SmartVow
class WalletService {
  Web3Client? _client;
  DeployedContract? _contract;
  String? _connectedAddress;
  Credentials? _credentials;

  // RPC URL untuk Base L2 (ganti sesuai kebutuhan)
  static const String _rpcUrl =
      'https://sepolia.base.org'; // Base Sepolia Testnet
  // Atau gunakan mainnet: 'https://mainnet.base.org'

  /// Initialize Web3 client
  Future<void> initialize() async {
    await dotenv.load(fileName: '.env');

    // Initialize Web3 client
    _client = Web3Client(_rpcUrl, http.Client());

    // Check network
    final networkId = await _client!.getNetworkId();
    print('🌐 Connected to network ID: $networkId');
    print('🌐 RPC URL: $_rpcUrl');

    // Get contract address from .env
    final contractAddress = dotenv.env['SMARTVOW_CONTRACT_ADDRESS'];
    if (contractAddress == null || contractAddress.isEmpty) {
      throw Exception('Contract address not found in .env file');
    }

    print('📋 Contract address from .env: $contractAddress');

    // Initialize contract
    final contract = DeployedContract(
      ContractAbi.fromJson(contractAbiJson, 'SmartVow'),
      EthereumAddress.fromHex(contractAddress),
    );

    _contract = contract;
  }

  /// Connect wallet (untuk demo, menggunakan private key)
  /// Dalam production, gunakan WalletConnect atau MetaMask
  Future<WalletModel> connectWallet(String privateKey) async {
    if (_client == null) await initialize();

    try {
      // Create credentials from private key
      _credentials = EthPrivateKey.fromHex(privateKey);
      final address = _credentials!.address;
      _connectedAddress = address.hex;

      // Get balance
      final balance = await _client!.getBalance(address);
      final balanceInEth = balance.getValueInUnit(EtherUnit.ether);

      // Get chain ID
      final chainId = await _client!.getNetworkId();

      return WalletModel(
        address: address.hex,
        chainId: chainId.toString(),
        balance: balanceInEth.toString(),
        connectedAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Failed to connect wallet: $e');
    }
  }

  /// Disconnect wallet
  void disconnectWallet() {
    _connectedAddress = null;
    _credentials = null;
  }

  /// Check if wallet is connected
  bool get isConnected => _connectedAddress != null;

  /// Get connected address
  String? get connectedAddress => _connectedAddress;

  /// Get user vows (perjanjian)
  Future<List<VowModel>> getUserVows(String userAddress) async {
    print('🔄 getUserVows called for: $userAddress');
    if (_client == null || _contract == null) await initialize();

    try {
      final function = _contract!.function('getUserVows');
      print('🔍 Calling getUserVows on contract: ${_contract!.address.hex}');

      final result = await _client!.call(
        contract: _contract!,
        function: function,
        params: [EthereumAddress.fromHex(userAddress)],
      );

      print('🔍 getUserVows raw result: $result');
      final vowIds = result[0] as List<dynamic>;
      print('🔍 Found ${vowIds.length} vow IDs: $vowIds');

      final vows = <VowModel>[];

      for (final vowId in vowIds) {
        final id = vowId is BigInt ? vowId : BigInt.from(vowId as num);
        print('🔍 Fetching vow #$id...');
        final vow = await getVow(id);
        if (vow != null) {
          vows.add(vow);
          print('✅ Vow #$id fetched successfully');
        }
      }

      print('✅ getUserVows completed: ${vows.length} vows');
      return vows;
    } catch (e) {
      print('💥 Error in getUserVows: $e');
      throw Exception('Failed to get user vows: $e');
    }
  }

  /// Get vow details
  Future<VowModel?> getVow(BigInt vowId) async {
    if (_client == null || _contract == null) await initialize();

    try {
      final function = _contract!.function('getVow');
      final result = await _client!.call(
        contract: _contract!,
        function: function,
        params: [vowId],
      );

      if (result.isEmpty) return null;

      // The result is a list containing a single tuple/struct
      // We need to extract the struct fields
      final vowData = result[0];

      print('🔍 Vow #$vowId raw data: $vowData');

      // When contract returns a struct, web3dart gives us a List
      if (vowData is List) {
        final vow = VowModel.fromContract(vowData);
        print(
          '✅ Vow #$vowId parsed: status=${vow.status}, escrow=${vow.escrowBalance}, partnerA=${vow.partnerASigned}, partnerB=${vow.partnerBSigned}',
        );
        return vow;
      }

      return null;
    } catch (e) {
      print('Error in getVow: $e');
      throw Exception('Failed to get vow details: $e');
    }
  }

  /// Get partner contributions using getSharedVaultInfo
  Future<Map<String, BigInt>> getPartnerContributions(
    String userAddress,
  ) async {
    print('🔄 getPartnerContributions called for: $userAddress');
    if (_client == null || _contract == null) await initialize();

    try {
      // Get user's certificates first
      final certificatesFunction = _contract!.function('getMyCertificates');
      final certificatesResult = await _client!.call(
        contract: _contract!,
        function: certificatesFunction,
        params: [],
        sender: _credentials?.address ?? EthereumAddress.fromHex(userAddress),
      );

      if (certificatesResult.isEmpty || certificatesResult[0].isEmpty) {
        print('⚠️ No certificates found');
        return {'partnerA': BigInt.zero, 'partnerB': BigInt.zero};
      }

      final certificateIds = certificatesResult[0] as List<dynamic>;
      BigInt totalPartnerAContribution = BigInt.zero;
      BigInt totalPartnerBContribution = BigInt.zero;

      // Process each certificate using getSharedVaultInfo
      for (final certId in certificateIds) {
        final certificateId = certId is BigInt ? certId : BigInt.from(certId);

        try {
          final vaultInfoFunction = _contract!.function('getSharedVaultInfo');
          final vaultInfoResult = await _client!.call(
            contract: _contract!,
            function: vaultInfoFunction,
            params: [certificateId],
            sender:
                _credentials?.address ?? EthereumAddress.fromHex(userAddress),
          );

          if (vaultInfoResult.length >= 5) {
            final totalBalance = vaultInfoResult[0] is BigInt
                ? vaultInfoResult[0] as BigInt
                : BigInt.from(vaultInfoResult[0]);
            final myContribution = vaultInfoResult[1] is BigInt
                ? vaultInfoResult[1] as BigInt
                : BigInt.from(vaultInfoResult[1]);
            final partnerContribution = vaultInfoResult[2] is BigInt
                ? vaultInfoResult[2] as BigInt
                : BigInt.from(vaultInfoResult[2]);
            final partnerA = vaultInfoResult[3] as EthereumAddress;
            final partnerB = vaultInfoResult[4] as EthereumAddress;

            print('🔍 Certificate $certificateId:');
            print('   - Total: $totalBalance wei');
            print('   - My contribution: $myContribution wei');
            print('   - Partner contribution: $partnerContribution wei');
            print('   - Partner A: ${partnerA.hex}');
            print('   - Partner B: ${partnerB.hex}');
            print('   - Current user: $userAddress');

            // Determine if current user is Partner A or B
            if (partnerA.hex.toLowerCase() == userAddress.toLowerCase()) {
              // Current user is Partner A
              totalPartnerAContribution += myContribution;
              totalPartnerBContribution += partnerContribution;
            } else if (partnerB.hex.toLowerCase() ==
                userAddress.toLowerCase()) {
              // Current user is Partner B
              totalPartnerAContribution += partnerContribution;
              totalPartnerBContribution += myContribution;
            }
          }
        } catch (e) {
          print(
            '⚠️ Error getting vault info for certificate $certificateId: $e',
          );
        }
      }

      print(
        '✅ Final contributions: A=$totalPartnerAContribution, B=$totalPartnerBContribution',
      );
      return {
        'partnerA': totalPartnerAContribution,
        'partnerB': totalPartnerBContribution,
      };
    } catch (e) {
      print('💥 Error in getPartnerContributions: $e');
      return {'partnerA': BigInt.zero, 'partnerB': BigInt.zero};
    }
  }

  /// Get vault balances using getMyVaultSummary from contract
  Future<VaultBalancesModel> getVaultBalances(String userAddress) async {
    print('🔄 getVaultBalances called for: $userAddress');
    if (_client == null || _contract == null) await initialize();

    try {
      // Use getMyVaultSummary which returns personalBalance, totalSharedBalance, certificateCount
      final summaryFunction = _contract!.function('getMyVaultSummary');

      print('🔍 Contract address: ${_contract!.address.hex}');
      print(
        '🔍 Connected wallet: ${_credentials?.address.hex ?? "NO CREDENTIALS"}',
      );
      print('🔍 Calling getMyVaultSummary with credentials as sender...');

      // Call with sender parameter to simulate the call from the user's address
      final summaryResult = await _client!.call(
        contract: _contract!,
        function: summaryFunction,
        params: [],
        sender: _credentials != null
            ? _credentials!.address
            : EthereumAddress.fromHex(userAddress),
      );

      print('🔍 Vault summary result: $summaryResult');

      final personalBalance = summaryResult.isNotEmpty
          ? (summaryResult[0] is BigInt
                ? summaryResult[0] as BigInt
                : BigInt.from(summaryResult[0]))
          : BigInt.zero;

      final totalSharedBalance = summaryResult.length > 1
          ? (summaryResult[1] is BigInt
                ? summaryResult[1] as BigInt
                : BigInt.from(summaryResult[1]))
          : BigInt.zero;

      // Get detailed shared vault info if certificates exist
      BigInt sharedContribution = BigInt.zero;
      if (summaryResult.length > 2) {
        final certificateCount = summaryResult[2] is BigInt
            ? summaryResult[2] as BigInt
            : BigInt.from(summaryResult[2]);

        if (certificateCount > BigInt.zero) {
          try {
            // Get all shared vaults to calculate total contribution
            final allVaultsFunction = _contract!.function(
              'getAllMySharedVaults',
            );
            final allVaultsResult = await _client!.call(
              contract: _contract!,
              function: allVaultsFunction,
              params: [],
              sender: _credentials?.address,
            );

            if (allVaultsResult.length > 2) {
              final myContributions = allVaultsResult[2] as List<dynamic>;
              for (var contribution in myContributions) {
                final amount = contribution is BigInt
                    ? contribution
                    : BigInt.from(contribution);
                sharedContribution += amount;
              }
            }
          } catch (e) {
            print('⚠️ Error getting shared contributions: $e');
          }
        }
      }

      final balances = VaultBalancesModel(
        personal: personalBalance,
        sharedContribution: sharedContribution,
        totalShared: totalSharedBalance,
      );

      print(
        '✅ getVaultBalances parsed: personal=${balances.personal}, shared=${balances.totalShared}, contribution=${balances.sharedContribution}',
      );
      return balances;
    } catch (e) {
      print('💥 Error in getVaultBalances: $e');
      // Return zero balances if contract call fails
      final zeroBalances = VaultBalancesModel(
        personal: BigInt.zero,
        sharedContribution: BigInt.zero,
        totalShared: BigInt.zero,
      );
      print('✅ getVaultBalances fallback: personal=0, shared=0');
      return zeroBalances;
    }
  }

  /// Get all user certificates/agreements
  Future<List<CertificateModel>> getAllCertificates() async {
    print('🔄 getAllCertificates called');
    if (_client == null || _contract == null) await initialize();

    try {
      print(
        '🔍 Connected wallet for certificates: ${_credentials?.address.hex ?? "NO CREDENTIALS"}',
      );
      print('🔍 Contract address: ${_contract!.address.hex}');

      // Get list of certificate IDs
      final getCertificatesFunction = _contract!.function('getMyCertificates');
      print('🔍 Calling getMyCertificates()...');

      final certificateIdsResult = await _client!.call(
        contract: _contract!,
        function: getCertificatesFunction,
        params: [],
        sender: _credentials?.address,
      );

      print('🔍 Certificate IDs raw result: $certificateIdsResult');
      print('🔍 Result type: ${certificateIdsResult.runtimeType}');
      print('🔍 Result length: ${certificateIdsResult.length}');

      if (certificateIdsResult.isNotEmpty) {
        print('🔍 First element: ${certificateIdsResult[0]}');
        print('🔍 First element type: ${certificateIdsResult[0].runtimeType}');
        if (certificateIdsResult[0] is List) {
          print(
            '🔍 First element length: ${(certificateIdsResult[0] as List).length}',
          );
        }
      }

      if (certificateIdsResult.isEmpty || certificateIdsResult[0].isEmpty) {
        print('✅ No certificates found (empty result)');
        return [];
      }

      final certificateIds = certificateIdsResult[0] as List<dynamic>;
      print('🔍 Found ${certificateIds.length} certificates');

      List<CertificateModel> certificates = [];

      // Get details for each certificate
      for (var certId in certificateIds) {
        try {
          final getPartnersFunction = _contract!.function(
            'getCertificatePartners',
          );
          final partnersResult = await _client!.call(
            contract: _contract!,
            function: getPartnersFunction,
            params: [certId],
            sender: _credentials?.address, // Add sender to authorize the call
          );

          print('🔍 Certificate $certId partners: $partnersResult');

          if (partnersResult.length >= 2) {
            final certificate = CertificateModel(
              id: certId is BigInt ? certId : BigInt.from(certId),
              partnerA: (partnersResult[0] as EthereumAddress).hex,
              partnerB: (partnersResult[1] as EthereumAddress).hex,
              status: 1, // Active by default
              createdAt: DateTime.now(), // Placeholder
            );
            certificates.add(certificate);
          }
        } catch (e) {
          print('💥 Error getting certificate $certId details: $e');
        }
      }

      print('✅ getAllCertificates parsed: ${certificates.length} certificates');
      return certificates;
    } catch (e) {
      print('💥 Error in getAllCertificates: $e');
      return [];
    }
  }

  /// Get partners from vow using getVow()
  Future<Map<String, PartnerProfileModel?>> getPartners(
    String userAddress,
  ) async {
    try {
      final vows = await getUserVows(userAddress);
      if (vows.isEmpty) return {'partnerA': null, 'partnerB': null};

      // Priority: Active (2) > PendingSignatures (1) > Draft (0) > any other
      final vow = vows.firstWhere(
        (v) => v.status == 2, // Active
        orElse: () => vows.firstWhere(
          (v) => v.status == 1, // PendingSignatures
          orElse: () =>
              vows.firstWhere((v) => v.status == 0, orElse: () => vows.first),
        ),
      );

      // Parse names from metadataURI
      String nameA = _getShortAddress(vow.partnerA);
      String nameB = _getShortAddress(vow.partnerB);

      if (vow.metadataURI != null && vow.metadataURI!.isNotEmpty) {
        try {
          final metadata = jsonDecode(vow.metadataURI!);
          nameA = metadata['partnerAName'] ?? metadata['nameA'] ?? nameA;
          nameB = metadata['partnerBName'] ?? metadata['nameB'] ?? nameB;
        } catch (_) {}
      }

      return {
        'partnerA': PartnerProfileModel(
          address: vow.partnerA,
          name: nameA,
          isCertified: vow.partnerASigned,
          lastActive: vow.activatedAt,
        ),
        'partnerB': PartnerProfileModel(
          address: vow.partnerB,
          name: nameB,
          isCertified: vow.partnerBSigned,
          lastActive: vow.activatedAt,
        ),
      };
    } catch (e) {
      return {'partnerA': null, 'partnerB': null};
    }
  }

  /// Get dashboard data
  Future<DashboardDataModel> getDashboardData(String userAddress) async {
    print('🚀 getDashboardData called for address: $userAddress');
    if (_client == null || _contract == null) await initialize();

    try {
      List<VowModel> vows = [];
      List<CertificateModel> certificates = [];
      VaultBalancesModel? vaultBalances;
      Map<String, PartnerProfileModel?> partners = {
        'partnerA': null,
        'partnerB': null,
      };
      BigInt totalEscrowLocked = BigInt.zero;
      BigInt partnerAContribution = BigInt.zero;
      BigInt partnerBContribution = BigInt.zero;

      try {
        vows = await getUserVows(userAddress);
      } catch (e) {
        // Continue with empty vows
      }

      try {
        certificates = await getAllCertificates();
      } catch (e) {
        print('❌ Error getting certificates: $e');
      }

      try {
        vaultBalances = await getVaultBalances(userAddress);
      } catch (e) {
        print('❌ Error getting vault balances: $e');
        vaultBalances = VaultBalancesModel(
          personal: BigInt.zero,
          sharedContribution: BigInt.zero,
          totalShared: BigInt.zero,
        );
      }

      try {
        partners = await getPartners(userAddress);
      } catch (e) {
        // No partners found
      }

      // Calculate total escrow locked from active vows (status 2 = Active)
      for (final vow in vows) {
        if (vow.status == 2) {
          // Active vow (status 2 according to VowStatus enum)
          totalEscrowLocked += vow.escrowBalance;
        }
      }

      // Calculate partner contributions for shared vault
      try {
        final contributions = await getPartnerContributions(userAddress);
        partnerAContribution = contributions['partnerA'] ?? BigInt.zero;
        partnerBContribution = contributions['partnerB'] ?? BigInt.zero;

        print(
          '📊 Partner contributions: A=${partnerAContribution}, B=${partnerBContribution}',
        );
      } catch (e) {
        print('⚠️ Error calculating contributions: $e');
        // Fallback: use vault summary if available
        if (vaultBalances != null && vaultBalances.totalShared > BigInt.zero) {
          final myContribution = vaultBalances.sharedContribution;
          final totalShared = vaultBalances.totalShared;
          final partnerContribution = totalShared - myContribution;

          // Determine which partner is current user
          if (partners['partnerA'] != null &&
              partners['partnerA']!.address.toLowerCase() ==
                  userAddress.toLowerCase()) {
            partnerAContribution = myContribution;
            partnerBContribution = partnerContribution;
          } else {
            partnerAContribution = partnerContribution;
            partnerBContribution = myContribution;
          }
        }
      }

      // Active vows are those with status 2 (Active) according to VowStatus enum
      final activeVows = vows.where((vow) => vow.status == 2).toList();

      final dashboardData = DashboardDataModel(
        userAddress: userAddress,
        partnerA: partners['partnerA'],
        partnerB: partners['partnerB'],
        vaultBalances: vaultBalances,
        activeVows: activeVows,
        certificates: certificates,
        totalAgreements: vows.length,
        activeAgreements: activeVows.length,
        assetNFTCount: certificates.length,
        totalEscrowLocked: totalEscrowLocked,
        partnerAContribution: partnerAContribution,
        partnerBContribution: partnerBContribution,
      );

      print('✅ getDashboardData returning:');
      print('   - Total vows: ${vows.length}');
      print('   - Active vows: ${activeVows.length}');
      print('   - Has partnerA: ${partners['partnerA'] != null}');
      print('   - Has partnerB: ${partners['partnerB'] != null}');
      print('   - Partner A name: ${partners['partnerA']?.name}');
      print('   - Partner B name: ${partners['partnerB']?.name}');

      return dashboardData;
    } catch (e) {
      return DashboardDataModel(
        userAddress: userAddress,
        partnerA: null,
        partnerB: null,
        vaultBalances: VaultBalancesModel(
          personal: BigInt.zero,
          sharedContribution: BigInt.zero,
          totalShared: BigInt.zero,
        ),
        activeVows: [],
        certificates: [],
        totalAgreements: 0,
        activeAgreements: 0,
        assetNFTCount: 0,
        totalEscrowLocked: BigInt.zero,
        partnerAContribution: BigInt.zero,
        partnerBContribution: BigInt.zero,
      );
    }
  }

  /// Create new vow
  Future<String> createVow({
    required String partnerBAddress,
    required String metadataURI,
  }) async {
    if (_client == null || _contract == null) await initialize();
    if (_credentials == null) throw Exception('Wallet not connected');

    try {
      final function = _contract!.function('createVow');

      final transaction = Transaction.callContract(
        contract: _contract!,
        function: function,
        parameters: [EthereumAddress.fromHex(partnerBAddress), metadataURI],
      );

      final txHash = await _client!.sendTransaction(
        _credentials!,
        transaction,
        chainId: 84532, // Base Sepolia testnet chain ID (8453 for mainnet)
      );

      return txHash;
    } catch (e) {
      throw Exception('Failed to create vow: $e');
    }
  }

  /// Deposit to personal vault
  Future<String> depositPersonal(BigInt amount) async {
    if (_client == null || _contract == null) await initialize();
    if (_credentials == null) throw Exception('Wallet not connected');

    try {
      final function = _contract!.function('depositPersonal');

      final transaction = Transaction.callContract(
        contract: _contract!,
        function: function,
        parameters: [],
        value: EtherAmount.inWei(amount),
      );

      print('📤 Sending deposit transaction...');
      final txHash = await _client!.sendTransaction(
        _credentials!,
        transaction,
        chainId: 84532,
      );

      print('✅ Transaction sent: $txHash');
      print('⏳ Waiting for transaction receipt...');

      // Wait for transaction to be mined
      TransactionReceipt? receipt;
      int attempts = 0;
      const maxAttempts = 30; // 30 seconds max

      while (receipt == null && attempts < maxAttempts) {
        await Future.delayed(const Duration(seconds: 1));
        try {
          receipt = await _client!.getTransactionReceipt(txHash);
          if (receipt != null) {
            print('✅ Transaction mined in block ${receipt.blockNumber}');
            break;
          }
        } catch (e) {
          // Receipt not available yet
        }
        attempts++;
        print('⏳ Waiting for confirmation... ($attempts/$maxAttempts)');
      }

      if (receipt == null) {
        print('⚠️ Transaction sent but receipt not received yet: $txHash');
      }

      return txHash;
    } catch (e) {
      throw Exception('Failed to deposit to personal vault: $e');
    }
  }

  /// Withdraw from personal vault
  Future<String> withdrawPersonal(BigInt amount) async {
    if (_client == null || _contract == null) await initialize();
    if (_credentials == null) throw Exception('Wallet not connected');

    try {
      final function = _contract!.function('withdrawPersonal');

      final transaction = Transaction.callContract(
        contract: _contract!,
        function: function,
        parameters: [amount],
      );

      print('💸 Sending withdraw transaction...');
      final txHash = await _client!.sendTransaction(
        _credentials!,
        transaction,
        chainId: 84532,
      );

      print('✅ Withdraw transaction sent: $txHash');
      print('⏳ Waiting for transaction receipt...');

      // Wait for transaction to be mined
      TransactionReceipt? receipt;
      int attempts = 0;
      const maxAttempts = 30; // 30 seconds max

      while (receipt == null && attempts < maxAttempts) {
        await Future.delayed(const Duration(seconds: 1));
        try {
          receipt = await _client!.getTransactionReceipt(txHash);
          if (receipt != null) {
            print(
              '✅ Withdraw transaction mined in block ${receipt.blockNumber}',
            );
            break;
          }
        } catch (e) {
          // Receipt not available yet
        }
        attempts++;
        print(
          '⏳ Waiting for withdraw confirmation... ($attempts/$maxAttempts)',
        );
      }

      if (receipt == null) {
        print(
          '⚠️ Withdraw transaction sent but receipt not received yet: $txHash',
        );
      }

      return txHash;
    } catch (e) {
      throw Exception('Failed to withdraw from personal vault: $e');
    }
  }

  /// Transfer to shared vault
  Future<String> transferToSharedVault(int certificateId, BigInt amount) async {
    if (_client == null || _contract == null) await initialize();
    if (_credentials == null) throw Exception('Wallet not connected');

    try {
      final function = _contract!.function('transferToSharedVault');

      final transaction = Transaction.callContract(
        contract: _contract!,
        function: function,
        parameters: [BigInt.from(certificateId), amount],
      );

      print('🔄 Sending transfer to shared vault transaction...');
      final txHash = await _client!.sendTransaction(
        _credentials!,
        transaction,
        chainId: 84532,
      );

      print('✅ Transfer to shared vault transaction sent: $txHash');
      print('⏳ Waiting for transaction receipt...');

      // Wait for transaction to be mined
      TransactionReceipt? receipt;
      int attempts = 0;
      const maxAttempts = 30; // 30 seconds max

      while (receipt == null && attempts < maxAttempts) {
        await Future.delayed(const Duration(seconds: 1));
        try {
          receipt = await _client!.getTransactionReceipt(txHash);
          if (receipt != null) {
            print(
              '✅ Transfer to shared vault transaction mined in block ${receipt.blockNumber}',
            );
            break;
          }
        } catch (e) {
          // Receipt not available yet
        }
        attempts++;
        print(
          '⏳ Waiting for transfer confirmation... ($attempts/$maxAttempts)',
        );
      }

      if (receipt == null) {
        print(
          '⚠️ Transfer transaction sent but receipt not received yet: $txHash',
        );
      }

      return txHash;
    } catch (e) {
      throw Exception('Failed to transfer to shared vault: $e');
    }
  }

  /// Get shared vault info
  Future<SharedVaultInfoModel> getSharedVaultInfo(int certificateId) async {
    print('🔄 getSharedVaultInfo called for certificate: $certificateId');
    if (_client == null || _contract == null) await initialize();

    try {
      final function = _contract!.function('getSharedVaultInfo');
      final result = await _client!.call(
        contract: _contract!,
        function: function,
        params: [BigInt.from(certificateId)],
      );

      print('🔍 Shared vault info result: $result');

      if (result.length >= 5) {
        final info = SharedVaultInfoModel(
          totalBalance: result[0] as BigInt,
          myContribution: result[1] as BigInt,
          partnerContribution: result[2] as BigInt,
          partnerA: (result[3] as EthereumAddress).hex,
          partnerB: (result[4] as EthereumAddress).hex,
        );

        print(
          '✅ getSharedVaultInfo parsed: total=${info.totalBalance}, my=${info.myContribution}, partner=${info.partnerContribution}',
        );
        return info;
      } else {
        throw Exception('Invalid response from getSharedVaultInfo');
      }
    } catch (e) {
      print('💥 Error in getSharedVaultInfo: $e');
      // Return zero values if contract call fails
      return SharedVaultInfoModel(
        totalBalance: BigInt.zero,
        myContribution: BigInt.zero,
        partnerContribution: BigInt.zero,
        partnerA: '',
        partnerB: '',
      );
    }
  }

  /// Transfer to shared vault
  Future<String> transferToShared(BigInt amount) async {
    if (_client == null || _contract == null) await initialize();
    if (_credentials == null) throw Exception('Wallet not connected');

    try {
      final function = _contract!.function('transferToShared');

      final transaction = Transaction.callContract(
        contract: _contract!,
        function: function,
        parameters: [amount],
      );

      final txHash = await _client!.sendTransaction(
        _credentials!,
        transaction,
        chainId: 84532,
      );

      return txHash;
    } catch (e) {
      throw Exception('Failed to transfer to shared vault: $e');
    }
  }

  /// Helper: Get shortened address
  String _getShortAddress(String address) {
    if (address.length < 10) return address;
    return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
  }

  /// Dispose
  void dispose() {
    _client?.dispose();
  }
}
