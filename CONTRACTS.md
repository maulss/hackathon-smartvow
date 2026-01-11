# SmartVow Contract API Documentation

Dokumentasi lengkap untuk integrasi SmartVow contract di aplikasi Mobile (Flutter/React Native/etc).

## Contract Info

| Property | Value |
|----------|-------|
| Contract Address | `0x00A263B85F7212BaBF0C1B1A542098D936bD14de` |
| Network | Base Sepolia Testnet |
| Chain ID | 84532 |
| RPC URL | https://sepolia.base.org |
| Block Explorer | https://sepolia.basescan.org/address/0x00A263B85F7212BaBF0C1B1A542098D936bD14de |

---

## Enums

### VowStatus
Status perjanjian pra-nikah.

| Value | Name | Deskripsi |
|-------|------|-----------|
| 0 | Draft | Perjanjian baru dibuat, belum ada yang TTD |
| 1 | PendingSignatures | Menunggu TTD dari salah satu/kedua partner |
| 2 | Active | Perjanjian aktif, escrow terkunci |
| 3 | Breached | Ada pelanggaran yang dilaporkan |
| 4 | Resolved | Perjanjian selesai, dana sudah didistribusikan |
| 5 | Terminated | Perjanjian dibatalkan oleh mediator |

### ConditionType
Jenis kondisi/pelanggaran dalam perjanjian.

| Value | Name | Deskripsi |
|-------|------|-----------|
| 0 | Infidelity | Perselingkuhan |
| 1 | KDRT | Kekerasan Dalam Rumah Tangga |
| 2 | Financial | Masalah Keuangan |
| 3 | Custom | Kondisi Kustom |

---

## Constants

| Constant | Value | Deskripsi |
|----------|-------|-----------|
| MIN_ESCROW | 0.001 ETH | Minimum escrow untuk aktivasi perjanjian |
| BASIS_POINTS | 10000 | 100% = 10000, 70% = 7000, 1% = 100 |

---

## Structs

### Vow (Perjanjian)
```
{
  id: uint256              // ID unik perjanjian
  partnerA: address        // Alamat wallet Partner A (pembuat)
  partnerB: address        // Alamat wallet Partner B (diundang)
  escrowBalance: uint256   // Saldo escrow yang terkunci (dalam wei)
  pendingEscrowAmount: uint256  // Escrow yang pending (menunggu aktivasi)
  status: uint8            // Status perjanjian (lihat VowStatus)
  createdAt: uint256       // Timestamp pembuatan (unix)
  activatedAt: uint256     // Timestamp aktivasi (unix)
  partnerASigned: bool     // Apakah Partner A sudah TTD
  partnerBSigned: bool     // Apakah Partner B sudah TTD
  metadataURI: string      // URI metadata (IPFS)
}
```

### Condition (Kondisi Pelanggaran)
```
{
  id: uint256              // ID unik kondisi
  conditionType: uint8     // Jenis kondisi (lihat ConditionType)
  description: string      // Deskripsi kondisi
  penaltyPercentage: uint256  // Persentase penalti (dalam basis points)
  isTriggered: bool        // Apakah kondisi sudah terpicu
}
```

---

## Events

Events yang di-emit oleh contract. Gunakan untuk tracking transaksi di mobile app.

### VowCreated
```solidity
event VowCreated(uint256 indexed vowId, address indexed partnerA, address indexed partnerB)
```
**Kapan di-emit:** Saat perjanjian baru dibuat
**Kegunaan:** Notifikasi ke Partner B bahwa ada undangan perjanjian

### VowSigned
```solidity
event VowSigned(uint256 indexed vowId, address indexed signer)
```
**Kapan di-emit:** Saat partner menandatangani perjanjian
**Kegunaan:** Tracking siapa yang sudah TTD

### VowActivated
```solidity
event VowActivated(uint256 indexed vowId, uint256 escrowAmount)
```
**Kapan di-emit:** Saat perjanjian diaktifkan dan escrow terkunci
**Kegunaan:** Konfirmasi perjanjian sudah aktif

### EscrowDeposited
```solidity
event EscrowDeposited(uint256 indexed vowId, address indexed depositor, uint256 amount)
```
**Kapan di-emit:** Saat ada deposit escrow ke perjanjian
**Kegunaan:** Tracking deposit escrow

