import 'package:flutter/material.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/widgets/app_bar.dart';
import 'package:hosta_app/widgets/image_slider.dart';
import 'package:hosta_app/widgets/city_picker_dialog.dart';
import 'package:hosta_app/widgets/search_field.dart';
import 'package:hosta_app/widgets/categories_grid.dart';
import 'package:hosta_app/widgets/custom_bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCity = 'Erbil';

  final List<String> cities = ['Erbil', 'Sulaymani', 'Dohuk'];

  final List<Map<String, dynamic>> categories = [
    {'icon': 'assets/icons/cleaning.svg', 'label': 'Cleaning'},
    {'icon': 'assets/icons/gardining.svg', 'label': 'Gardining'},
    {'icon': 'assets/icons/plumber.svg', 'label': 'Plumber'},
    {'icon': 'assets/icons/electrican.svg', 'label': 'Electrican'},
    {'icon': 'assets/icons/babysitting.svg', 'label': 'Babysitting'},
    {'icon': 'assets/icons/painting.svg', 'label': 'Painting'},
    {'icon': 'assets/icons/carwash.svg', 'label': 'Carwash'},
    {'icon': 'assets/icons/homerepair.svg', 'label': 'Homerepair'},
    {'icon': 'assets/icons/homerepair.svg', 'label': 'More'},
  ];

  int _selectedIndex = 0;

  void _onCategoryTap(int index) {
    // انتقل لصفحة الفئة المطلوبة
    // Navigator.push(context, ...);
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
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

  Widget _buildCategoriesHeader() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Categories:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: isDark ? AppColors.white : AppColors.dark,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SearchField(
            selectedCity: selectedCity,
            onCityPickerPressed: _showCityPicker,
          ),
          const SizedBox(height: 16),
          const ImageSlider(),
          const SizedBox(height: 24),
          _buildCategoriesHeader(),
          const SizedBox(height: 12),
          CategoriesGrid(categories: categories, onCategoryTap: _onCategoryTap),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}
