import 'package:flutter/material.dart';
import 'package:graduation_med_/util/login_botton.dart';

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
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Full Name',style: TextStyle(fontWeight: FontWeight.bold)),
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
              Text('Gender',style: TextStyle(fontWeight: FontWeight.bold)),
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
              Text('Date of Birth',style: TextStyle(fontWeight: FontWeight.bold)),
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
              Text('Medical Diagnosis',style: TextStyle(fontWeight: FontWeight.bold),),
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
              
              LoginBotton(text: 'Add Dependent', color: Theme.of(context).colorScheme.surface,onTap: () {

                Navigator.pop(context, {
                    'name': nameController.text,
                    'gender': selectedGender,
                    'dob': dateOfBirth?.toIso8601String(),
                    'diagnosis': diagnosisController.text,
                    'medicineCount': 0
                  });
              },)
            ],
          ),
        ),
      ),
    );
  }
}
