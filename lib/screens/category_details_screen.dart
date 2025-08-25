import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hosta_app/generated/app_localizations.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/widgets/app_bar.dart' show SimpleAppBar;
import 'package:hosta_app/data/models/service_model.dart';
import 'package:hosta_app/data/models/category_model.dart';
import 'package:hosta_app/shared/widgets/index.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryDetailsScreen({super.key, required this.category});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  bool _isLoading = true;
  String? _error;
  List<ServiceModel> _services = [];

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to avoid calling setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMockServices();
    });
  }

  // Mock data for testing UI
  void _loadMockServices() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _services = [
        ServiceModel(
          id: '1',
          name: 'House Cleaning',
          description:
              'Professional house cleaning service with attention to detail',
          image: 'assets/images/logo.png',
          price: 50.0,
          categoryId: widget.category.id,
          duration: '120 minutes',
          rating: 4.5,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        ServiceModel(
          id: '2',
          name: 'Garden Maintenance',
          description: 'Complete garden care and maintenance service',
          image: 'assets/images/logo.png',
          price: 75.0,
          categoryId: widget.category.id,
          duration: '180 minutes',
          rating: 4.8,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        ServiceModel(
          id: '3',
          name: 'Window Cleaning',
          description: 'Professional window and glass cleaning service',
          image: 'assets/images/logo.png',
          price: 35.0,
          categoryId: widget.category.id,
          duration: '60 minutes',
          rating: 4.2,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title:
            AppLocalizations.of(context)?.category_details_page_title ??
            'تفاصيل الفئة',
      ),
      body: _isLoading
          ? LoadingWidget(
              message:
                  AppLocalizations.of(context)?.loading_services ??
                  'Loading services...',
            )
          : _error != null
          ? CustomErrorWidget(
              message: _error!,
              onRetry: () => _loadMockServices(),
            )
          : _services.isEmpty
          ? EmptyWidget(
              message:
                  AppLocalizations.of(context)?.no_services_available ??
                  'No services available for this category',
              icon: Icons.work_outline,
            )
          : _buildContent(_services),
    );
  }

  Widget _buildContent(List<ServiceModel> services) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.dark.withAlpha((255 * 0.1).toInt())
                  : AppColors.boxColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark
                    ? AppColors.white.withAlpha((255 * 0.2).toInt())
                    : AppColors.boxBorder,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    widget.category.icon,
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.category.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: isDark ? AppColors.white : AppColors.dark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (widget.category.description != null) ...[
                        Text(
                          widget.category.description!,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark
                                ? AppColors.white.withValues(alpha: 0.7)
                                : AppColors.dark.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                      Row(
                        children: [
                          Icon(
                            Icons.work_outline,
                            size: 16,
                            color: AppColors.primaryBlue,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.category.serviceCount} ${AppLocalizations.of(context)?.services_available ?? 'services available'}',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Services Section
          Text(
            AppLocalizations.of(context)?.available_services ??
                'Available Services',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: isDark ? AppColors.white : AppColors.dark,
            ),
          ),
          const SizedBox(height: 16),

          // Services List
          _buildServicesList(services),
        ],
      ),
    );
  }

  Widget _buildServicesList(List<ServiceModel> services) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final service = services[index];
        return Container(
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark
                  ? AppColors.white.withAlpha((255 * 0.2).toInt())
                  : AppColors.boxBorder,
              width: 1.0,
            ),
          ),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/service-details',
                arguments: {'service': service},
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service Image
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                    child: _buildServiceImageBackground(service.image),
                  ),
                ),
                // Service Name
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: isDark ? AppColors.white : AppColors.dark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      if (service.description.isNotEmpty)
                        Text(
                          service.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.white.withValues(alpha: 0.7)
                                : AppColors.dark.withValues(alpha: 0.7),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildServiceImageBackground(String? imagePath) {
    if (imagePath != null && imagePath.isNotEmpty) {
      return Image.asset(
        imagePath,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildDefaultImageBackground();
        },
      );
    }
    return _buildDefaultImageBackground();
  }

  Widget _buildDefaultImageBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryBlue.withValues(alpha: 0.3),
            AppColors.primaryBlue.withValues(alpha: 0.1),
          ],
        ),
      ),
      child: Center(
        child: Icon(Icons.work_outline, size: 40, color: AppColors.primaryBlue),
      ),
    );
  }
}
