import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/profile_model.dart';

class ProfilesProvider with ChangeNotifier {
  late ProfileModel _mainUser;
  late ProfileModel _activeProfile;
  final List<ProfileModel> _dependents = [];

  //  Getters
  ProfileModel get mainUser => _mainUser;
  ProfileModel get activeProfile => _activeProfile;
  List<ProfileModel> get dependents => List.unmodifiable(_dependents);

  //  تهيئة المستخدم الرئيسي
  void setMainUser(ProfileModel user) {
    _mainUser = user;
    _activeProfile = user;
    notifyListeners();
  }

  //  إضافة تابع إلى Firestore
  Future<void> addDependentToFirestore(ProfileModel dependent) async {
    final userId = _mainUser.id;

    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('dependents');

    await ref.doc(dependent.id).set(dependent.toMap());

    _dependents.add(dependent);
    notifyListeners();
  }

  //  تحميل التوابع من Firestore
  Future<void> fetchDependentsFromFirestore() async {
    final userId = _mainUser.id;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('dependents')
        .get();

    _dependents.clear();
    _dependents.addAll(
      snapshot.docs.map((doc) => ProfileModel.fromMap(doc.data())).toList(),
    );

    notifyListeners();
  }

  //  حذف تابع من Firestore
  Future<void> removeDependentFromFirestore(String dependentId) async {
    final userId = _mainUser.id;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('dependents')
        .doc(dependentId)
        .delete();

    _dependents.removeWhere((dep) => dep.id == dependentId);

    if (_activeProfile.id == dependentId) {
      _activeProfile = _mainUser;
    }

    notifyListeners();
  }

  //  التبديل بين الحسابات
  void setActiveProfile(ProfileModel profile) {
    _activeProfile = profile;
    notifyListeners();
  }

  //  الرجوع للحساب الرئيسي
  void switchToMainUser() {
    _activeProfile = _mainUser;
    notifyListeners();
  }

  //  تعديل حساب
  void updateProfile(ProfileModel updated) {
    if (_mainUser.id == updated.id) {
      _mainUser = updated;
    }

    final index = _dependents.indexWhere((p) => p.id == updated.id);
    if (index != -1) {
      _dependents[index] = updated;
    }

    if (_activeProfile.id == updated.id) {
      _activeProfile = updated;
    }

    notifyListeners();
  }
}
