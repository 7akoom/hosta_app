import 'package:flutter/material.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/widgets/app_bar.dart' show SimpleAppBar;
import 'package:hosta_app/data/models/service_model.dart';
import 'package:hosta_app/data/models/provider_model.dart';
import 'package:hosta_app/shared/widgets/index.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final ServiceModel service;

  const ServiceDetailsScreen({super.key, required this.service});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  bool _isLoading = true;
  String? _error;
  List<ProviderModel> _providers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMockProviders();
    });
  }

  void _loadMockProviders() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _providers = [
        ProviderModel(
          id: '1',
          name: 'John Smith',
          email: 'john@example.com',
          phone: '+1234567890',
          address: '123 Main St, City',
          image: 'assets/images/logo.png',
          rating: 4.8,
          price: 50.0,
          serviceId: widget.service.id,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          description:
              'Professional service provider with 5 years of experience',
          specializations: ['Cleaning', 'Organizing'],
        ),
        ProviderModel(
          id: '2',
          name: 'Sarah Johnson',
          email: 'sarah@example.com',
          phone: '+1234567891',
          address: '456 Oak St, Town',
          image: 'assets/images/logo.png',
          rating: 4.5,
          price: 45.0,
          serviceId: widget.service.id,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          description: 'Experienced provider specializing in home services',
          specializations: ['Deep Cleaning', 'Window Cleaning'],
        ),
        ProviderModel(
          id: '3',
          name: 'Mike Wilson',
          email: 'mike@example.com',
          phone: '+1234567892',
          address: '789 Pine St, Village',
          image: 'assets/images/logo.png',
          rating: 4.9,
          price: 55.0,
          serviceId: widget.service.id,
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          description: 'Quality service guaranteed',
          specializations: ['Maintenance', 'Repair'],
        ),
      ];
    });
  }

  void _sortProviders(String sortBy) {
    setState(() {
      switch (sortBy) {
        case 'distance':
          // Mock distance sorting (in real app, calculate actual distances)
          _providers.sort((a, b) => a.id.compareTo(b.id));
          break;
        case 'price':
          _providers.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'rating':
          _providers.sort((a, b) => b.rating.compareTo(a.rating));
          break;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Providers sorted by ${sortBy == 'distance'
              ? 'nearest distance'
              : sortBy == 'price'
              ? 'lowest price'
              : 'highest rating'}',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(),
      body: _isLoading
          ? const LoadingWidget(message: 'Loading providers...')
          : _error != null
          ? CustomErrorWidget(
              message: _error!,
              onRetry: () => _loadMockProviders(),
            )
          : _providers.isEmpty
          ? const EmptyWidget(
              message: 'No providers available for this service',
              icon: Icons.person_outline,
            )
          : _buildContent(_providers),
    );
  }

  Widget _buildContent(List<ProviderModel> providers) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Header
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.service.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: isDark ? AppColors.white : AppColors.dark,
                  ),
                ),
                const SizedBox(height: 8),
                if (widget.service.description.isNotEmpty) ...[
                  Text(
                    widget.service.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark
                          ? AppColors.white.withAlpha((255 * 0.7).toInt())
                          : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Providers Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available Providers',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: isDark ? AppColors.white : AppColors.dark,
                ),
              ),
              // Filter Button
              IconButton(
                onPressed: () => _showFilterDialog(context, isDark),
                icon: Icon(
                  Icons.filter_list,
                  color: AppColors.primaryBlue,
                  size: 24,
                ),
                tooltip: 'Filter & Sort',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${providers.length} providers available',
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.white.withAlpha((255 * 0.7).toInt())
                  : AppColors.dark.withAlpha((255 * 0.7).toInt()),
            ),
          ),
          const SizedBox(height: 16),

          // Providers List
          _buildProvidersList(providers),
        ],
      ),
    );
  }

  Widget _buildProvidersList(List<ProviderModel> providers) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: providers.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final provider = providers[index];
        return _buildProviderCard(provider, isDark);
      },
    );
  }

  Widget _buildProviderCard(ProviderModel provider, bool isDark) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/provider-details',
          arguments: {'provider': provider, 'service': widget.service},
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.dark.withAlpha((255 * 0.05).toInt())
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((255 * 0.05).toInt()),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Provider Image with Rating
            Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(
                        provider.image ?? 'assets/images/logo.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Rating Badge
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 10, color: Colors.white),
                        const SizedBox(width: 1),
                        Text(
                          provider.rating.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),

            // Provider Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Provider Name
                  Text(
                    provider.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isDark ? AppColors.white : AppColors.dark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Address
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: AppColors.primaryBlue,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          provider.address,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.white.withAlpha((255 * 0.7).toInt())
                                : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Price
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        size: 16,
                        color: AppColors.primaryBlue,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '\$${provider.price.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      Text(
                        ' / service',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? AppColors.white.withAlpha((255 * 0.7).toInt())
                              : AppColors.dark.withAlpha((255 * 0.7).toInt()),
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
    );
  }

  void _showFilterDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? AppColors.dark : Colors.white,
          title: Text(
            'Sort Providers',
            style: TextStyle(
              color: isDark ? AppColors.white : AppColors.dark,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSortOption(
                context,
                'Nearest Distance',
                Icons.location_on,
                () => _sortProviders('distance'),
                isDark,
              ),
              const SizedBox(height: 12),
              _buildSortOption(
                context,
                'Lowest Price',
                Icons.attach_money,
                () => _sortProviders('price'),
                isDark,
              ),
              const SizedBox(height: 12),
              _buildSortOption(
                context,
                'Highest Rating',
                Icons.star,
                () => _sortProviders('rating'),
                isDark,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColors.primaryBlue),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSortOption(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
    bool isDark,
  ) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.dark.withAlpha((255 * 0.1).toInt())
              : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDark
                ? AppColors.white.withAlpha((255 * 0.2).toInt())
                : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 20),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.white : AppColors.dark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
