import 'package:flutter/material.dart';
import 'package:hosta_app/widgets/app_bar.dart' show SimpleAppBar;
import 'package:hosta_app/generated/app_localizations.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: AppLocalizations.of(context)?.favorites_page_title ?? 'المفضلة',
      ),
      body: const Center(child: Text('Favorites Screen - Coming Soon')),
    );
  }
}
