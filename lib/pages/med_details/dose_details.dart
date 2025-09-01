import 'package:flutter/material.dart';
import 'package:graduation_med_/models/dose_model.dart';
import 'package:graduation_med_/models/medicine_card_model.dart';
import 'package:graduation_med_/services/notifications_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:graduation_med_/pages/screens/home_page.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';
import 'package:graduation_med_/providers/profiles_provider.dart';


class DoseDetailsScreen extends StatefulWidget {
  const DoseDetailsScreen({Key? key}) : super(key: key);

  @override
  State<DoseDetailsScreen> createState() => _DoseDetailsScreenState();
}

class _DoseDetailsScreenState extends State<DoseDetailsScreen> {
  final Set<String> _missingTimes = {}; 

  Future<void> _pickTime(
      BuildContext context, int phaseIndex, int doseIndex) async {
    final provider = context.read<MedicineProvider>();
    final current = provider.doses[phaseIndex][doseIndex].time;

    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: current ?? const TimeOfDay(hour: 8, minute: 0),
    );

    if (picked != null) {
      provider.setDoseTime(phaseIndex, doseIndex, picked);
      setState(() {
        _missingTimes.remove('$phaseIndex-$doseIndex');
      });
    }
  }

Future<void> _finish(BuildContext context) async {
  final medProvider = context.read<MedicineProvider>();
  final profileProvider = context.read<ProfilesProvider>();
  final userId = profileProvider.activeProfile.id;
  final birthDate = profileProvider.activeProfile.birthDate;

  final doses = medProvider.doses;
  _missingTimes.clear();

  // ✅ تحقق من التواقيت
  for (int i = 0; i < doses.length; i++) {
    for (int j = 0; j < doses[i].length; j++) {
      if (doses[i][j].time == null) {
        _missingTimes.add('$i-$j');
      }
    }
  }

  if (_missingTimes.isNotEmpty) {
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Please select a time for each dose")),
    );
    return;
  }

  // ✅ تكوين موديل الدواء الكامل
  final fullMed = medProvider.extractCurrentMedicine();

  // ✅ الحفظ في Firestore مع فحص الأوفر دوز
  await medProvider.saveMedicineToFirebase(
    userId: userId,
    fullMedicine: fullMed,
    birthDate: birthDate!,
  );

  // ✅ نكوّن الكارت بنفس الـ id
  final card = MedicineCardModel(
    id: fullMed.id,
    imagePath: fullMed.imagePath ?? 'assets/images/drug.png',
    medicineName: fullMed.medicineName,
    doctorName: fullMed.doctorName,
    days: fullMed.phaseDurations.expand((d) => d).toList(),
    dosesPerDay: fullMed.dosesPerDay,
  );

  medProvider.addMedicineForUser(userId, card);
  print(" Added card for ${card.medicineName} with id=${card.id}");

  // ✅ جدولة إشعارات لكل الجرعات
  for (int phaseIndex = 0; phaseIndex < fullMed.doses.length; phaseIndex++) {
    final phase = fullMed.doses[phaseIndex];
    for (var dose in phase) {
      if (dose.time != null) {
        final now = DateTime.now();
        final doseTime = DateTime(
          now.year,
          now.month,
          now.day,
          dose.time!.hour,
          dose.time!.minute,
        );

        await NotificationsService.scheduleDoseNotification(
          userId: userId,
          medicineId: fullMed.id,
          medicineName: fullMed.medicineName,
          phaseIndex: phaseIndex,
          doseId: dose.id,
          doseTime: doseTime,
        );

        print("⏰ Scheduled dose notification for ${fullMed.medicineName} "
            "phase $phaseIndex at ${dose.time!.format(context)} with id=${dose.id}");
      }
    }
  }

  // ✅ نعيد تحميل الأدوية
  await medProvider.loadMedicinesFromFirebase(userId);

  medProvider.resetAllFields();

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Medicine saved successfully ")),
  );

  if (context.mounted) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomePage()),
      (route) => false,
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MedicineProvider>();
    final doses = provider.doses;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const Spacer(flex: 5),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: doses.length,
                      itemBuilder: (_, phaseIndex) => _PhaseWidget(
                        phaseIndex: phaseIndex,
                        doses: doses[phaseIndex],
                        onPickTime: (doseIndex) =>
                            _pickTime(context, phaseIndex, doseIndex),
                        missingTimes: _missingTimes,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _finish(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB5E3EB),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Finish',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhaseWidget extends StatelessWidget {
  final int phaseIndex;
  final List<DoseModel> doses;
  final Function(int) onPickTime;
  final Set<String> missingTimes;

  const _PhaseWidget({
    required this.phaseIndex,
    required this.doses,
    required this.onPickTime,
    required this.missingTimes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Phase ${phaseIndex + 1}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Column(
          children: List.generate(doses.length, (doseIndex) {
            final key = '$phaseIndex-$doseIndex';
            final isMissing = missingTimes.contains(key);

            return Card(
              color: isMissing ? Colors.red.shade50 : Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(
                  "Dose ${doseIndex + 1}",
                  style: TextStyle(
                    color: isMissing ? Colors.red : Colors.grey.shade700,
                    fontWeight:
                        isMissing ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: TextButton.icon(
                  onPressed: () => onPickTime(doseIndex),
                  icon: Icon(Icons.access_time,
                      color: isMissing ? Colors.red : Colors.grey.shade800),
                  label: Text(
                    doses[doseIndex].time != null
                        ? doses[doseIndex].time!.format(context)
                        : "Pick time",
                    style: TextStyle(
                        color: isMissing ? Colors.red : Colors.grey.shade800),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
