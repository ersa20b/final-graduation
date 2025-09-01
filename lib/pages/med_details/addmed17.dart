import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';

class Addmed17 extends StatefulWidget {
  const Addmed17({Key? key}) : super(key: key);

  @override
  State<Addmed17> createState() => _Addmed17State();
}

class _Addmed17State extends State<Addmed17> {
  late int numberOfPuffs;

  @override
  void initState() {
    super.initState();
    final provider = context.read<MedicineProvider>();
    numberOfPuffs = provider.puffsPerDose;
  }

  void _increment() {
    setState(() {
      numberOfPuffs++;
    });
  }

  void _decrement() {
    if (numberOfPuffs > 1) {
      setState(() {
        numberOfPuffs--;
      });
    }
  }

  void _goToNext() {
    context.read<MedicineProvider>().setPuffsPerDose(numberOfPuffs);
    Navigator.pushNamed(context, '/meddetail7');
  }

  @override
  Widget build(BuildContext context) {
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Number of actuations/puffs per dose:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCounterButton(icon: Icons.remove, onPressed: _decrement),
                      const SizedBox(width: 24),
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
                          numberOfPuffs.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      _buildCounterButton(icon: Icons.add, onPressed: _increment),
                    ],
                  ),
                  const SizedBox(height: 32),
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
