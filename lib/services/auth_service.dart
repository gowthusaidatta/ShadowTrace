import 'package:flutter_appauth/flutter_appauth.dart';
import 'secure_session_service.dart';

class CognitoSession {
  final String? accessToken;
  final String? idToken;
  final String? refreshToken;
  final String userId;
  final bool isGuest;

  const CognitoSession({
    required this.userId,
    this.accessToken,
    this.idToken,
    this.refreshToken,
    this.isGuest = false,
  });
}

class AuthService {
  AuthService({FlutterAppAuth? appAuth}) : _appAuth = appAuth ?? const FlutterAppAuth();

  final FlutterAppAuth _appAuth;
  final SecureSessionService _secureSession = SecureSessionService();

  String get _clientId => const String.fromEnvironment('AWS_COGNITO_CLIENT_ID', defaultValue: '');
  String get _issuer => const String.fromEnvironment('AWS_COGNITO_ISSUER_URL', defaultValue: '');
  String get _redirectUri => const String.fromEnvironment('AWS_COGNITO_REDIRECT_URI', defaultValue: 'shadowtrace://callback');
  String get _logoutUri => const String.fromEnvironment('AWS_COGNITO_LOGOUT_URI', defaultValue: 'shadowtrace://logout');

  List<String> _scopes() {
    final raw = const String.fromEnvironment('AWS_COGNITO_SCOPES', defaultValue: 'openid profile email phone');
    return raw.split(RegExp(r'\s+')).where((item) => item.isNotEmpty).toList();
  }

  Future<CognitoSession?> signInWithCognito() => _authenticate(promptLogin: false);
  Future<CognitoSession?> signUpWithCognito() => _authenticate(promptLogin: false);

  Future<CognitoSession?> _authenticate({required bool promptLogin}) async {
    if (_clientId.isEmpty || _issuer.isEmpty) {
      throw StateError('Cognito issuer/client id is not configured');
    }

    final request = AuthorizationTokenRequest(
      _clientId,
      _redirectUri,
      issuer: _issuer,
      scopes: _scopes(),
      promptValues: promptLogin ? const ['login'] : const ['login'],
      preferEphemeralSession: false,
      serviceConfiguration: null,
      discoveryUrl: null,
    );

    final response = await _appAuth.authorizeAndExchangeCode(request);
    if (response == null) return null;

    final session = CognitoSession(
      userId: response.accessToken ?? response.idToken ?? 'cognito-user',
      accessToken: response.accessToken,
      idToken: response.idToken,
      refreshToken: response.refreshToken,
      isGuest: false,
    );

    await _secureSession.saveSession(
      userId: session.userId,
      accessToken: session.accessToken,
      idToken: session.idToken,
      refreshToken: session.refreshToken,
      isGuest: false,
    );

    return session;
  }

  Future<CognitoSession> signInAsGuest() async {
    final session = CognitoSession(
      userId: 'guest-${DateTime.now().millisecondsSinceEpoch}',
      isGuest: true,
    );
    await _secureSession.saveSession(userId: session.userId, isGuest: true);
    return session;
  }

  Future<bool> hasActiveSession() => _secureSession.hasSession();
  Future<bool> isGuest() => _secureSession.isGuest();
  Future<String?> currentUserId() => _secureSession.readUserId();
  Future<String?> currentIdToken() => _secureSession.readIdToken();
  Future<String?> currentAccessToken() => _secureSession.readAccessToken();

  Future<void> signOut() async {
    final idToken = await _secureSession.readIdToken();
    if (_issuer.isNotEmpty && _clientId.isNotEmpty && idToken != null && idToken.isNotEmpty) {
      try {
        await _appAuth.endSession(EndSessionRequest(
          idTokenHint: idToken,
          postLogoutRedirectUrl: _logoutUri,
          issuer: _issuer,
          clientId: _clientId,
          preferEphemeralSession: false,
        ));
      } catch (_) {
        // Fall through to local session clear.
      }
    }

    await _secureSession.clear();
  }
}
