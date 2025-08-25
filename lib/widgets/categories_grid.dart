import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/data/models/category_model.dart';
import 'package:hosta_app/generated/app_localizations.dart';

class CategoriesGrid extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function(int) onCategoryTap;
  final bool isDark;

  const CategoriesGrid({
    super.key,
    required this.categories,
    required this.onCategoryTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _CategoryItem(
          category: category,
          index: index,
          isDark: isDark,
          onTap: () => onCategoryTap(index),
        );
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final int index;
  final bool isDark;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.category,
    required this.index,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.dark : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? AppColors.white.withAlpha((255 * 0.2).toInt())
                : AppColors.boxBorder,
            width: 1.0,
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(category.icon, width: 35, height: 35),
            const SizedBox(height: 8),
            Text(
              category.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: isDark ? AppColors.white : AppColors.dark,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (category.serviceCount > 0) ...[
              const SizedBox(height: 2),
              Text(
                '${category.serviceCount} ${AppLocalizations.of(context)?.services_count ?? 'services'}',
                style: TextStyle(
                  fontSize: 9,
                  color: isDark
                      ? AppColors.white.withAlpha((255 * 0.7).toInt())
                      : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