### ConditionAdded
```solidity
event ConditionAdded(uint256 indexed vowId, uint256 conditionId, uint8 conditionType)
```
**Kapan di-emit:** Saat kondisi baru ditambahkan ke perjanjian
**Kegunaan:** Tracking kondisi yang ditambahkan

### PersonalDeposit
```solidity
event PersonalDeposit(address indexed user, uint256 amount)
```
**Kapan di-emit:** Saat ada deposit ke brankas pribadi
**Kegunaan:** Tracking saldo brankas pribadi

### SharedDeposit
```solidity
event SharedDeposit(uint256 indexed certificateId, address indexed user, uint256 amount)
```
**Kapan di-emit:** Saat ada deposit ke brankas bersama
**Kegunaan:** Tracking saldo brankas bersama per certificate

### PersonalWithdraw
```solidity
event PersonalWithdraw(address indexed user, uint256 amount)
```
**Kapan di-emit:** Saat ada withdraw dari brankas pribadi
**Kegunaan:** Tracking penarikan dana

### CertificateRegistered
```solidity
event CertificateRegistered(uint256 indexed certificateId, address indexed partnerA, address indexed partnerB)
```
**Kapan di-emit:** Saat certificate didaftarkan (otomatis saat mint NFT)
**Kegunaan:** Konfirmasi pasangan terdaftar di sistem

### ClaimSubmitted
```solidity
event ClaimSubmitted(uint256 indexed vowId, address indexed claimant, string claimType)
```
**Kapan di-emit:** Saat klaim diajukan
**Kegunaan:** Notifikasi ada klaim baru

### ClaimApproved
```solidity
event ClaimApproved(uint256 indexed vowId, address indexed claimant, uint256 amount)
```
**Kapan di-emit:** Saat klaim disetujui dan dana didistribusikan
**Kegunaan:** Konfirmasi klaim berhasil

---

## Functions - READ (View)

Fungsi-fungsi untuk membaca data dari blockchain. Tidak membutuhkan gas fee.

---

### getMyPersonalVault()
**Deskripsi:** Mendapatkan saldo brankas pribadi user yang sedang login

**Parameters:** Tidak ada (otomatis menggunakan address caller)

**Returns:** `uint256` - Saldo dalam wei

**Contoh Response:** `1000000000000000000` (= 1 ETH)

**Kapan Digunakan:** 
- Menampilkan saldo brankas pribadi di dashboard
- Cek saldo sebelum transfer ke brankas bersama

**ABI:**
```json
"function getMyPersonalVault() view returns (uint256)"
```

---

### getMyVaultSummary()
**Deskripsi:** Mendapatkan ringkasan semua vault user (pribadi + total shared)

**Parameters:** Tidak ada

**Returns:**
- `personalBalance: uint256` - Saldo brankas pribadi (wei)
- `totalSharedBalance: uint256` - Total saldo semua brankas bersama (wei)
- `certificateCount: uint256` - Jumlah certificate yang dimiliki

**Kapan Digunakan:**
- Dashboard utama untuk overview keuangan
- Menampilkan total aset user

**ABI:**
```json
"function getMyVaultSummary() view returns (uint256 personalBalance, uint256 totalSharedBalance, uint256 certificateCount)"
```

---

### getMyCertificates()
**Deskripsi:** Mendapatkan daftar certificate ID yang dimiliki user

**Parameters:** Tidak ada

**Returns:** `uint256[]` - Array of certificate IDs

**Contoh Response:** `[1, 3, 5]`

**Kapan Digunakan:**
- Menampilkan daftar pasangan/sertifikat
- Dropdown pilihan certificate saat transfer ke brankas bersama

**ABI:**
```json
"function getMyCertificates() view returns (uint256[])"
```

---

### getSharedVaultInfo(uint256 _certificateId)
**Deskripsi:** Mendapatkan info lengkap brankas bersama untuk certificate tertentu

**Parameters:**
- `_certificateId: uint256` - ID certificate

**Returns:**
- `totalBalance: uint256` - Total saldo brankas bersama (wei)
- `myContribution: uint256` - Kontribusi saya (wei)
- `partnerContribution: uint256` - Kontribusi pasangan (wei)
- `partnerA: address` - Alamat Partner A
- `partnerB: address` - Alamat Partner B

**Kapan Digunakan:**
- Detail brankas bersama
- Menampilkan kontribusi masing-masing pasangan

