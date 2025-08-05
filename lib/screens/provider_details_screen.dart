import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/widgets/app_bar.dart' show SimpleAppBar;
import 'package:hosta_app/data/models/provider_model.dart';
import 'package:hosta_app/data/models/service_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hosta_app/presentation/providers/auth_provider.dart';

class ProviderDetailsScreen extends StatefulWidget {
  final String providerId;
  final ServiceModel? service;

  const ProviderDetailsScreen({
    super.key,
    required this.providerId,
    this.service,
  });

  @override
  State<ProviderDetailsScreen> createState() => _ProviderDetailsScreenState();
}

class _ProviderDetailsScreenState extends State<ProviderDetailsScreen> {
  bool _isLoading = true;
  String? _error;
  ProviderModel? _provider;
  List<ProviderModel> _otherProviders = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMockData();
    });
  }

  void _loadMockData() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _provider = ProviderModel(
        id: widget.providerId,
        name: 'John Smith',
        email: 'john@example.com',
        phone: '+1234567890',
        address: '123 Main St, City',
        image: 'assets/images/logo.png',
        rating: 4.8,
        price: 50.0,
        serviceId: widget.service?.id ?? '1',
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        description: 'Professional service provider with 5 years of experience',
        specializations: ['Cleaning', 'Organizing'],
      );

      _otherProviders = [
        ProviderModel(
          id: '2',
          name: 'Sarah Johnson',
          email: 'sarah@example.com',
          phone: '+1234567891',
          address: '456 Oak St, Town',
          image: 'assets/images/logo.png',
          rating: 4.5,
          price: 45.0,
          serviceId: widget.service?.id ?? '1',
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
          serviceId: widget.service?.id ?? '1',
          isActive: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          description: 'Quality service guaranteed',
          specializations: ['Maintenance', 'Repair'],
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error loading provider data',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadMockData,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : _provider == null
          ? const Center(child: Text('Provider not found'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildServiceImage(),
                  _buildProviderInfo(),
                  _buildReviewsSection(),
                  _buildBookNowButton(),
                  _buildOtherProvidersSection(),
                ],
              ),
            ),
    );
  }

  Widget _buildServiceImage() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((255 * 0.1).toInt()),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: _provider!.image != null
                    ? Image.asset(
                        _provider!.image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/logo.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProviderInfo() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  _provider!.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.white : AppColors.dark,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withAlpha(
                        (255 * 0.3).toInt(),
                      ),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    final authProvider = context.read<AuthProvider>();
                    if (!authProvider.isAuthenticated) {
                      // Show dialog and redirect to sign in
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Sign in Required'),
                          content: const Text(
                            'Please sign in to chat with service providers.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Close dialog
                                Navigator.pushNamed(context, '/signin');
                              },
                              child: const Text('Sign in'),
                            ),
                          ],
                        ),
                      );
                      return;
                    }

                    // If authenticated, proceed to chat
                    Navigator.pushNamed(
                      context,
                      '/chat',
                      arguments: {
                        'provider': _provider!,
                        'serviceId': widget.service?.id,
                      },
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/chat.svg',
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    _provider!.rating.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.white : AppColors.dark,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(25 reviews)',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? AppColors.white.withAlpha((255 * 0.7).toInt())
                          : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    size: 16,
                    color: AppColors.primaryBlue,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '\$${_provider!.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  Text(
                    ' / service',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? AppColors.white.withAlpha((255 * 0.7).toInt())
                          : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: AppColors.primaryBlue),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  _provider!.address,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? AppColors.white.withAlpha((255 * 0.7).toInt())
                        : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.white : AppColors.dark,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/provider-reviews',
                    arguments: {'provider': _provider!},
                  );
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildReviewItem(
            'Ahmed Ali',
            'Great service! Very professional and on time.',
            5,
            'assets/images/logo.png',
          ),
          const SizedBox(height: 12),
          _buildReviewItem(
            'Sarah Johnson',
            'Excellent work quality. Highly recommended!',
            4,
            'assets/images/logo.png',
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(
    String name,
    String comment,
    int rating,
    String avatar,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.dark.withAlpha((255 * 0.05).toInt())
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? AppColors.white.withAlpha((255 * 0.1).toInt())
              : AppColors.boxBorder,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 20, backgroundImage: AssetImage(avatar)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.white : AppColors.dark,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          size: 14,
                          color: index < rating ? Colors.amber : Colors.grey,
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppColors.white.withAlpha((255 * 0.7).toInt())
                        : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookNowButton() {
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/book_service');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Book Now',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildOtherProvidersSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final otherProviders = _otherProviders
        .where((p) => p.id != _provider!.id)
        .toList();

    if (otherProviders.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Other Providers',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.white : AppColors.dark,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: otherProviders.length,
            itemBuilder: (context, index) {
              final provider = otherProviders[index];
              return Container(
                width: (MediaQuery.of(context).size.width - 32) / 3,
                margin: const EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          provider.image ?? 'assets/images/logo.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 80,
                      child: Text(
                        provider.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDark ? AppColors.white : AppColors.dark,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
