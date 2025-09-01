import 'package:flutter/material.dart';
import 'package:graduation_med_/providers/profiles_provider.dart';
import 'package:provider/provider.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';
import 'package:graduation_med_/models/dose_model.dart';

class MedicineDetailsScreen extends StatelessWidget {
  const MedicineDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final index = args['index'] as int;

    final profileProvider = Provider.of<ProfilesProvider>(context, listen: false);
    final userId = profileProvider.activeProfile.id;

    final provider = Provider.of<MedicineProvider>(context);
    final medicine = provider.getFullMedicinesForUser(userId)[index];

    String _shortenDay(String day) {
      switch (day.trim().toLowerCase()) {
        case "every sunday":
          return "Sun";
        case "every monday":
          return "Mon";
        case "every tuesday":
          return "Tue";
        case "every wednesday":
          return "Wed";
        case "every thursday":
          return "Thu";
        case "every friday":
          return "Fri";
        case "every saturday":
          return "Sat";
        default:
          return day;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Center(
              child: Image.asset(
                medicine.imagePath ?? 'assets/images/drug.png',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

          
            _section("Medicine's Name", medicine.medicineName),
            _section("Doctor", medicine.doctorName),

            const SizedBox(height: 16),
            const Text(
              "Phases & Doses Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            ListView.builder(
              itemCount: medicine.numberOfPhases,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, i) {
                final start = medicine.phaseStartDates[i];
                final end = medicine.phaseEndDates[i];
                final days = medicine.phaseDurations[i];
                final doseSize = medicine.doseSizes[i];
                final phaseDoses = medicine.doses[i]; 

                return Card(
                  color: Colors.grey.shade200,
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Phase ${i + 1}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Start: ${start != null ? start.toString().split(' ').first : 'Not set'}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "End: ${end != null ? end.toString().split(' ').first : 'Not set'}",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            "Days: ${days.map((day) => _shortenDay(day)).join(', ')}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Dose Size: $doseSize",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                         Text(
                          "Doses:",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...phaseDoses.map(
                          (DoseModel d) => Text(
                            "• ${d.time?.format(context) ?? 'Not set'}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _section(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