**Catatan:** Hanya bisa dipanggil oleh partner di certificate tersebut

**ABI:**
```json
"function getSharedVaultInfo(uint256 _certificateId) view returns (uint256 totalBalance, uint256 myContribution, uint256 partnerContribution, address partnerA, address partnerB)"
```

---

### getSharedVaultBalance(uint256 _certificateId)
**Deskripsi:** Mendapatkan total saldo brankas bersama

**Parameters:**
- `_certificateId: uint256` - ID certificate

**Returns:** `uint256` - Total saldo (wei)

**Kapan Digunakan:**
- Quick check saldo brankas bersama
- Validasi sebelum buat perjanjian

**ABI:**
```json
"function getSharedVaultBalance(uint256 _certificateId) view returns (uint256)"
```

---

### getAllMySharedVaults()
**Deskripsi:** Mendapatkan semua brankas bersama yang user punya akses

**Parameters:** Tidak ada

**Returns:**
- `certificateIds: uint256[]` - Array of certificate IDs
- `balances: uint256[]` - Array of balances (wei)
- `myContributions: uint256[]` - Array of my contributions (wei)

**Kapan Digunakan:**
- List semua brankas bersama di halaman vault
- Overview semua pasangan dan saldo

**ABI:**
```json
"function getAllMySharedVaults() view returns (uint256[] certificateIds, uint256[] balances, uint256[] myContributions)"
```

---

### getVow(uint256 _vowId)
**Deskripsi:** Mendapatkan detail perjanjian

**Parameters:**
- `_vowId: uint256` - ID perjanjian

**Returns:** Struct Vow (lihat bagian Structs)

**Kapan Digunakan:**
- Detail perjanjian
- Cek status perjanjian
- Menampilkan info escrow

**ABI:**
```json
"function getVow(uint256 _vowId) view returns (tuple(uint256 id, address partnerA, address partnerB, uint256 escrowBalance, uint256 pendingEscrowAmount, uint8 status, uint256 createdAt, uint256 activatedAt, bool partnerASigned, bool partnerBSigned, string metadataURI))"
```

---

### getConditions(uint256 _vowId)
**Deskripsi:** Mendapatkan daftar kondisi/pelanggaran dalam perjanjian

**Parameters:**
- `_vowId: uint256` - ID perjanjian

**Returns:** Array of Condition structs

**Kapan Digunakan:**
- Menampilkan syarat-syarat perjanjian
- Review kondisi sebelum TTD

**ABI:**
```json
"function getConditions(uint256 _vowId) view returns (tuple(uint256 id, uint8 conditionType, string description, uint256 penaltyPercentage, bool isTriggered)[])"
```

---

### getUserVows(address _user)
**Deskripsi:** Mendapatkan daftar vow ID yang dimiliki user

**Parameters:**
- `_user: address` - Alamat wallet user

**Returns:** `uint256[]` - Array of vow IDs

**Kapan Digunakan:**
- List perjanjian di dashboard
- History perjanjian

**ABI:**
```json
"function getUserVows(address _user) view returns (uint256[])"
```

---

### isCertificatePartner(uint256 _certId, address _user)
**Deskripsi:** Cek apakah user adalah partner di certificate tertentu

**Parameters:**
- `_certId: uint256` - ID certificate
- `_user: address` - Alamat wallet user

**Returns:** `bool` - true jika user adalah partner

**Kapan Digunakan:**
- Validasi akses ke brankas bersama
- Cek relasi pasangan

**ABI:**
```json
"function isCertificatePartner(uint256 _certId, address _user) view returns (bool)"
```

---

### getCertificatePartners(uint256 _certId)
**Deskripsi:** Mendapatkan alamat kedua partner di certificate

**Parameters:**
- `_certId: uint256` - ID certificate

**Returns:**
- `partnerA: address` - Alamat Partner A
- `partnerB: address` - Alamat Partner B

**Catatan:** Hanya bisa dipanggil oleh partner di certificate

**ABI:**
```json
"function getCertificatePartners(uint256 _certId) view returns (address partnerA, address partnerB)"
```

---

### vowClaimed(uint256 _vowId)
**Deskripsi:** Cek apakah perjanjian sudah pernah di-claim

**Parameters:**
- `_vowId: uint256` - ID perjanjian

**Returns:** `bool` - true jika sudah di-claim

