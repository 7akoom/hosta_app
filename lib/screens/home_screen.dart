import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/widgets/app_bar.dart';
import 'package:hosta_app/widgets/image_slider.dart';
import 'package:hosta_app/widgets/city_picker_dialog.dart';
import 'package:hosta_app/widgets/search_field.dart';
import 'package:hosta_app/presentation/providers/category_provider.dart';
import 'package:hosta_app/data/models/category_model.dart';
import 'package:hosta_app/shared/widgets/index.dart';
import 'package:hosta_app/generated/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  bool _isDark = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryProvider>().loadCategories();
      _updateTheme();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _updateTheme() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    if (_isDark != isDark) {
      setState(() {
        _isDark = isDark;
      });
    }
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
    // Cancel previous timer
    _debounceTimer?.cancel();

    // Set new timer for debounced search
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      final categoryProvider = context.read<CategoryProvider>();
      final allCategories = categoryProvider.categories;

      if (query.isEmpty) {
        setState(() {
          _filteredCategories = [];
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
    });
  }

  Widget _buildCategoriesHeader() {
    return RepaintBoundary(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)?.categories ?? 'Categories',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: _isDark ? AppColors.white : AppColors.dark,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body:
          Selector<
            CategoryProvider,
            ({bool isLoading, String? error, List<CategoryModel> categories})
          >(
            selector: (context, provider) => (
              isLoading: provider.isLoading,
              error: provider.error,
              categories: provider.categories,
            ),
            builder: (context, data, child) {
              if (data.isLoading) {
                return LoadingWidget(
                  message:
                      AppLocalizations.of(context)?.loading_categories ??
                      'Loading categories...',
                );
              }
              if (data.error != null) {
                return CustomErrorWidget(
                  message: data.error!,
                  onRetry: () =>
                      context.read<CategoryProvider>().loadCategories(),
                );
              }
              if (data.categories.isEmpty) {
                return EmptyWidget(
                  message:
                      AppLocalizations.of(context)?.no_categories_available ??
                      'No categories available',
                  icon: Icons.category_outlined,
                );
              }

              final categories = _filteredCategories.isNotEmpty
                  ? _filteredCategories
                  : data.categories;

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: RepaintBoundary(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            SearchField(
                              selectedCity: selectedCity,
                              onCityPickerPressed: _showCityPicker,
                              controller: _searchController,
                              onSearchChanged: _onSearchChanged,
                              isDark: _isDark,
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
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.85,
                          ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final category = categories[index];
                          return RepaintBoundary(
                            child: _buildCategoryItem(category, index),
                          );
                        },
                        childCount: categories.length,
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              );
            },
          ),
    );
  }

  Widget _buildCategoryItem(CategoryModel category, int index) {
    return GestureDetector(
      onTap: () => _onCategoryTap(index),
      child: Container(
        decoration: BoxDecoration(
          color: _isDark ? AppColors.dark : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isDark
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
                color: _isDark ? AppColors.white : AppColors.dark,
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
                  color: _isDark
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
