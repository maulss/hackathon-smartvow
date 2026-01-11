import 'package:flutter/material.dart';
import '../constants/color_constant.dart';
import '../widgets/custom_bottom_nav.dart';

// Import pages (akan dibuat placeholder dulu)
import '../../features/dashboard/pages/dashboard_page.dart';
import '../../features/smart_prenup/pages/smart_prenup_page.dart';
import '../../features/assets_virtualizer/pages/assets_virtualizer_page.dart';
import '../../features/marriage_certificate/pages/marriage_certificate_page.dart';
import '../../features/shared_vault/pages/shared_vault_page.dart';

/// Main Navigation Screen dengan Bottom Navigation Bar
/// Mengelola navigasi antara 5 halaman utama aplikasi
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // List of pages
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const DashboardPage(),
      const SmartPrenupPage(),
      const AssetsVirtualizerPage(),
      const MarriageCertificatePage(),
      const SharedVaultPage(),
    ];
  }

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

/// Alternative: Main Navigation dengan FAB di tengah
class MainNavigationWithFAB extends StatefulWidget {
  const MainNavigationWithFAB({super.key});

  @override
  State<MainNavigationWithFAB> createState() => _MainNavigationWithFABState();
}

class _MainNavigationWithFABState extends State<MainNavigationWithFAB> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const DashboardPage(),
      const SmartPrenupPage(),
      const AssetsVirtualizerPage(), // Center page
      const MarriageCertificatePage(),
      const SharedVaultPage(),
    ];
  }

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onCenterTap() {
    setState(() {
      _currentIndex = 2; // Asset Virtualizer page
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavWithFAB(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
        onCenterTap: _onCenterTap,
      ),
      // Floating Action Button di tengah
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.blockchainGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _onCenterTap,
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(
            Icons.inventory_2_rounded,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
