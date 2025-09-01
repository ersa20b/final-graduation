import 'package:flutter/material.dart';
import 'package:graduation_med_/models/profile_model.dart';
import 'package:graduation_med_/providers/profiles_provider.dart';
import 'package:graduation_med_/util/login_botton.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddDependentPage extends StatefulWidget {
  const AddDependentPage({super.key});

  @override
  State<AddDependentPage> createState() => _AddDependentPageState();
}

class _AddDependentPageState extends State<AddDependentPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController diagnosisController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  String selectedGender = 'Gender';
  DateTime? dateOfBirth;

  final OutlineInputBorder customBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(color: Colors.grey),
  );

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dateOfBirth = picked;
        dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

 void _submit() async {
  if (nameController.text.isEmpty ||
      selectedGender == 'Gender' ||
      dateOfBirth == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please complete all required fields')),
    );
    return;
  }

  final newDependent = ProfileModel(
    id: const Uuid().v4(),
    name: nameController.text.trim(),
    email: '',
    gender: selectedGender,
    birthDate: dateOfBirth!,
    diagnosis: diagnosisController.text.trim(),
    isMainUser: false,
  );

  final provider = context.read<ProfilesProvider>();
  await provider.addDependentToFirestore(newDependent); //  تخزين في Firestore

  Navigator.pop(context, newDependent); //  يرجع البروفايل المضاف
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("New Dependent"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Full Name', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  border: customBorder,
                  enabledBorder: customBorder,
                  focusedBorder: customBorder,
                ),
              ),
              const SizedBox(height: 20),
              const Text('Gender', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedGender,
                    isExpanded: true,
                    items: ['Gender', 'Male', 'Female'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => selectedGender = value!),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Date of Birth', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: dobController,
                readOnly: true,
                onTap: _selectDate,
                decoration: InputDecoration(
                  labelText: "Date of Birth",
                  border: customBorder,
                  enabledBorder: customBorder,
                  focusedBorder: customBorder,
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Medical Diagnosis', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: diagnosisController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Medical Diagnosis",
                  border: customBorder,
                  enabledBorder: customBorder,
                  focusedBorder: customBorder,
                ),
              ),
              const SizedBox(height: 20),
              LoginBotton(
                text: 'Add Dependent',
                color: Theme.of(context).colorScheme.surface,
                onTap: _submit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