**Kapan Digunakan:**
- Validasi sebelum submit claim
- Menampilkan status claim

**ABI:**
```json
"function vowClaimed(uint256 _vowId) view returns (bool)"
```

---

### claimant(uint256 _vowId)
**Deskripsi:** Mendapatkan alamat yang mengajukan klaim

**Parameters:**
- `_vowId: uint256` - ID perjanjian

**Returns:** `address` - Alamat claimant

**ABI:**
```json
"function claimant(uint256 _vowId) view returns (address)"
```

---

### claimPercentage(uint256 _vowId)
**Deskripsi:** Mendapatkan persentase klaim (dalam basis points)

**Parameters:**
- `_vowId: uint256` - ID perjanjian

**Returns:** `uint256` - Persentase dalam basis points (7000 = 70%)

**ABI:**
```json
"function claimPercentage(uint256 _vowId) view returns (uint256)"
```

---

## Functions - WRITE (Transaction)

Fungsi-fungsi yang mengubah state blockchain. Membutuhkan gas fee dan signature dari wallet.

---

### depositPersonal()
**Deskripsi:** Deposit ETH ke brankas pribadi

**Parameters:** Tidak ada (amount dikirim via `msg.value`)

**Value:** Amount ETH yang akan di-deposit (dalam wei)

**Returns:** Transaction hash

**Events yang di-emit:** `PersonalDeposit(address user, uint256 amount)`

**Kapan Digunakan:**
- User ingin menyimpan ETH ke brankas pribadi
- Persiapan sebelum transfer ke brankas bersama

**Contoh (Flutter/web3dart):**
```dart
final tx = await contract.send(
  'depositPersonal',
  [],
  Transaction(value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 0.1)),
);
```

**ABI:**
```json
"function depositPersonal() payable"
```

---

### withdrawPersonal(uint256 _amount)
**Deskripsi:** Withdraw ETH dari brankas pribadi ke wallet

**Parameters:**
- `_amount: uint256` - Jumlah yang akan ditarik (dalam wei)

**Returns:** Transaction hash

**Events yang di-emit:** `PersonalWithdraw(address user, uint256 amount)`

**Validasi:**
- Amount harus > 0
- Saldo brankas pribadi harus cukup

**Kapan Digunakan:**
- User ingin menarik dana dari brankas pribadi

**ABI:**
```json
"function withdrawPersonal(uint256 _amount)"
```

---

### transferToSharedVault(uint256 _certificateId, uint256 _amount)
**Deskripsi:** Transfer dari brankas pribadi ke brankas bersama

**Parameters:**
- `_certificateId: uint256` - ID certificate tujuan
- `_amount: uint256` - Jumlah yang akan ditransfer (dalam wei)

**Returns:** Transaction hash

**Events yang di-emit:** `SharedDeposit(uint256 certificateId, address user, uint256 amount)`

**Validasi:**
- User harus partner di certificate tersebut
- Saldo brankas pribadi harus cukup

**Kapan Digunakan:**
- Menambah dana ke brankas bersama pasangan
- Persiapan escrow untuk perjanjian

**ABI:**
```json
"function transferToSharedVault(uint256 _certificateId, uint256 _amount)"
```

---

### depositToSharedVault(uint256 _certificateId)
**Deskripsi:** Deposit langsung ke brankas bersama (tanpa lewat brankas pribadi)

**Parameters:**
- `_certificateId: uint256` - ID certificate tujuan

**Value:** Amount ETH yang akan di-deposit (dalam wei)

**Returns:** Transaction hash

**Events yang di-emit:** `SharedDeposit(uint256 certificateId, address user, uint256 amount)`

**Validasi:**
- User harus partner di certificate tersebut

**Kapan Digunakan:**
- Quick deposit ke brankas bersama

**ABI:**
```json
"function depositToSharedVault(uint256 _certificateId) payable"
```

---

### createVow(address _partnerB, string _metadataURI)
**Deskripsi:** Membuat perjanjian baru (draft)

**Parameters:**
- `_partnerB: address` - Alamat wallet pasangan
- `_metadataURI: string` - URI metadata (biasanya IPFS)

**Returns:** `uint256` - ID perjanjian yang dibuat

**Events yang di-emit:** `VowCreated(uint256 vowId, address partnerA, address partnerB)`

