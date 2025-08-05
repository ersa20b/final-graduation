import 'package:flutter/material.dart';
import 'package:graduation_med_/util/login_botton.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController diagnosisController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  // دالة اختيار التاريخ
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    diagnosisController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
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
                        Text(
                          "* Email Address",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'name@example.com ',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Full Name
                        Text(
                          "Full Name",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: nameController, // ← تم إضافة الكنترولر هنا
                          decoration: InputDecoration(
                            hintText: 'Enter your name ',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Date of Birth
                        Text(
                          "Date of Birth",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: dobController, // ← لإظهار التاريخ المختار
                          readOnly: true, // ← نمنع الكتابة اليدوية
                          onTap: () => _selectDate(context), // ← نفتح الـ DatePicker
                          decoration: InputDecoration(
                            hintText: 'dd/mm/yyyy',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Gender
                        DropdownButtonFormField<String>(
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
                          // تقدر تخزن القيمة هنا إذا حبيت تستخدمها
                          print('Selected gender: $value');
                        },
                      ),


                        const SizedBox(height: 20),

                        // Medical Diagnosis
                        Text(
                          "* Medical diagnosis",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: diagnosisController, // ← الكنترولر هنا
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: 'Your medical history is important for accurate diagnosis and treatment – include chronic or past conditions',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 2.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent, width: 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Password
                        Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: '*********  ',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Sign up button
                        LoginBotton(text: 'Sign up', color: Theme.of(context).colorScheme.surface),

                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              // فتح صفحة تسجيل الدخول
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
        ],
      ),
    );
  }
}
