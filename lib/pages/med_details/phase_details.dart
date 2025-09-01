import 'package:flutter/material.dart';
import 'package:graduation_med_/pages/med_details/dose_selection.dart';
import 'package:provider/provider.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';

class PhaseDetailsScreen extends StatefulWidget {
  final int totalPhases;
  const PhaseDetailsScreen({super.key, required this.totalPhases});

  @override
  State<PhaseDetailsScreen> createState() => _PhaseDetailsScreenState();
}

class _PhaseDetailsScreenState extends State<PhaseDetailsScreen> {
  final List<String> weekDays = [
    "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
  ];

  @override
  void initState() {
    super.initState();
   
    Future.microtask(() {
      Provider.of<MedicineProvider>(context, listen: false)
          .initializePhases(widget.totalPhases);
    });
  }


  void _goToNext() {
    final provider = Provider.of<MedicineProvider>(context, listen: false);


    bool validDateOrder = true;
    for (int i = 1; i < provider.phaseStartDates.length; i++) {
      final prevEnd = provider.phaseEndDates[i - 1];
      final currentStart = provider.phaseStartDates[i];

      if (prevEnd != null &&
          currentStart != null &&
          currentStart.isBefore(prevEnd)) {
        validDateOrder = false;
        break;
      }
    }

    if (!validDateOrder) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Each phase must start after the previous one ends."),
        ),
      );
      return;
    }


    for (int i = 0; i < provider.totalPhases; i++) {
      final days = provider.phaseDurations[i];
      final start = provider.phaseStartDates[i];
      final end = provider.phaseEndDates[i];

      if (days.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select dose days for phase ${i + 1}")),
        );
        return;
      }

      if (start == null || end == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select start and end date for phase ${i + 1}")),
        );
        return;
      }
    }


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DosesSelectionScreen(
          totalPhases: provider.totalPhases,
          phaseDurations: provider.phaseDurations,
          phaseStartDates: provider.phaseStartDates,
          phaseEndDates: provider.phaseEndDates,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MedicineProvider>();

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
                      itemCount: provider.totalPhases,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.grey.shade50,
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  "Phase ${index + 1}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),

                               
                                InkWell(
                                  onTap: () async {
                                    final selectedDays =
                                        provider.phaseDurations[index];
                                    final result =
                                        await showDialog<List<String>>(
                                      context: context,
                                      builder: (context) {
                                        final tempSelected =
                                            List<String>.from(selectedDays);
                                        return AlertDialog(
                                          title: const Text("Select dose days"),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: weekDays.map((day) {
                                                return StatefulBuilder(
                                                  builder: (context,
                                                      setStateDialog) {
                                                    return CheckboxListTile(
                                                      title: Text("Every $day"),
                                                      value: tempSelected.contains(day),
                                                      onChanged: (checked) {
                                                        setStateDialog(() {
                                                          if (checked == true) {
                                                            tempSelected.add(day);
                                                          } else {
                                                            tempSelected.remove(day);
                                                          }
                                                        });
                                                      },
                                                    );
                                                  },
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, tempSelected),
                                              child: const Text("Done"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    if (result != null) {
                                      provider.setPhaseDurations(index, result);
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      provider.phaseDurations[index].isNotEmpty
                                          ? provider.phaseDurations[index].join(", ")
                                          : "Select dose days",
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                
                                Row(
                                  children: [
                                    // Start Date
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          DateTime? prevEnd = index > 0
                                              ? provider.phaseEndDates[index - 1]
                                              : null;

                                          DateTime firstDate = prevEnd != null
                                              ? prevEnd.add(const Duration(days: 1))
                                               : DateTime.now();


                                          DateTime initialDate =
                                              provider.phaseStartDates[index] ??
                                                  firstDate;

                                          if (initialDate.isBefore(firstDate)) {
                                            initialDate = firstDate;
                                          }

                                          DateTime? picked =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: initialDate,
                                            firstDate: firstDate,
                                            lastDate: DateTime(2100),
                                          );
                                          if (picked != null) {
                                            provider.setPhaseStartDate(index, picked);
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            provider.phaseStartDates[index] != null
                                                ? "${provider.phaseStartDates[index]!.day}/${provider.phaseStartDates[index]!.month}/${provider.phaseStartDates[index]!.year}"
                                                : "Start of the phase",
                                            style: TextStyle(
                                                color: Colors.grey.shade700),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    // End Date
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          DateTime start =
                                              provider.phaseStartDates[index] ??
                                                  DateTime.now();

                                          DateTime initialDate =
                                              provider.phaseEndDates[index] ??
                                                  start;

                                          if (initialDate.isBefore(start)) {
                                            initialDate = start;
                                          }

                                          DateTime? picked =
                                              await showDatePicker(
                                            context: context,
                                            initialDate: initialDate,
                                            firstDate: start,
                                            lastDate: DateTime(2100),
                                          );
                                          if (picked != null) {
                                            provider.setPhaseEndDate(index, picked);
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            provider.phaseEndDates[index] != null
                                                ? "${provider.phaseEndDates[index]!.day}/${provider.phaseEndDates[index]!.month}/${provider.phaseEndDates[index]!.year}"
                                                : "End of the phase",
                                            style: TextStyle(
                                                color: Colors.grey.shade700),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _goToNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB5E3EB),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
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
