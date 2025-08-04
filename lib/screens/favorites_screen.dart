import 'package:flutter/material.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'package:hosta_app/widgets/app_bar.dart' show SimpleAppBar;
import 'package:hosta_app/shared/widgets/empty_widget.dart';
import 'package:hosta_app/shared/widgets/error_widget.dart';
import 'package:hosta_app/shared/widgets/loading_widget.dart';
import 'package:hosta_app/data/models/favorite_model.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _isLoading = true;
  String? _error;
  List<FavoriteModel> _favorites = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadMockFavorites();
    });
  }

  void _loadMockFavorites() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _favorites = [
        FavoriteModel(
          id: '1',
          providerId: '1',
          providerName: 'John Smith',
          providerImage: 'assets/images/logo.png',
          serviceTitle: 'House Cleaning',
          rating: 4.8,
          createdAt: DateTime.now(),
        ),
        FavoriteModel(
          id: '2',
          providerId: '2',
          providerName: 'Sarah Johnson',
          providerImage: 'assets/images/logo.png',
          serviceTitle: 'Garden Maintenance',
          rating: 4.5,
          createdAt: DateTime.now(),
        ),
        FavoriteModel(
          id: '3',
          providerId: '3',
          providerName: 'Mike Wilson',
          providerImage: 'assets/images/logo.png',
          serviceTitle: 'Window Cleaning',
          rating: 4.9,
          createdAt: DateTime.now(),
        ),
      ];
    });
  }

  void _toggleFavorite(String providerId) async {
    setState(() {
      _favorites.removeWhere((favorite) => favorite.providerId == providerId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Removed from favorites'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const SimpleAppBar(),
      body: _isLoading
          ? const LoadingWidget()
          : _error != null
          ? CustomErrorWidget(
              message: _error!,
              onRetry: () => _loadMockFavorites(),
            )
          : _favorites.isEmpty
          ? EmptyWidget(
              message: 'No favorite providers yet',
              icon: Icons.favorite_border,
              actionText: 'Browse Providers',
              onAction: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final favorite = _favorites[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.dark.withAlpha((255 * 0.1).toInt())
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark
                          ? AppColors.white.withAlpha((255 * 0.2).toInt())
                          : AppColors.boxBorder,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: favorite.providerImage != null
                          ? AssetImage(favorite.providerImage!)
                          : null,
                      child: favorite.providerImage == null
                          ? Icon(
                              Icons.person,
                              size: 30,
                              color: isDark ? AppColors.white : AppColors.dark,
                            )
                          : null,
                    ),
                    title: Text(
                      favorite.providerName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.white : AppColors.dark,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          favorite.serviceTitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark
                                ? AppColors.white.withAlpha((255 * 0.7).toInt())
                                : AppColors.dark.withAlpha((255 * 0.7).toInt()),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              favorite.rating.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark
                                    ? AppColors.white
                                    : AppColors.dark,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () => _toggleFavorite(favorite.providerId),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/provider-details',
                        arguments: {'providerId': favorite.providerId},
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
