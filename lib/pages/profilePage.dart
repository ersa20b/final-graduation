// صفحة البروفايل الأساسية (Main Profile Page)
import 'package:flutter/material.dart';
import 'package:graduation_med_/pages/add_dependent_page.dart';
import 'package:graduation_med_/util/dependent_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Map<String, dynamic>> dependents = [];

  void _addDependent(Map<String, dynamic> dependent) {
    setState(() {
      dependents.add(dependent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Center(child: const Text("Profile",style: TextStyle(fontWeight: FontWeight.bold),)),
      backgroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(radius: 40),
            const SizedBox(height: 10),
            const Text("Mohammed Ali", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("mohammed.ali@gmail.com"),
            const SizedBox(height: 20),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Dependencies", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: const Icon(Icons.add_box,color: Colors.grey,),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddDependentPage(),
                      ),
                    );
                    if (result != null) _addDependent(result);
                  },
                ),
                
                
              ],
              
            ),
             Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: dependents.length,
                itemBuilder: (context, index) {
                  final dep = dependents[index];
                  return DependentCard(
                    name: dep['name'],
                    profileNumber: "No. ${index + 2}",
                    medicineCount: dep['medicineCount'] ?? 0,
                    onTap: () {},
                    onEdit: () {},
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
