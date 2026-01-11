import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../abi/contract_abi.dart';
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
  static const String _rpcUrl = 'https://sepolia.base.org'; // Base Sepolia Testnet
  // Atau gunakan mainnet: 'https://mainnet.base.org'

  /// Initialize Web3 client
  Future<void> initialize() async {
    await dotenv.load(fileName: '.env');

    // Initialize Web3 client
    _client = Web3Client(_rpcUrl, http.Client());

    // Get contract address from .env
    final contractAddress = dotenv.env['SMARTVOW_CONTRACT_ADDRESS'];
    if (contractAddress == null || contractAddress.isEmpty) {
      throw Exception('Contract address not found in .env file');
    }

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
      final address = await _credentials!.extractAddress();
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
    if (_client == null || _contract == null) await initialize();

    try {
      final function = _contract!.function('getUserVows');
      final result = await _client!.call(
        contract: _contract!,
        function: function,
        params: [EthereumAddress.fromHex(userAddress)],
      );

      final vowIds = result[0] as List<dynamic>;
      final vows = <VowModel>[];

      // Get detail untuk setiap vow
      for (final vowId in vowIds) {
        final vow = await getVow(BigInt.from(vowId));
        if (vow != null) {
          vows.add(vow);
        }
      }

      return vows;
    } catch (e) {
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

      // When contract returns a struct, web3dart gives us a List
      if (vowData is List) {
        return VowModel.fromContract(vowData);
      }

      return null;
    } catch (e) {
      print('Error in getVow: $e');
      throw Exception('Failed to get vow details: $e');
    }
  }

  /// Get vault balances
  Future<VaultBalancesModel> getVaultBalances(String userAddress) async {
    if (_client == null || _contract == null) await initialize();

    try {
      final function = _contract!.function('getVaultBalances');
      final result = await _client!.call(
        contract: _contract!,
        function: function,
        params: [EthereumAddress.fromHex(userAddress)],
      );

      return VaultBalancesModel.fromContract(result);
    } catch (e) {
      throw Exception('Failed to get vault balances: $e');
    }
  }

  /// Get partner from active vow
  Future<PartnerProfileModel?> getPartner(String userAddress) async {
    try {
      // Get user's vows
      final vows = await getUserVows(userAddress);

      // Find active vow
      final activeVow = vows.firstWhere(
        (vow) => vow.status == 1, // 1 = Active
        orElse: () => throw Exception('No active vow found'),
      );

      // Determine partner address
      final partnerAddress =
          activeVow.partnerA.toLowerCase() == userAddress.toLowerCase()
          ? activeVow.partnerB
          : activeVow.partnerA;

      // Check if both partners signed
      final isCertified = activeVow.partnerASigned && activeVow.partnerBSigned;

      // Create partner profile
      return PartnerProfileModel(
        address: partnerAddress,
        name: _getShortAddress(partnerAddress),
        isCertified: isCertified,
        lastActive: activeVow.activatedAt,
      );
    } catch (e) {
      // No active vow or partner found
      return null;
    }
  }

  /// Get dashboard data
  Future<DashboardDataModel> getDashboardData(String userAddress) async {
    if (_client == null || _contract == null) await initialize();

    print('=== Getting Dashboard Data for: $userAddress ===');

    try {
      // Get all data with error handling for each
      List<VowModel> vows = [];
      VaultBalancesModel? vaultBalances;
      PartnerProfileModel? partner;

      try {
        print('Fetching user vows...');
        vows = await getUserVows(userAddress);
        print('✓ Got ${vows.length} vows');
      } catch (e) {
        print('✗ Error getting user vows: $e');
        // Continue with empty vows
      }

      try {
        print('Fetching vault balances...');
        vaultBalances = await getVaultBalances(userAddress);
        print('✓ Got vault balances: Personal=${vaultBalances.personal}, Shared=${vaultBalances.totalShared}');
      } catch (e) {
        print('✗ Error getting vault balances: $e');
        // Use default vault balances
        vaultBalances = VaultBalancesModel(
          personal: BigInt.zero,
          sharedContribution: BigInt.zero,
          totalShared: BigInt.zero,
        );
      }

      try {
        print('Fetching partner...');
        partner = await getPartner(userAddress);
        print('✓ Got partner: ${partner?.name ?? "none"}');
      } catch (e) {
        print('✗ Error getting partner: $e');
        // No partner found, that's okay
        partner = null;
      }

      // Filter active vows
      final activeVows = vows.where((vow) => vow.status == 1).toList();
      
      print('=== Dashboard Data Summary ===');
      print('Total Vows: ${vows.length}');
      print('Active Vows: ${activeVows.length}');
      print('Partner: ${partner != null ? "Found" : "None"}');
      print('Vault Balances: ${vaultBalances.personal}');
      print('==============================');

      return DashboardDataModel(
        userAddress: userAddress,
        partner: partner,
        vaultBalances: vaultBalances,
        activeVows: activeVows,
        totalAgreements: vows.length,
        activeAgreements: activeVows.length,
        assetNFTCount: 0, // TODO: Implement NFT count
      );
    } catch (e) {
      print('✗ Failed to get dashboard data: $e');
      // Return default data instead of throwing
      return DashboardDataModel(
        userAddress: userAddress,
        partner: null,
        vaultBalances: VaultBalancesModel(
          personal: BigInt.zero,
          sharedContribution: BigInt.zero,
          totalShared: BigInt.zero,
        ),
        activeVows: [],
        totalAgreements: 0,
        activeAgreements: 0,
        assetNFTCount: 0,
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

      final txHash = await _client!.sendTransaction(
        _credentials!,
        transaction,
        chainId: 84532,
      );

      return txHash;
    } catch (e) {
      throw Exception('Failed to deposit to personal vault: $e');
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
