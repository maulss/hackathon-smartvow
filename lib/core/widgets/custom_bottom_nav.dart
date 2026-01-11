import 'package:flutter/material.dart';
import '../constants/color_constant.dart';

/// Custom Bottom Navigation Bar untuk SmartVow DAPP
/// Menggunakan color palette dan theme yang sudah didefinisikan
class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.surfaceDark : AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                index: 0,
                icon: Icons.dashboard_rounded,
                label: 'Dashboard',
                isActive: currentIndex == 0,
              ),
              _buildNavItem(
                context,
                index: 1,
                icon: Icons.description_rounded,
                label: 'Prenup',
                isActive: currentIndex == 1,
              ),
              _buildNavItem(
                context,
                index: 2,
                icon: Icons.inventory_2_rounded,
                label: 'Asset',
                isActive: currentIndex == 2,
                isCenter: true, // Center item with special styling
              ),
              _buildNavItem(
                context,
                index: 3,
                icon: Icons.card_membership_rounded,
                label: 'Certificate',
                isActive: currentIndex == 3,
              ),
              _buildNavItem(
                context,
                index: 4,
                icon: Icons.folder_shared_rounded,
                label: 'Vault',
                isActive: currentIndex == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    required bool isActive,
    bool isCenter = false,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Warna untuk item aktif dan tidak aktif
    final Color activeColor = isCenter ? AppColors.secondary : AppColors.primary;
    final Color inactiveColor = isDarkMode ? AppColors.neutral500 : AppColors.neutral400;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          decoration: BoxDecoration(
            // Background untuk item aktif
            color: isActive
                ? activeColor.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon dengan top indicator
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    icon,
                    size: isActive ? 24 : 22,
                    color: isActive ? activeColor : inactiveColor,
                  ),
                  // Top indicator bar
                  if (isActive)
                    Positioned(
                      top: -8,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 20,
                          height: 3,
                          decoration: BoxDecoration(
                            color: activeColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              // Label
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isActive ? 10 : 9,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive ? activeColor : inactiveColor,
                  letterSpacing: 0.1,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Alternative: Bottom Navigation dengan Floating Action Button di tengah
class CustomBottomNavWithFAB extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onCenterTap;

  const CustomBottomNavWithFAB({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onCenterTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.surfaceDark : AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                index: 0,
                icon: Icons.dashboard_rounded,
                label: 'Dashboard',
                isActive: currentIndex == 0,
              ),
              _buildNavItem(
                context,
                index: 1,
                icon: Icons.description_rounded,
                label: 'Prenup',
                isActive: currentIndex == 1,
              ),
              // Center FAB
              const SizedBox(width: 56), // Space for FAB
              _buildNavItem(
                context,
                index: 3,
                icon: Icons.card_membership_rounded,
                label: 'Certificate',
                isActive: currentIndex == 3,
              ),
              _buildNavItem(
                context,
                index: 4,
                icon: Icons.folder_shared_rounded,
                label: 'Vault',
                isActive: currentIndex == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color activeColor = AppColors.primary;
    final Color inactiveColor = isDarkMode ? AppColors.neutral500 : AppColors.neutral400;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          decoration: BoxDecoration(
            color: isActive
                ? activeColor.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon dengan top indicator
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    icon,
                    size: isActive ? 24 : 22,
                    color: isActive ? activeColor : inactiveColor,
                  ),
                  // Top indicator bar
                  if (isActive)
                    Positioned(
                      top: -8,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 20,
                          height: 3,
                          decoration: BoxDecoration(
                            color: activeColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              // Label
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: isActive ? 10 : 9,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive ? activeColor : inactiveColor,
                  letterSpacing: 0.1,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
