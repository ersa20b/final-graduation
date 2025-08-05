import 'package:flutter/material.dart';
import 'package:graduation_med_/pages/home_page.dart';

class DoseDetailsScreen extends StatefulWidget {
  final List<int> dosesPerPhase;

  const DoseDetailsScreen({Key? key, required this.dosesPerPhase}) : super(key: key);

  @override
  _DoseDetailsScreenState createState() => _DoseDetailsScreenState();
}

class _DoseDetailsScreenState extends State<DoseDetailsScreen> {
  late List<List<TimeOfDay?>> _doseTimes;

  @override
  void initState() {
    super.initState();

    _doseTimes = [];
    for (int i = 0; i < widget.dosesPerPhase.length; i++) {
      int doses = widget.dosesPerPhase[i];
      _doseTimes.add(List.generate(doses, (_) => null));
    }
  }

  void _pickTime(int phaseIndex, int doseIndex) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _doseTimes[phaseIndex][doseIndex] ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _doseTimes[phaseIndex][doseIndex] = picked;
      });
    }
  }

  void _finish() {
    bool allValid = true;

    for (var phaseTimes in _doseTimes) {
      for (var time in phaseTimes) {
        if (time == null) {
          allValid = false;
          break;
        }
      }
      if (!allValid) break;
    }

    if (!allValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى اختيار وقت لكل جرعة")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تم الانتهاء من تحديد مواعيد الجرعات بنجاح ✅")),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final maxContainerHeight = screenHeight * 0.7;

    return Scaffold(
      backgroundColor: Colors.grey.shade100, // خلفية بيضاء
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // حساب ارتفاع تقريبي
                  final estimatedItemHeight = 80.0 + 72.0 * (widget.dosesPerPhase.fold<int>(0, (prev, e) => prev + e));
                  final contentHeight = estimatedItemHeight + 80; // اضافة مساحة للزر
                  final containerHeight = contentHeight < maxContainerHeight
                      ? contentHeight
                      : maxContainerHeight;

                  return SizedBox(
                    height: containerHeight,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(widget.dosesPerPhase.length, (phaseIndex) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "المرحلة ${phaseIndex + 1}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Column(
                                      children: List.generate(widget.dosesPerPhase[phaseIndex], (doseIndex) {
                                        return Card(
                                          color: Colors.white, // خلفية الكارد أبيض
                                          margin: const EdgeInsets.symmetric(vertical: 8),
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              "جرعة ${doseIndex + 1}",
                                              style: const TextStyle(color: Colors.black),
                                            ),
                                            trailing: InkWell(
                                              onTap: () => _pickTime(phaseIndex, doseIndex),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey.shade100),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  _doseTimes[phaseIndex][doseIndex]?.format(context) ?? "اختر الوقت",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _finish,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB5E3EB),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'إنهاء',
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
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
