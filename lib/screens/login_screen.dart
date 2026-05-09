import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  bool _loading = false;

  Future<void> _launchCognito() async {
    setState(() => _loading = true);
    try {
      final session = await _auth.signInWithCognito();
      if (session != null && mounted) {
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cognito sign-in failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _continueAsGuest() async {
    setState(() => _loading = true);
    try {
      await _auth.signInAsGuest();
      if (mounted) context.go('/home');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ShadowTrace Access')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text('Login with Amazon Cognito', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            Text(
              'Managed login/sign-up opens in Cognito Hosted UI. Guest mode is available for live monitoring and SOS alerts without an account.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            FilledButton(
              onPressed: _loading ? null : _launchCognito,
              child: Text(_loading ? 'Opening Cognito...' : 'Sign in / Sign up'),
            ),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: _loading ? null : _continueAsGuest,
              child: const Text('Continue as Guest'),
            ),
            const SizedBox(height: 16),
            TextButton(onPressed: () => context.go('/register'), child: const Text('Need help creating an account?')),
          ],
        ),
      ),
    );
  }
}
