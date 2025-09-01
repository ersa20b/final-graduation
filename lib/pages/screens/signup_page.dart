import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_med_/models/app_user_model.dart';
import 'package:graduation_med_/util/validators.dart';
import 'package:provider/provider.dart';
import 'package:graduation_med_/providers/auth_provider.dart' as local;
import 'package:graduation_med_/util/login_botton.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context, local.AuthProvider provider) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      provider.setBirthDate(picked);
      setState(() {
        dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void dispose() {
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Consumer<local.AuthProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              const SizedBox(height: 70),
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
                                  "Create Account",
                                  style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Fill the fields to create an account',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),

                              // Email
                              Text("* Email Address", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.error)),
                              const SizedBox(height: 8),
                              TextFormField(
                                onChanged: provider.setEmail,
                                validator: V.email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'name@example.com',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Phone
                              Text("* Phone Number", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.error)),
                              const SizedBox(height: 8),
                              TextFormField(
                                onChanged: provider.setPhone,
                                validator: V.libyaPhone,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: '09XXXXXXXX',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Full Name
                              Text("Full Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                              const SizedBox(height: 8),
                              TextFormField(
                                onChanged: provider.setName,
                                validator: (v) => V.minLen(v, 3, label: 'الاسم'),
                                decoration: InputDecoration(
                                  hintText: 'Enter your name',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Date of Birth
                              Text("Date of Birth", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                              const SizedBox(height: 8),
                              TextField(
                                controller: dobController,
                                readOnly: true,
                                onTap: () => _selectDate(context, provider),
                                decoration: InputDecoration(
                                  hintText: 'dd/mm/yyyy',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  suffixIcon: const Icon(Icons.calendar_today),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Gender
                              DropdownButtonFormField<String>(
                                value: provider.gender.isNotEmpty ? provider.gender : null,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  hintText: 'Select gender',
                                ),
                                items: ['Male', 'Female']
                                    .map((gender) => DropdownMenuItem<String>(
                                          value: gender,
                                          child: Text(gender),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) provider.setGender(value);
                                },
                              ),

                              const SizedBox(height: 20),

                              // Diagnosis
                              Text("* Medical diagnosis", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.error)),
                              const SizedBox(height: 8),
                              TextFormField(
                                onChanged: provider.setDiagnosis,
                                maxLines: 6,
                                validator: V.required,
                                decoration: InputDecoration(
                                  hintText: 'Include chronic or past conditions',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 2.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Password
                              Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
                              const SizedBox(height: 8),
                              TextFormField(
                                obscureText: true,
                                onChanged: provider.setPassword,
                                validator: V.strongPassword,
                                decoration: InputDecoration(
                                  hintText: '*********',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Sign up button
                              LoginBotton(
                                text: 'Sign up',
                                color: Theme.of(context).colorScheme.surface,
                                onTap: () async {
                                  if (_formKey.currentState?.validate() != true) return;

                                  final provider = context.read<local.AuthProvider>();
                                  final missing = [];
                                  if (provider.gender.isEmpty) missing.add("gender");
                                  if (provider.birthDate == null) missing.add("birth date");

                                  if (missing.isNotEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Please complete: ${missing.join(', ')}")),
                                    );
                                    return;
                                  }

                                  try {
                                    provider.setLoading(true);

                                    //  إنشاء حساب في Firebase Auth
                                    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                      email: provider.email,
                                      password: provider.password,
                                    );

                                    final uid = credential.user!.uid;

                                    //  حفظ بيانات المستخدم في Firestore
                                   final newUser = AppUser(
                                    uid: uid,
                                    email: provider.email,
                                    phone: provider.phone,
                                    fullName: provider.name,
                                    gender: provider.gender,
                                    diagnosis: provider.diagnosis,
                                    birthDate: provider.birthDate!, // ✅ بدلناها
                                    password: provider.password,
                                  );


                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(uid)
                                        .set(newUser.toMap());

                                    provider.setLoading(false);

                                    Navigator.pushReplacementNamed(context, '/login');
                                  } catch (e) {
                                    provider.setLoading(false);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("حدث خطأ: ${e.toString()}")),
                                    );
                                  }
                                },
                              ),

                              Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Already have an account? Login",
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
