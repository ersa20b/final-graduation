import 'package:flutter/material.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';
import 'package:graduation_med_/services/notifications_service.dart';
import 'package:provider/provider.dart';
import 'package:graduation_med_/util/login_botton.dart';
import 'package:graduation_med_/util/validators.dart';
import 'package:graduation_med_/providers/auth_provider.dart' as local_auth;
import 'package:graduation_med_/providers/profiles_provider.dart';
import 'package:graduation_med_/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Consumer<local_auth.AuthProvider>(
        builder: (context, authProvider, child) {
          return Column(
            children: [
              const SizedBox(height: 200),
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 40),
                              Center(
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Enter your email and password',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),

                              // Email
                              Text("Email Address",
                                  style: Theme.of(context).textTheme.bodyLarge),
                              const SizedBox(height: 8),
                              TextFormField(
                                onChanged: authProvider.setEmail,
                                validator: V.email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'email@example.com',
                                  hintStyle: TextStyle(color: Colors.grey.shade600),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Password
                              Text("Password",
                                  style: Theme.of(context).textTheme.bodyLarge),
                              const SizedBox(height: 8),
                              TextFormField(
                                obscureText: true,
                                onChanged: authProvider.setPassword,
                                validator: V.required,
                                decoration: InputDecoration(
                                  hintText: '********',
                                  hintStyle: TextStyle(color: Colors.grey.shade600),
                                  border: const OutlineInputBorder(),
                                ),
                              ),

                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Forgot your password?",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              //  Login button
                              authProvider.isLoading
                                  ? const Center(child: CircularProgressIndicator())
                                  : LoginBotton(
                                      text: 'Log in',
                                      color: Theme.of(context).colorScheme.surface,
                                      onTap: () async {
                                        if (_formKey.currentState?.validate() != true) return;

                                        try {
                                          authProvider.setLoading(true);

                                          // تسجيل الدخول من Firebase
                                          final credential = await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                            email: authProvider.email,
                                            password: authProvider.password,
                                          );

                                          final uid = credential.user!.uid;

                                          // جلب بيانات المستخدم من Firestore
                                          final doc = await FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(uid)
                                              .get();

                                          if (!doc.exists) {
                                            throw Exception("User data not found in Firestore.");
                                          }

                                          final data = doc.data()!;
                                          final profile = ProfileModel(
                                            id: uid,
                                            name: data['fullName'],
                                            email: data['email'],
                                            gender: data['gender'],
                                            birthDate: (data['birthDate'] as Timestamp).toDate(),
                                            diagnosis: data['diagnosis'],
                                            isMainUser: true,
                                          );

                                          // حفظ البيانات في ProfilesProvider
                                                                                  final profileProvider = context.read<ProfilesProvider>();
                                          profileProvider.setMainUser(profile);
                                          await profileProvider.fetchDependentsFromFirestore(); //  تحميل التوابع من Firestore

                                          // تحميل أدوية المستخدم من Firestore
                                          final medProvider = context.read<MedicineProvider>();
                                          await medProvider.loadMedicinesFromFirebase(profile.id);

                                          // نجيب كل الأدوية بعد التحميل
                                          final allMeds = medProvider.getFullMedicinesForUser(profile.id);

                                          // نعيد جدولة الإشعارات

                                          

                                          authProvider.setLoading(false);


                                          // الانتقال للصفحة الرئيسية
                                          Navigator.pushReplacementNamed(context, '/home');
                                        } catch (e) {
                                          authProvider.setLoading(false);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("خطأ: ${e.toString()}")),
                                          );
                                        }
                                      },
                                    ),

                              Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: Text(
                                    "Create account",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