**Kapan Digunakan:**
- Membuat perjanjian sederhana tanpa escrow langsung
- Draft perjanjian untuk ditambah kondisi nanti

**ABI:**
```json
"function createVow(address _partnerB, string _metadataURI) returns (uint256)"
```

---

### createVowWithCertificateEscrow(...)
**Deskripsi:** Membuat perjanjian lengkap dengan kondisi dan escrow dalam 1 transaksi (untuk Partner A)

**Parameters:**
- `_partnerB: address` - Alamat wallet pasangan
- `_metadataURI: string` - URI metadata (IPFS)
- `_conditionTypes: uint8[]` - Array jenis kondisi (0-3)
- `_descriptions: string[]` - Array deskripsi kondisi
- `_penaltyPercentages: uint256[]` - Array persentase penalti (dalam basis points)
- `_escrowAmount: uint256` - Jumlah escrow (dalam wei)
- `_certificateId: uint256` - ID certificate

**Returns:** `uint256` - ID perjanjian yang dibuat

**Events yang di-emit:**
- `VowCreated(uint256 vowId, address partnerA, address partnerB)`
- `ConditionAdded(uint256 vowId, uint256 conditionId, uint8 conditionType)` (per kondisi)
- `VowSigned(uint256 vowId, address signer)`

**Validasi:**
- Kedua partner harus ada di certificate
- Saldo brankas bersama harus cukup untuk escrow
- Escrow minimal 0.001 ETH

**Kapan Digunakan:**
- Partner A membuat perjanjian lengkap
- Status langsung jadi PendingSignatures (menunggu Partner B)

**Contoh Parameters:**
```javascript
{
  _partnerB: "0x123...",
  _metadataURI: "ipfs://Qm...",
  _conditionTypes: [0, 2],  // Infidelity, Financial
  _descriptions: ["Tidak boleh selingkuh", "Tidak boleh berhutang tanpa izin"],
  _penaltyPercentages: [7000, 3000],  // 70%, 30%
  _escrowAmount: "1000000000000000000",  // 1 ETH
  _certificateId: 1
}
```

**ABI:**
```json
"function createVowWithCertificateEscrow(address _partnerB, string _metadataURI, uint8[] _conditionTypes, string[] _descriptions, uint256[] _penaltyPercentages, uint256 _escrowAmount, uint256 _certificateId) returns (uint256)"
```

---

### signAndActivateWithCertificate(uint256 _vowId, uint256 _certificateId)
**Deskripsi:** TTD dan aktivasi perjanjian dalam 1 transaksi (untuk Partner B)

**Parameters:**
- `_vowId: uint256` - ID perjanjian
- `_certificateId: uint256` - ID certificate

**Returns:** Transaction hash

**Events yang di-emit:**
- `VowSigned(uint256 vowId, address signer)`
- `EscrowDeposited(uint256 vowId, address depositor, uint256 amount)`
- `VowActivated(uint256 vowId, uint256 escrowAmount)`

**Validasi:**
- Status perjanjian harus PendingSignatures
- Ada pending escrow yang sudah di-set Partner A
- Saldo brankas bersama harus cukup

**Kapan Digunakan:**
- Partner B menyetujui perjanjian
- Escrow langsung terkunci dari brankas bersama
- Status langsung jadi Active

**ABI:**
```json
"function signAndActivateWithCertificate(uint256 _vowId, uint256 _certificateId)"
```

---

### signVow(uint256 _vowId)
**Deskripsi:** Menandatangani perjanjian (tanpa aktivasi)

**Parameters:**
- `_vowId: uint256` - ID perjanjian

**Returns:** Transaction hash

**Events yang di-emit:** `VowSigned(uint256 vowId, address signer)`

**Kapan Digunakan:**
- TTD perjanjian draft
- Jika ingin TTD dan aktivasi terpisah

**ABI:**
```json
"function signVow(uint256 _vowId)"
```

---

### addCondition(uint256 _vowId, uint8 _conditionType, string _description, uint256 _penaltyPercentage)
**Deskripsi:** Menambah kondisi ke perjanjian draft

**Parameters:**
- `_vowId: uint256` - ID perjanjian
- `_conditionType: uint8` - Jenis kondisi (0-3)
- `_description: string` - Deskripsi kondisi
- `_penaltyPercentage: uint256` - Persentase penalti (basis points)

**Returns:** Transaction hash

