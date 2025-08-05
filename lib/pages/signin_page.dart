import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graduation_med_/providers/auth_provider.dart';
import 'package:graduation_med_/pages/home_page.dart';
import 'package:graduation_med_/util/login_botton.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Consumer<AuthProvider>(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),
                            Center(
                              child: Text(
                                " Sign in",
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

                            // البريد الإلكتروني
                            Text(
                              "Email Address",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              onChanged: authProvider.setEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // كلمة المرور
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
                              onChanged: authProvider.setPassword,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                border: OutlineInputBorder(),
                              ),
                            ),

                            // نسيت كلمة المرور
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // هنا تفتح صفحة إعادة تعيين كلمة المرور
                                },
                                child: Text(
                                  " Forgot your password ",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // زر تسجيل الدخول
                            authProvider.isLoading
                                ? const Center(child: CircularProgressIndicator())
                                : LoginBotton(
                                    text: 'Log in',
                                    color: Theme.of(context).colorScheme.surface,
                                    onTap: () async {
                                      bool success = await authProvider.login();
                                      if (success) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const HomePage(),
                                          ),
                                        );
                                      } else {
                                        // إظهار رسالة خطأ
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Invalid email or password')),
                                        );
                                      }
                                    },
                                  ),
                          ],
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
