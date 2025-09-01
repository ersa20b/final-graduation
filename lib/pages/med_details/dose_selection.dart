import 'package:flutter/material.dart';
import 'package:graduation_med_/pages/med_details/dose_details.dart';
import 'package:provider/provider.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';

class DosesSelectionScreen extends StatefulWidget {
  final int totalPhases;
  final List<List<String>> phaseDurations;
  final List<DateTime?> phaseStartDates;
  final List<DateTime?> phaseEndDates;

  const DosesSelectionScreen({
    super.key,
    required this.totalPhases,
    required this.phaseDurations,
    required this.phaseStartDates,
    required this.phaseEndDates,
  });

  @override
  State<DosesSelectionScreen> createState() => _DosesSelectionScreenState();
}

class _DosesSelectionScreenState extends State<DosesSelectionScreen> {
  final List<TextEditingController> _doseControllers = []; 
  final List<TextEditingController> _doseSizeControllers = []; 
  final Set<int> _invalidDoseIndices = {};

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<MedicineProvider>(context, listen: false);

    
    provider.initializeDoseSizes(widget.totalPhases);

    _doseControllers.clear();
    _doseSizeControllers.clear();

    for (int i = 0; i < widget.totalPhases; i++) {
      _doseControllers.add(TextEditingController());
      _doseSizeControllers.add(TextEditingController(
        text: provider.doseSizes.length > i
            ? provider.doseSizes[i].toString()
            : "",
      ));
    }
  }

  void _validateAndProceed() {
    final provider = Provider.of<MedicineProvider>(context, listen: false);
    _invalidDoseIndices.clear();

    List<int> dosesPerPhase = [];

    for (int i = 0; i < widget.totalPhases; i++) {
      final text = _doseControllers[i].text.trim();
      final parsed = int.tryParse(text);

      if (parsed == null || parsed <= 0) {
        _invalidDoseIndices.add(i);
      } else {
        dosesPerPhase.add(parsed);
      }
    }

    setState(() {});

    if (_invalidDoseIndices.isNotEmpty) return;


    provider.initializeDoses(widget.totalPhases, dosesPerPhase);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DoseDetailsScreen(),
        settings: RouteSettings(arguments: {
          'numberOfPhases': widget.totalPhases,
          'dosesPerPhase': dosesPerPhase,
        }),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _doseControllers) {
      controller.dispose();
    }
    for (final controller in _doseSizeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MedicineProvider>(context);

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
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(widget.totalPhases, (index) {
                          return Card(
                            color: Colors.grey.shade50,
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phase ${index + 1}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                 
                                  TextField(
                                    controller: _doseControllers[index],
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      labelText: "Number of doses per day",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade700),
                                      labelStyle: TextStyle(
                                          color: Colors.grey.shade700),
                                      border: const OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: _invalidDoseIndices
                                                  .contains(index)
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .error
                                              : Colors.grey,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: _invalidDoseIndices
                                                  .contains(index)
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .error
                                              : Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                      errorText:
                                          _invalidDoseIndices.contains(index)
                                              ? "Please enter a valid number"
                                              : null,
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                  
                                 
Row(
  children: [
    Expanded(
      child: TextField(
        controller: _doseSizeControllers[index],
        onChanged: (value) {
          final parsed = double.tryParse(value);
          provider.updateDoseSizeForPhase(index, parsed ?? 0.0);
        },
        keyboardType: TextInputType.number,
        textDirection: TextDirection.ltr,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: "Dose size",
          hintText: "e.g. 500",
          hintStyle: TextStyle(color: Colors.grey.shade700),
          border: const OutlineInputBorder(),
        ),
      ),
    ),
    const SizedBox(width: 10),
    SizedBox(
  width: 100, 
  child: DropdownButtonFormField<String>(
    isExpanded: true, 
    value: provider.doseUnit,
    items: ["mg", "ml", "tablet", "capsule"].map((unit) {
      return DropdownMenuItem(
        value: unit,
        child: Text(unit, overflow: TextOverflow.ellipsis), 
      );
    }).toList(),
    onChanged: (val) {
      if (val != null) provider.setDoseUnit(val);
    },
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      labelText: "Unit",
    ),
  ),
),

  ],
)

                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _validateAndProceed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB5E3EB),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'Next',
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
