import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/widgets/app_bar.dart' show SimpleAppBar;
import 'package:hosta_app/presentation/providers/category_provider.dart';
import 'package:hosta_app/data/models/category_model.dart';
import 'package:hosta_app/shared/widgets/index.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<CategoryModel> _filteredCategories = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    final categoryProvider = context.read<CategoryProvider>();
    if (query.isEmpty) {
      setState(() {
        _filteredCategories = categoryProvider.categories;
        _isSearching = false;
      });
    } else {
      setState(() {
        _isSearching = true;
        _filteredCategories = categoryProvider.categories
            .where(
              (category) =>
                  category.name.toLowerCase().contains(query) ||
                  (category.description?.toLowerCase().contains(query) ??
                      false),
            )
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: const SimpleAppBar(),
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
          return Column(
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.dark : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((255 * 0.1).toInt()),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for services...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: isDark ? AppColors.white : AppColors.dark,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: isDark ? AppColors.white : AppColors.dark,
                            ),
                            onPressed: () {
                              _searchController.clear();
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: isDark
                            ? AppColors.white.withAlpha((255 * 0.2).toInt())
                            : AppColors.boxBorder,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: isDark
                            ? AppColors.white.withAlpha((255 * 0.2).toInt())
                            : AppColors.boxBorder,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColors.primaryBlue,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: isDark
                        ? AppColors.dark.withAlpha((255 * 0.1).toInt())
                        : AppColors.boxColor,
                  ),
                ),
              ),
              // Results
              Expanded(child: _buildResults()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildResults() {
    final categoryProvider = context.read<CategoryProvider>();
    final categories = _isSearching
        ? _filteredCategories
        : categoryProvider.categories;
    if (categories.isEmpty) {
      return const EmptyWidget(message: 'No categories found');
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: categories.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          leading: SvgPicture.asset(category.icon, width: 32, height: 32),
          title: Text(category.name),
          subtitle: category.description != null
              ? Text(category.description!)
              : null,
          onTap: () {
            Navigator.pushNamed(
              context,
              '/category-details',
              arguments: {'category': category},
            );
          },
        );
      },
    );
  }
}
