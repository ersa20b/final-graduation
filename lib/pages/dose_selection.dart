import 'package:flutter/material.dart';
import 'package:graduation_med_/pages/dose_details.dart';

class DosesSelectionScreen extends StatefulWidget {
  final int totalPhases;

  const DosesSelectionScreen({Key? key, required this.totalPhases}) : super(key: key);

  @override
  _DosesSelectionScreenState createState() => _DosesSelectionScreenState();
}

class _DosesSelectionScreenState extends State<DosesSelectionScreen> {
  late List<TextEditingController> _doseControllers;

  @override
  void initState() {
    super.initState();
    _doseControllers =
        List.generate(widget.totalPhases, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _doseControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _goToNext() {
    final allValid = _doseControllers.every(
        (c) => c.text.trim().isNotEmpty && int.tryParse(c.text.trim()) != null);

    if (!allValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى إدخال عدد الجرعات لكل مرحلة")),
      );
      return;
    }

    List<int> dosesPerPhase = _doseControllers
        .map((c) => int.parse(c.text.trim()))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DoseDetailsScreen(
          dosesPerPhase: dosesPerPhase,
        ),
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
                  final estimatedItemHeight = 120.0; // ارتفاع تقريبي لكل بطاقة
                  final contentHeight = (widget.totalPhases * estimatedItemHeight) + 80; // + مساحة للزر
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
                              children: List.generate(widget.totalPhases, (index) {
                                return Card(
                                  color: Colors.white, // خلفية الكارد أبيض
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
                                          "المرحلة ${index + 1}",
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
                                          decoration: const InputDecoration(
                                            labelText: "عدد الجرعات في اليوم",
                                            labelStyle: TextStyle(color: Colors.black),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black, width: 2),
                                            ),
                                          ),
                                        ),
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
                            onPressed: _goToNext,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB5E3EB),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'التالي',
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
