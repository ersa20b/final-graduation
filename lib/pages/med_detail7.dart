import 'package:flutter/material.dart';
import 'package:graduation_med_/util/login_botton.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MedDetail7 extends StatefulWidget {
  const MedDetail7({super.key});

  @override
  State<MedDetail7> createState() => _MedDetail7State();
}

class _MedDetail7State extends State<MedDetail7> {
  final picker = ImagePicker();
  File? selectedImage;

  Future<void> pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // الجزء العلوي (مثلاً صور أو محتوى لاحق)
            SizedBox(height: screenHeight * 0.6),
        
            // الجزء السفلي
            Container(
              height: screenHeight * 0.4,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Details:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
        
                    const SizedBox(height: 10),
        
                    // ✅ حقل الاسم + الكاميرا / الصورة الملتقطة
                    TextField(
                      decoration: InputDecoration(
                        hintText: '* name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: selectedImage != null
    ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            // فتح نافذة تكبير الصورة
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("هل ترغب في استخدام هذه الصورة؟"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.file(selectedImage!),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context); // استخدم الصورة
                          },
                          icon: const Icon(Icons.check),
                          label: const Text("استخدام"),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context); // غلق الـ Dialog
                            pickImageFromCamera(); // فتح الكاميرا من جديد
                          },
                          icon: const Icon(Icons.camera_alt),
                          label: const Text("إعادة"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              selectedImage!,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
      )
    : GestureDetector(
        onTap: pickImageFromCamera,
        child: const Icon(Icons.camera_alt),
      ),

                      ),
                    ),
        
                    const SizedBox(height: 10),
        
                    // حقل الطبيب
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Prescribed by: Doctor Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
        
                    const SizedBox(height: 8),
        
                    // زر الإضافة - placeholder فقط
                    Expanded(child: LoginBotton(text: 'Add', color: Theme.of(context).colorScheme.surface))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
