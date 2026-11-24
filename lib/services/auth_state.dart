import 'package:flutter/foundation.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

class AuthState extends ChangeNotifier {
  final ApiClient _apiClient;
  String? _token;

  AuthState(this._apiClient);

  bool get isLoggedIn => _token != null;
  String? get token => _token;

  Future<void> login(String username, String password) async {
    _token = await _apiClient.obtainToken(username, password);
    notifyListeners();
  }

  Future<void> logout() async {
    final currentToken = _token;
    try {
      if (currentToken != null) {
        await _apiClient.logout(token: currentToken);
      }
    } finally {
      _token = null;
      notifyListeners();
    }
  }
}
