import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  // ================== الحقول الخاصة بالمستخدم ==================
  String _email = '';
  String _password = '';
  String _name = '';
  String _gender = '';
  String _diagnosis = '';
  String _phone = '';
  DateTime? _birthDate;

  bool _isLoading = false;

  // ================== Getters ==================
  String get email => _email;
  String get password => _password;
  String get name => _name;
  String get gender => _gender;
  String get diagnosis => _diagnosis;
  String get phone => _phone;
  DateTime? get birthDate => _birthDate;
  bool get isLoading => _isLoading;

  // ================== Setters ==================
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  void setDiagnosis(String diagnosis) {
    _diagnosis = diagnosis;
    notifyListeners();
  }

  void setPhone(String value) {
    _phone = value;
    notifyListeners();
  }

  void setBirthDate(DateTime date) {
    _birthDate = date;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // ================== المستخدم الحالي ==================
  String? _currentUserEmail;
  String? _currentUserPassword;

  void setCurrentUser() {
    _currentUserEmail = _email;
    _currentUserPassword = _password;
    notifyListeners();
  }

  String? get currentUserEmail => _currentUserEmail;
  String? get currentUserPassword => _currentUserPassword;
}
