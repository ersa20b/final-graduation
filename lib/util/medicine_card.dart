import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:graduation_med_/models/medicine_full_model.dart';
import 'package:graduation_med_/models/dose_state.dart';
import 'package:graduation_med_/models/overdose_model.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';
import 'package:provider/provider.dart';

class MedicineCard extends StatelessWidget {
  final MedicineFullModel medicine;
  final bool isTrackerMode;
  final String? userId;
  final int? medicineIndex;

  const MedicineCard({
    Key? key,
    required this.medicine,
    this.isTrackerMode = false,
    this.userId,
    this.medicineIndex,
  }) : super(key: key);

  String getDaysSummary() {
    final allPhaseDays = medicine.phaseDurations;
    const fullWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

    bool allPhasesHaveAllDays = allPhaseDays.every((phaseDays) {
      return phaseDays.toSet().containsAll(fullWeek);
    });

    if (allPhaseDays.length == 1) {
      final days = allPhaseDays.first;
      return Set.from(days).containsAll(fullWeek) ? "daily" : "specific days";
    }

    return allPhasesHaveAllDays ? "daily" : "specific days";
  }

  String getSmartDoseSummary() {
    final doses = medicine.doses.map((phase) => phase.length).toList();

    if (doses.length == 1) {
      return '${doses[0]} dose${doses[0] > 1 ? 's' : ''} per day';
    }

    final allSame = doses.every((dose) => dose == doses[0]);

    return allSame
        ? '${doses[0]} dose${doses[0] > 1 ? 's' : ''} per day'
        : 'variable doses';
  }

  Color getColorForDoseState(DoseState state) {
    switch (state) {
      case DoseState.taken:
        return Colors.green;
      case DoseState.missed:
        return Colors.red;
      case DoseState.cancelled:
        return Colors.brown;
      case DoseState.none:
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final daysSummary = getDaysSummary();
    final doseSummary = getSmartDoseSummary();
    final isOverdose = medicine.overdoseStatus == OverdoseStatus.overdose;

    final provider = context.watch<MedicineProvider>();
    final warnings = provider.medicineWarnings[medicine.medicineName] ?? [];
    final hasInteraction = warnings.isNotEmpty;

    return Card(
      color: isOverdose || hasInteraction
          ? Colors.red.shade50
          : Theme.of(context).colorScheme.onSecondary,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ------------------- Header -------------------
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    medicine.imagePath ?? 'assets/images/drug.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicine.medicineName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Dr. ${medicine.doctorName}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ------------------- Details -------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(daysSummary,
                    style:
                        TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                Text(doseSummary,
                    style:
                        TextStyle(fontSize: 16, color: Colors.grey.shade600)),
              ],
            ),

            // ------------------- Tracker Mode -------------------
            if (isTrackerMode) ...[
              const SizedBox(height: 16),
              buildDoseTracking(context),
            ],
          ],
        ),
      ),
    );
  }

  /// ✅ الدوائر تعرض فقط حالة الجرعات (بدون onTap)
  Widget buildDoseTracking(BuildContext context) {
  final doseStates = medicine.doseStates;

  if (doseStates.isEmpty) {
    return const Text("No tracking data available");
  }

  // نرتب التواريخ باش يطلعو بالترتيب
  final sortedEntries = doseStates.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: sortedEntries.map((entry) {
        final date = entry.key;
        final state = entry.value;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: state.color, // 👈 اللون جاي من DoseStateExtension
            border: Border.all(color: Colors.grey.shade500, width: 1.2),
          ),
          child: Text(
            DateFormat.E('en_US').format(date), // Sun, Mon, Tue...
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        );
      }).toList(),
    ),
  );
}

}
