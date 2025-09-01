import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;
  final String email;
  final String phone;
  final String fullName;
  final String gender;
  final String diagnosis;
  final DateTime birthDate;
  final String password; 

  AppUser({
    required this.uid,
    required this.email,
    required this.phone,
    required this.fullName,
    required this.gender,
    required this.diagnosis,
    required this.birthDate,
    required this.password, 
  });

  // لتحويل الموديل إلى Map للتخزين في Firestore
 Map<String, dynamic> toMap() {
  return {
    'uid': uid,
    'email': email,
    'phone': phone,
    'fullName': fullName,
    'gender': gender,
    'diagnosis': diagnosis,
    'birthDate': Timestamp.fromDate(birthDate), 
    'password': password,
  };
}


  //  لتحويل بيانات Firebase إلى موديل Dart
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      email: map['email'],
      phone: map['phone'],
      fullName: map['fullName'],
      gender: map['gender'],
      diagnosis: map['diagnosis'],
      birthDate: (map['birthDate'] as Timestamp).toDate(),

      password: map['password'], 
    );
  }
}