**Events yang di-emit:** `ConditionAdded(uint256 vowId, uint256 conditionId, uint8 conditionType)`

**Validasi:**
- Status perjanjian harus Draft
- Penalty tidak boleh lebih dari 100% (10000 basis points)

**Kapan Digunakan:**
- Menambah syarat ke perjanjian yang sudah dibuat

**ABI:**
```json
"function addCondition(uint256 _vowId, uint8 _conditionType, string _description, uint256 _penaltyPercentage)"
```

---

### addEscrow(uint256 _vowId)
**Deskripsi:** Menambah escrow ke perjanjian yang sudah aktif

**Parameters:**
- `_vowId: uint256` - ID perjanjian

**Value:** Amount ETH yang akan ditambahkan (dalam wei)

**Returns:** Transaction hash

**Events yang di-emit:** `EscrowDeposited(uint256 vowId, address depositor, uint256 amount)`

**Validasi:**
- Status perjanjian harus Active

**Kapan Digunakan:**
- Menambah dana escrow setelah perjanjian aktif

**ABI:**
```json
"function addEscrow(uint256 _vowId) payable"
```

---

### submitInternalClaim(uint256 _vowId, uint256 _penaltyPercentage)
**Deskripsi:** Mengajukan klaim internal dan langsung distribusi dana ke brankas pribadi

**Parameters:**
- `_vowId: uint256` - ID perjanjian
- `_penaltyPercentage: uint256` - Persentase yang diklaim (dalam basis points)

**Returns:** Transaction hash

**Events yang di-emit:**
- `ClaimSubmitted(uint256 vowId, address claimant, string claimType)`
- `ClaimApproved(uint256 vowId, address claimant, uint256 amount)`
- `PersonalDeposit(address user, uint256 amount)` (untuk claimant)
- `PersonalDeposit(address user, uint256 amount)` (untuk partner lain)

**Validasi:**
- Status perjanjian harus Active
- Belum pernah di-claim sebelumnya
- Penalty tidak boleh lebih dari 100%

**Alur Dana:**
1. Claimant mendapat `escrow * penaltyPercentage / 10000` → masuk ke brankas pribadi claimant
2. Partner lain mendapat sisanya → masuk ke brankas pribadi partner

**Contoh:**
- Escrow: 1 ETH
- Penalty: 7000 (70%)
- Claimant dapat: 0.7 ETH ke brankas pribadi
- Partner lain dapat: 0.3 ETH ke brankas pribadi

**Kapan Digunakan:**
- Mengajukan klaim pelanggaran
- Dana langsung didistribusikan (auto-approve)

**ABI:**
```json
"function submitInternalClaim(uint256 _vowId, uint256 _penaltyPercentage)"
```

---

### submitAIClaim(uint256 _vowId, string _reason, string _evidence, uint256 _timestamp)
**Deskripsi:** Mengajukan klaim dengan verifikasi AI (membutuhkan approval mediator)

**Parameters:**
- `_vowId: uint256` - ID perjanjian
- `_reason: string` - Alasan klaim
- `_evidence: string` - Bukti (bisa URL atau deskripsi)
- `_timestamp: uint256` - Timestamp kejadian (unix)

**Returns:** Transaction hash

**Events yang di-emit:** `ClaimSubmitted(uint256 vowId, address claimant, string claimType)`

**Validasi:**
- Status perjanjian harus Active
- Belum pernah di-claim
- Reason tidak boleh kosong

**Catatan:** Dana tidak langsung didistribusikan, menunggu approval dari mediator

**Kapan Digunakan:**
- Klaim yang membutuhkan verifikasi lebih lanjut
- Kasus yang kompleks

**ABI:**
```json
"function submitAIClaim(uint256 _vowId, string _reason, string _evidence, uint256 _timestamp)"
```

---

### registerCertificate(uint256 _certificateId, address _partnerA, address _partnerB)
**Deskripsi:** Mendaftarkan certificate ke sistem SmartVow

**Parameters:**
- `_certificateId: uint256` - ID certificate dari MarriageCertificateNFT
- `_partnerA: address` - Alamat Partner A
- `_partnerB: address` - Alamat Partner B

**Returns:** Transaction hash

**Events yang di-emit:** `CertificateRegistered(uint256 certificateId, address partnerA, address partnerB)`

