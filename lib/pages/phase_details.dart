import 'package:flutter/material.dart';
import 'package:graduation_med_/pages/dose_selection.dart';

class PhaseDetailsScreen extends StatefulWidget {
  final int totalPhases;

  const PhaseDetailsScreen({Key? key, required this.totalPhases}) : super(key: key);

  @override
  _PhaseDetailsScreenState createState() => _PhaseDetailsScreenState();
}

class _PhaseDetailsScreenState extends State<PhaseDetailsScreen> {
  late List<TextEditingController> _nameControllers;
  late List<TextEditingController> _durationControllers;

  @override
  void initState() {
    super.initState();
    _nameControllers = List.generate(widget.totalPhases, (_) => TextEditingController());
    _durationControllers = List.generate(widget.totalPhases, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _nameControllers) {
      controller.dispose();
    }
    for (var controller in _durationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _goToNext() {
    final allValid = _nameControllers.every((c) => c.text.trim().isNotEmpty) &&
        _durationControllers.every((c) => c.text.trim().isNotEmpty);

    if (!allValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى تعبئة كل الحقول")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DosesSelectionScreen(
          totalPhases: widget.totalPhases,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final maxContainerHeight = screenHeight * 0.7;

    return Scaffold(
      backgroundColor:  Colors.grey.shade100,
      body: Column(
        children: [
          const Spacer(flex: 5), // مساحة فوق الكونتينر مشابهة للصفحة الأولى
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
                  // حساب ارتفاع المحتوى المطلوب
                  final estimatedItemHeight = 150.0; // تقريب ارتفاع كل بطاقة مع مسافات
                  final contentHeight = (widget.totalPhases * estimatedItemHeight) + 80; // +80 للزر والبادينغ

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
                                  color: Colors.white,
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
                                          "مرحلة ${index + 1}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: _nameControllers[index],
                                          decoration: const InputDecoration(
                                            labelText: "اسم المرحلة",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: _durationControllers[index],
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            labelText: "المدة (بالأيام)",
                                            border: OutlineInputBorder(),
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
