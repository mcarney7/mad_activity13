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

  // Handle password change
  void _changePassword(BuildContext context) async {
    final TextEditingController _passwordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Password'),
        content: TextField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: 'New Password'),
          obscureText: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (_passwordController.text.length >= 6) {
                await _authService.changePassword(_passwordController.text);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Password changed successfully'),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Password must be at least 6 characters long'),
                ));
              }
            },
            child: Text('Change'),
          ),
        ],
      ),
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
              onPressed: () => _changePassword(context),
              child: Text('Change Password'),
            ),
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
