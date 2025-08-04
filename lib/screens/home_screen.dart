import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/widgets/app_bar.dart';
import 'package:hosta_app/widgets/image_slider.dart';
import 'package:hosta_app/widgets/city_picker_dialog.dart';
import 'package:hosta_app/widgets/search_field.dart';
import 'package:hosta_app/presentation/providers/category_provider.dart';
import 'package:hosta_app/data/models/category_model.dart';
import 'package:hosta_app/shared/widgets/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCity = 'Erbil';
  final List<String> cities = ['Erbil', 'Sulaymani', 'Dohuk'];
  final TextEditingController _searchController = TextEditingController();
  List<CategoryModel> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryProvider>().loadCategories();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onCategoryTap(int index) {
    final categories = _filteredCategories.isNotEmpty
        ? _filteredCategories
        : context.read<CategoryProvider>().categories;
    if (index < categories.length) {
      final category = categories[index];
      Navigator.pushNamed(
        context,
        '/category-details',
        arguments: {'category': category},
      );
    }
  }

  Future<void> _showCityPicker() async {
    await showCityPickerDialog(
      context: context,
      cities: cities,
      selectedCity: selectedCity,
      onSelected: (city) {
        setState(() {
          selectedCity = city;
        });
      },
    );
  }

  void _onSearchChanged(String query) {
    final categoryProvider = context.read<CategoryProvider>();
    final allCategories = categoryProvider.categories;
    if (query.isEmpty) {
      setState(() {
        _filteredCategories = allCategories;
      });
    } else {
      setState(() {
        _filteredCategories = allCategories.where((category) {
          return category.name.toLowerCase().contains(query.toLowerCase()) ||
              (category.description?.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ??
                  false);
        }).toList();
      });
    }
  }

  Widget _buildCategoriesHeader() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isDark ? AppColors.white : AppColors.dark,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(CategoryModel category, int index) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => _onCategoryTap(index),
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
                '${category.serviceCount} services',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          if (categoryProvider.isLoading) {
            return const LoadingWidget(message: 'Loading categories...');
          }
          if (categoryProvider.error != null) {
            return CustomErrorWidget(
              message: categoryProvider.error!,
              onRetry: () => categoryProvider.loadCategories(),
            );
          }
          if (categoryProvider.categories.isEmpty) {
            return const EmptyWidget(
              message: 'No categories available',
              icon: Icons.category_outlined,
            );
          }

          final categories = _filteredCategories.isNotEmpty
              ? _filteredCategories
              : categoryProvider.categories;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SearchField(
                        selectedCity: selectedCity,
                        onCityPickerPressed: _showCityPicker,
                        controller: _searchController,
                        onSearchChanged: _onSearchChanged,
                      ),
                      const SizedBox(height: 16),
                      const ImageSlider(),
                      const SizedBox(height: 24),
                      _buildCategoriesHeader(),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final startIndex = index * 3;
                    if (startIndex >= categories.length) {
                      return null;
                    }

                    final endIndex = (startIndex + 3).clamp(
                      0,
                      categories.length,
                    );
                    final rowCategories = categories.sublist(
                      startIndex,
                      endIndex,
                    );

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index < (categories.length / 3).ceil() - 1
                            ? 16
                            : 0,
                      ),
                      child: Row(
                        children: [
                          for (int i = 0; i < 3; i++) ...[
                            Expanded(
                              child: i < rowCategories.length
                                  ? _buildCategoryItem(
                                      rowCategories[i],
                                      startIndex + i,
                                    )
                                  : const SizedBox(),
                            ),
                            if (i < 2) const SizedBox(width: 16),
                          ],
                        ],
                      ),
                    );
                  }, childCount: (categories.length / 3).ceil()),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          );
        },
      ),
    );
  }
}
