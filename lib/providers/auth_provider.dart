import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isLoading = false;

  // getters
  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;

  // setters مع notifyListeners
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // دالة وهمية لمحاكاة تسجيل الدخول
  Future<bool> login() async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2)); // تحاكي تحميل الشبكة
    setLoading(false);

    // نقدر نتحقق هنا من صحة البيانات، مثلاً:
    if (_email == "test@example.com" && _password == "123456") {
      return true;
    }
    return false;
  }
}
