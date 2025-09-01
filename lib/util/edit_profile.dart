import 'package:flutter/material.dart';
import 'package:graduation_med_/models/profile_model.dart';
import 'package:graduation_med_/providers/profiles_provider.dart';
import 'package:graduation_med_/util/login_botton.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final ProfileModel profile;

  const EditProfile({super.key, required this.profile});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController nameController;
  late TextEditingController diagnosisController;
  late TextEditingController dobController;

  late String selectedGender;
  late DateTime dateOfBirth;

  final OutlineInputBorder customBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(color: Colors.grey),
  );

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.profile.name);
    diagnosisController = TextEditingController(text: widget.profile.diagnosis);
    dobController = TextEditingController(text: widget.profile.birthDate.toString().split(' ')[0]);
    selectedGender = widget.profile.gender;
    dateOfBirth = widget.profile.birthDate;
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dateOfBirth = picked;
        dobController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  void _save() {
  final updatedProfile = ProfileModel(
    id: widget.profile.id,
    name: nameController.text,
    email: widget.profile.email,
    gender: selectedGender,
    birthDate: dateOfBirth,
    diagnosis: diagnosisController.text,
    isMainUser: widget.profile.isMainUser,
  );

  // تحديت البروفايدر
  final provider = context.read<ProfilesProvider>();
  provider.updateProfile(updatedProfile);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Profile updated successfully ✅")),
  );

  Navigator.pop(context);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Edit Profile"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              

              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: widget.profile.name,
                  border: customBorder,
                  enabledBorder: customBorder,
                  focusedBorder: customBorder,
                ),
              ),

              const SizedBox(height: 20),

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
                    items: ['Male', 'Female'].map((String value) {
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
                text: 'Save',
                color: Theme.of(context).colorScheme.surface,
                onTap: _save,
              )
            ],
          ),
        ),
      ),
    );
  }
}
