import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/color_constant.dart';

/// Reusable Shimmer Loading Widget
/// Widget loading dengan efek shimmer yang dapat digunakan di berbagai halaman
class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final BoxShape shape;

  const ShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  /// Shimmer untuk card rectangular
  ShimmerLoading.rectangular({
    super.key,
    required this.width,
    required this.height,
    double radius = 12,
  })  : borderRadius = BorderRadius.all(Radius.circular(radius)),
        shape = BoxShape.rectangle;

  /// Shimmer untuk circle/avatar
  const ShimmerLoading.circular({
    super.key,
    required double size,
  })  : width = size,
        height = size,
        borderRadius = null,
        shape = BoxShape.circle;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDarkMode ? AppColors.neutral700 : AppColors.neutral200,
      highlightColor: isDarkMode ? AppColors.neutral600 : AppColors.neutral100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isDarkMode ? AppColors.neutral700 : AppColors.neutral200,
          borderRadius: shape == BoxShape.rectangle ? borderRadius : null,
          shape: shape,
        ),
      ),
    );
  }
}

/// Shimmer loading untuk card profil pasangan
class PartnerProfileShimmer extends StatelessWidget {
  const PartnerProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.surfaceDark
            : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.neutral600
              : AppColors.neutral300,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar shimmer
              const ShimmerLoading.circular(size: 48),
              const SizedBox(width: 12),
              // Name and address shimmer
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading.rectangular(
                      width: 80,
                      height: 16,
                      radius: 4,
                    ),
                    const SizedBox(height: 8),
                    ShimmerLoading.rectangular(
                      width: double.infinity,
                      height: 12,
                      radius: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Additional info shimmer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: ShimmerLoading.rectangular(
                  width: 80,
                  height: 12,
                  radius: 4,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: ShimmerLoading.rectangular(
                  width: 60,
                  height: 12,
                  radius: 4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Shimmer loading untuk stats card
class StatsCardShimmer extends StatelessWidget {
  const StatsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.surfaceDark
            : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.neutral600
              : AppColors.neutral300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerLoading.rectangular(
                width: 80,
                height: 14,
                radius: 4,
              ),
              ShimmerLoading.rectangular(
                width: 32,
                height: 32,
                radius: 8,
              ),
            ],
          ),
          const SizedBox(height: 12),
          ShimmerLoading.rectangular(
            width: 120,
            height: 24,
            radius: 4,
          ),
          const SizedBox(height: 8),
          ShimmerLoading.rectangular(
            width: 150,
            height: 12,
            radius: 4,
          ),
        ],
      ),
    );
  }
}

/// Shimmer loading untuk list item
class ListItemShimmer extends StatelessWidget {
  final int itemCount;

  const ListItemShimmer({
    super.key,
    this.itemCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.surfaceDark
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.neutral600
                    : AppColors.neutral300,
              ),
            ),
            child: Row(
              children: [
                const ShimmerLoading.circular(size: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerLoading.rectangular(
                        width: double.infinity,
                        height: 14,
                        radius: 4,
                      ),
                      const SizedBox(height: 8),
                      ShimmerLoading.rectangular(
                        width: 150,
                        height: 12,
                        radius: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Shimmer loading untuk balance card
class BalanceCardShimmer extends StatelessWidget {
  const BalanceCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.blockchainGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoading.rectangular(
            width: 100,
            height: 14,
            radius: 4,
          ),
          const SizedBox(height: 12),
          ShimmerLoading.rectangular(
            width: 200,
            height: 32,
            radius: 4,
          ),
          const SizedBox(height: 8),
          ShimmerLoading.rectangular(
            width: 120,
            height: 12,
            radius: 4,
          ),
        ],
      ),
    );
  }
}

/// Shimmer loading untuk tabel/grid
class GridShimmer extends StatelessWidget {
  final int rows;
  final int columns;

  const GridShimmer({
    super.key,
    this.rows = 2,
    this.columns = 2,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: rows * columns,
      itemBuilder: (context, index) => const StatsCardShimmer(),
    );
  }
}