**Catatan:** Fungsi ini biasanya dipanggil otomatis oleh MarriageCertificateNFT saat mint. Tidak perlu dipanggil manual dari mobile app.

**ABI:**
```json
"function registerCertificate(uint256 _certificateId, address _partnerA, address _partnerB)"
```

---

## Alur Penggunaan (Flow)

### 1. Setup Awal
```
1. User A mint MarriageCertificateNFT dengan Partner B
   → Certificate otomatis ter-register di SmartVow
   → Kedua user sekarang punya akses ke brankas bersama
```

### 2. Deposit ke Brankas
```
1. User deposit ke brankas pribadi: depositPersonal()
2. User transfer ke brankas bersama: transferToSharedVault(certId, amount)
   ATAU
   User deposit langsung ke brankas bersama: depositToSharedVault(certId)
```

### 3. Buat Perjanjian (Partner A)
```
1. Partner A panggil createVowWithCertificateEscrow(...)
   - Set partner B, kondisi, dan escrow amount
   - Status: PendingSignatures
   - Partner A otomatis sudah TTD
```

### 4. Setuju Perjanjian (Partner B)
```
1. Partner B panggil signAndActivateWithCertificate(vowId, certId)
   - Partner B TTD
   - Escrow terkunci dari brankas bersama
   - Status: Active
```

### 5. Klaim (Jika Ada Pelanggaran)
```
1. Partner yang dirugikan panggil submitInternalClaim(vowId, penaltyBasisPoints)
   - Dana langsung didistribusikan ke brankas pribadi masing-masing
   - Status: Resolved
```

### 6. Withdraw
```
1. User panggil withdrawPersonal(amount)
   - Dana dari brankas pribadi masuk ke wallet
```

---

## Error Messages

| Error | Penyebab | Solusi |
|-------|----------|--------|
| "Must send ETH" | Deposit tanpa value | Tambahkan value saat transaksi |
| "Insufficient balance" | Saldo tidak cukup | Cek saldo sebelum transaksi |
| "Not a certificate partner" | Bukan partner di certificate | Gunakan certificate yang benar |
| "Insufficient shared vault" | Saldo brankas bersama tidak cukup | Deposit dulu ke brankas bersama |
| "Already claimed" | Perjanjian sudah di-claim | Tidak bisa claim 2x |
| "Invalid vow status" | Status perjanjian tidak sesuai | Cek status perjanjian |
| "Both must sign first" | Belum semua partner TTD | Tunggu partner lain TTD |
| "Already signed" | Sudah pernah TTD | Tidak perlu TTD lagi |

---

## Contoh Integrasi Flutter

```dart
import 'package:web3dart/web3dart.dart';

class SmartVowService {
  static const String contractAddress = '0x00A263B85F7212BaBF0C1B1A542098D936bD14de';
  static const String rpcUrl = 'https://sepolia.base.org';
  static const int chainId = 84532;
  
  late Web3Client _client;
  late DeployedContract _contract;
  late Credentials _credentials;
  
  // Get personal vault balance
  Future<BigInt> getMyPersonalVault() async {
    final result = await _client.call(
      contract: _contract,
      function: _contract.function('getMyPersonalVault'),
      params: [],
    );
    return result[0] as BigInt;
  }
  
  // Deposit to personal vault
  Future<String> depositPersonal(BigInt amountWei) async {
    final txHash = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _contract.function('depositPersonal'),
        parameters: [],
        value: EtherAmount.inWei(amountWei),
      ),
      chainId: chainId,
    );
    return txHash;
  }
  
  // Transfer to shared vault
  Future<String> transferToSharedVault(int certificateId, BigInt amountWei) async {
    final txHash = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _contract.function('transferToSharedVault'),
        parameters: [BigInt.from(certificateId), amountWei],
      ),
      chainId: chainId,
    );
    return txHash;
  }
  
  // Submit claim
  Future<String> submitInternalClaim(int vowId, int penaltyBasisPoints) async {
    final txHash = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _contract.function('submitInternalClaim'),
        parameters: [BigInt.from(vowId), BigInt.from(penaltyBasisPoints)],
      ),
      chainId: chainId,
    );
    return txHash;
  }
}
```

---

## Support

- Network: Base Sepolia Testnet
- Faucet: https://www.coinbase.com/faucets/base-ethereum-goerli-faucet
- Block Explorer: https://sepolia.basescan.org
