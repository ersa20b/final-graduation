import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final String id;              
  final String name;           
  final String email;           
  final String gender;         
  final DateTime birthDate;     
  final String diagnosis;       
  final bool isMainUser;        

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.birthDate,
    required this.diagnosis,
    required this.isMainUser,
  });

  /// لتحويل البيانات إلى Map (مفيد للتخزين في Firebase)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'birthDate': birthDate.toIso8601String(),
      'diagnosis': diagnosis,
      'isMainUser': isMainUser,
    };
  }

  // لتحويل بيانات Firestore إلى موديل Dart     
  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    final rawBirthDate = map['birthDate'];
    final birthDate = rawBirthDate is Timestamp
        ? rawBirthDate.toDate()
        : DateTime.parse(rawBirthDate.toString());

    return ProfileModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      gender: map['gender'],
      birthDate: birthDate,
      diagnosis: map['diagnosis'],
      isMainUser: map['isMainUser'],
    );
  }

  // لإنشاء نسخة معدلة من البروفايل
  ProfileModel copyWith({
    String? id,
    String? name,
    String? email,
    String? gender,
    DateTime? birthDate,
    String? diagnosis,
    bool? isMainUser,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      diagnosis: diagnosis ?? this.diagnosis,
      isMainUser: isMainUser ?? this.isMainUser,
    );
  }
}
