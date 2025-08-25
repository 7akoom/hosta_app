import 'package:flutter/material.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/generated/app_localizations.dart';

class SearchField extends StatefulWidget {
  final String selectedCity;
  final VoidCallback onCityPickerPressed;
  final Function(String)? onSearchChanged;
  final TextEditingController? controller;
  final bool isDark;

  const SearchField({
    super.key,
    required this.selectedCity,
    required this.onCityPickerPressed,
    this.onSearchChanged,
    this.controller,
    required this.isDark,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late InputDecoration _inputDecoration;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Don't build InputDecoration here, wait for didChangeDependencies
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _buildInputDecoration();
  }

  @override
  void didUpdateWidget(SearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDark != widget.isDark) {
      _buildInputDecoration();
    }
  }

  void _buildInputDecoration() {
    _inputDecoration = InputDecoration(
      hintText:
          AppLocalizations.of(context)?.search_service ?? 'Search a service...',
      hintStyle: TextStyle(
        color: widget.isDark
            ? AppColors.white.withAlpha((255 * 0.7).toInt())
            : AppColors.dark.withAlpha((255 * 0.7).toInt()),
      ),
      prefixIcon: Icon(
        Icons.search,
        color: widget.isDark ? AppColors.white : AppColors.dark,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: widget.isDark
              ? AppColors.white.withAlpha((255 * 0.3).toInt())
              : AppColors.dark.withAlpha((255 * 0.3).toInt()),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: widget.isDark
              ? AppColors.white.withAlpha((255 * 0.3).toInt())
              : AppColors.dark.withAlpha((255 * 0.3).toInt()),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: widget.isDark ? AppColors.white : AppColors.dark,
        ),
      ),
      filled: true,
      fillColor: widget.isDark
          ? AppColors.dark.withAlpha((255 * 0.1).toInt())
          : AppColors.white,
    );
    _isInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    // Ensure InputDecoration is built before using it
    if (!_isInitialized) {
      _buildInputDecoration();
    }

    return RepaintBoundary(
      child: Row(
        children: [
          // City Selector Button
          RepaintBoundary(
            child: Container(
              height: 56,
              padding: const EdgeInsets.only(right: 8),
              child: ElevatedButton(
                onPressed: widget.onCityPickerPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.isDark
                      ? AppColors.dark.withAlpha((255 * 0.3).toInt())
                      : AppColors.white,
                  foregroundColor: widget.isDark
                      ? AppColors.white
                      : AppColors.dark,
                  elevation: 0,
                  side: BorderSide(
                    color: widget.isDark
                        ? AppColors.white.withAlpha((255 * 0.3).toInt())
                        : AppColors.dark.withAlpha((255 * 0.3).toInt()),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                child: Icon(
                  Icons.location_on,
                  size: 20,
                  color: widget.isDark ? AppColors.white : AppColors.dark,
                ),
              ),
            ),
          ),
          // Search Field
          Expanded(
            child: RepaintBoundary(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: widget.controller,
                    onChanged: widget.onSearchChanged,
                    decoration: _inputDecoration,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
