import 'package:flutter/material.dart';
import 'package:graduation_med_/pages/med_details/phase_details.dart';
import 'package:provider/provider.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';

class TreatmentPhasesInput extends StatelessWidget {
  const TreatmentPhasesInput({super.key});

  void _updatePhaseCount(BuildContext context, int delta) {
    final provider = Provider.of<MedicineProvider>(context, listen: false);
    int newCount = provider.numberOfPhases + delta;
    if (newCount < 1) return;
    provider.setNumberOfPhases(newCount);
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
                      _buildCounterButton(
                      
                        icon: Icons.remove,
                        onPressed: () => _updatePhaseCount(context, -1),
                      ),
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
                          provider.numberOfPhases.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      _buildCounterButton(

                        icon: Icons.add,
                        onPressed: () => _updatePhaseCount(context, 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PhaseDetailsScreen(
                              totalPhases: provider.numberOfPhases,
                            ),
                          ),
                        );
                      },
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

  Widget _buildCounterButton({
    required IconData icon,
    required VoidCallback onPressed,
  
  }) {
    return ElevatedButton(
      
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
       
        minimumSize: const Size(50, 50),
        padding: EdgeInsets.zero,
      ),
      child: Icon(icon, color: Colors.black, size: 30),
    );
  }
}
