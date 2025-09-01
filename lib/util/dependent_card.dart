import 'package:flutter/material.dart';
import 'package:graduation_med_/models/profile_model.dart';
import 'package:graduation_med_/util/edit_profile.dart';

class DependentCard extends StatelessWidget {
  final ProfileModel profile;
  final String profileNumber;
  final int medicineCount;
  final VoidCallback onTap;
  final bool isOwner; //  جديد

  const DependentCard({
    super.key,
    required this.profile,
    required this.profileNumber,
    required this.medicineCount,
    required this.onTap,
    this.isOwner = false, // الافتراضي مش owner
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
                  Text(
                    profileNumber,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(profile.name),
                  const SizedBox(height: 4),
                  if (!isOwner)
                    Text("Number Of Medicines: $medicineCount"),
                  if (isOwner)
                    const Text("Owner Account", style: TextStyle(color: Colors.blueGrey)),
                ],
              ),
            ),
            if (!isOwner)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(profile: profile),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
