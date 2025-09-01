import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graduation_med_/providers/profiles_provider.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';
import 'package:graduation_med_/util/medicine_card.dart'; // تأكد من تحديث الكارت لدعم isTrackerMode

class TrackerPage extends StatelessWidget {
  const TrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfilesProvider>();
    final medProvider = context.watch<MedicineProvider>();
    final userId = profileProvider.activeProfile.id;

    final fullMedicines = medProvider.getFullMedicinesForUser(userId);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: fullMedicines.isEmpty
            ?  Center(child: Text("No medicines to track.",style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade600,
                                    )))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Medicine Tracker',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 
                  Expanded(
                    child: ListView.separated(
                      itemCount: fullMedicines.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final medicine = fullMedicines[index];
                        return MedicineCard(
                          medicine: medicine,
                          isTrackerMode: true,
                          userId: userId,
                          
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
