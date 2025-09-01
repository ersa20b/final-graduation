import 'package:flutter/material.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';
import 'package:provider/provider.dart';

class Addmed6 extends StatelessWidget {
  const Addmed6({super.key});

  void _selectShape(BuildContext context, String shape, String route) {
  print(" Shape selected in Addmed6: $shape"); 
  context.read<MedicineProvider>().selectShape(shape);
  Navigator.pushNamed(context, route);
}


  @override
  Widget build(BuildContext context) {
    final selected = context.watch<MedicineProvider>().selectedShape;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const Spacer(flex: 5),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildShapeButton(context, label: 'حبة', imagePath: 'assets/images/drug.png', route: '/addmed14', isSelected: selected == 'حبة'),
                      _buildShapeButton(context, label: 'حقنة', imagePath: 'assets/images/injection.png', route: '/addmed13', isSelected: selected == 'حقنة'),
                      _buildShapeButton(context, label: 'قطرة', imagePath: 'assets/images/dropper.png', route: '/addmed18', isSelected: selected == 'قطرة'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildShapeButton(context, label: 'شراب', imagePath: 'assets/images/bluebottle.png', route: '/addmed12', isSelected: selected == 'شراب'),
                      _buildShapeButton(context, label: 'كريم', imagePath: 'assets/images/C9C395AC-FCE9-471C-8A72-0BC6803BB887 1.png', route: '/meddetail7', isSelected: selected == 'كريم'),
                      _buildShapeButton(context, label: 'بخاخة', imagePath: 'assets/images/6AEAE757-D8BE-4C19-9FCA-560FA3CE2239.png', route: '/addmed16', isSelected: selected == 'بخاخة'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShapeButton(
    BuildContext context, {
    required String label,
    required String imagePath,
    required String route,
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: () => _selectShape(context, label, route),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          border: isSelected
              ? Border.all(
                  width: 2,
                  color: Theme.of(context).colorScheme.primary,
                )
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    blurRadius: 8,
                    spreadRadius: 1,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                  )
                ]
              : null,
        ),
        height: 80,
        width: 80,
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
