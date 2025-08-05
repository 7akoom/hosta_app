import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hosta_app/presentation/providers/auth_provider.dart';

/// Widget wrapper that checks for authentication before allowing access to features
/// If user is not authenticated, they will be redirected to sign in screen
class AuthRequired extends StatelessWidget {
  final Widget child;
  final String? message;

  const AuthRequired({super.key, required this.child, this.message});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return GestureDetector(
          onTap: () {
            if (!authProvider.isAuthenticated) {
              _showAuthDialog(context, message);
            }
          },
          child: child,
        );
      },
    );
  }

  void _showAuthDialog(BuildContext context, String? message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign in Required'),
        content: Text(message ?? 'Please sign in to access this feature.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/signin');
            },
            child: const Text('Sign in'),
          ),
        ],
      ),
    );
  }
}

/// Extension method to check auth status and redirect if needed
extension AuthNavigation on BuildContext {
  bool requireAuth({String? message}) {
    final authProvider = read<AuthProvider>();
    if (!authProvider.isAuthenticated) {
      showDialog(
        context: this,
        builder: (context) => AlertDialog(
          title: const Text('Sign in Required'),
          content: Text(message ?? 'Please sign in to access this feature.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/signin');
              },
              child: const Text('Sign in'),
            ),
          ],
        ),
      );
      return false;
    }
    return true;
  }
}
