import 'package:flutter/material.dart';
import 'package:graduation_med_/util/login_botton.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
        title: const Text("Edite Profile"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                    color: Colors.grey),
                    child: IconButton(onPressed: (){}, icon:Icon( Icons.edit)),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "mohammed.ali@gmail.com",
                    border: customBorder,
                    enabledBorder: customBorder,
                    focusedBorder: customBorder,
                  ),
                ),
                 const SizedBox(height: 20),
            
            
            
            
                 
                
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Mohammed Ali",
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
                      items: ['Male', 'Gender', 'Female'].map((String value) {
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
                    labelText: "08/08/1978",
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
                    labelText: "No Medical Diagnosis",
                    border: customBorder,
                    enabledBorder: customBorder,
                    focusedBorder: customBorder,
                  ),
                ),
                const SizedBox(height: 20),
                
                LoginBotton(text: 'Save', color: Theme.of(context).colorScheme.surface,
            
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
