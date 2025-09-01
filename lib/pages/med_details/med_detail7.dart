import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:graduation_med_/util/login_botton.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';
import 'package:graduation_med_/util/validators.dart';

class MedDetail7 extends StatefulWidget {
  const MedDetail7({super.key});

  @override
  State<MedDetail7> createState() => _MedDetail7State();
}

class _MedDetail7State extends State<MedDetail7> {
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  Future<void> pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      Provider.of<MedicineProvider>(context, listen: false).setMedicineImage(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final medProvider = Provider.of<MedicineProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const Spacer(flex: 6), 
                    Expanded(
                      flex: 4,
                      child: Container(
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
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Add Details:',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),

                                
                                TextFormField(
                                  onChanged: medProvider.setMedicineName,
                                  validator: (v) => V.minLen(v, 3, label: 'اسم الدواء'),
                                  decoration: InputDecoration(
                                    hintText: '* name',
                                    hintStyle: TextStyle(color: Colors.grey.shade600),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 1.5),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 2),
                                    ),
                                    suffixIcon: medProvider.medicineImage != null
                                        ? GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                  title: const Text("هل ترغب في استخدام هذه الصورة؟"),
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Image.file(medProvider.medicineImage!),
                                                      const SizedBox(height: 10),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          ElevatedButton.icon(
                                                            onPressed: () => Navigator.pop(context),
                                                            icon: Icon(Icons.check, color: Colors.grey.shade600),
                                                            label: const Text("استخدام"),
                                                          ),
                                                          ElevatedButton.icon(
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                              pickImageFromCamera();
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
                                                medProvider.medicineImage!,
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: pickImageFromCamera,
                                            child: Icon(Icons.camera_alt, color: Colors.grey.shade600),
                                          ),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                TextField(
                                  onChanged: medProvider.setDoctorName,
                                  decoration: InputDecoration(
                                    hintText: 'Prescribed by: Doctor Name',
                                    hintStyle: TextStyle(color: Colors.grey.shade600),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                
                                LoginBotton(
                                  text: 'Next',
                                  color: Theme.of(context).colorScheme.surface,
                                  onTap: () {
                                    if (_formKey.currentState?.validate() != true) return;
                                    Navigator.pushNamed(context, '/medalarm18');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
