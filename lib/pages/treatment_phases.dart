import 'package:flutter/material.dart';
import 'package:graduation_med_/pages/phase_details.dart';

class TreatmentPhasesInput extends StatefulWidget {
  @override
  _TreatmentPhasesInputState createState() => _TreatmentPhasesInputState();
}

class _TreatmentPhasesInputState extends State<TreatmentPhasesInput> {
  int numberOfPhases = 1;

  void _increment() {
    setState(() {
      numberOfPhases++;
    });
  }

  void _decrement() {
    setState(() {
      if (numberOfPhases > 1) {
        numberOfPhases--;
      }
    });
  }

  void _goToNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PhaseDetailsScreen(
          totalPhases: numberOfPhases,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const Spacer(flex: 5), // مساحة فوق العداد (تقريباً مثل 530px)
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Number of treatment phases",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // زر ناقص
                      _buildCounterButton(icon: Icons.remove, onPressed: _decrement),
                      const SizedBox(width: 24),
                      // الرقم في الوسط
                      Container(
                        width: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          numberOfPhases.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      // زر زائد
                      _buildCounterButton(icon: Icons.add, onPressed: _increment),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // زر التالي
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton({required IconData icon, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: const Color(0xFFB5E3EB),
        minimumSize: const Size(50, 50),
        padding: EdgeInsets.zero,
      ),
      child: Icon(icon, color: Colors.black, size: 30),
    );
  }
}
