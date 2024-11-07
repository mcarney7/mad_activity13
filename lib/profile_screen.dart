import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  // Handle user logout
  void _logout(BuildContext context) async {
    await _authService.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = _authService.currentUser?.email ?? 'No Email';

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, $userEmail'),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
