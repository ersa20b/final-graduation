import 'package:flutter/material.dart';
import 'package:graduation_med_/util/edit_profile.dart';

class DependentCard extends StatelessWidget {
  final String name;
  final String profileNumber;
  final int medicineCount;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  const DependentCard({
    super.key,
    required this.name,
    required this.profileNumber,
    required this.medicineCount,
    required this.onTap,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profileNumber, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(name),
                  const SizedBox(height: 4),
                  Text("Number Of Medicines: $medicineCount"),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: (){
                 Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const EditProfile();
                              }
                              )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}