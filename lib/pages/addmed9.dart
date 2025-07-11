import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_med_/util/base3donia.dart';

class InjectionDosage extends StatefulWidget {
  const InjectionDosage({super.key});

  @override
  State<InjectionDosage> createState() => _InjectionDosageState();
}

class _InjectionDosageState extends State<InjectionDosage> {
  final TextEditingController _volumeController = TextEditingController(text: "10");
  final List<String> _units = ['ml', 'mg'];
  int _selectedIndex = 1;

  void _showUnitPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Stack(
            children: [
              // Highlight box (stays centered behind selected item)
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Picker on top of highlight
              CupertinoPicker(
                backgroundColor: Colors.white,
                scrollController: FixedExtentScrollController(initialItem: _selectedIndex),
                itemExtent: 40.0,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: _units.map((unit) {
                  return Center(
                    child: Text(
                      unit,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.light().colorScheme.onSurface,
      body: Base3(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Unit of injection medication dosage:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset(
                  'assets/images/injection.PNG',
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _volumeController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _showUnitPicker,
                    child: Container(
                      width: 80,
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _units[_selectedIndex],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  print("Dosage: ${_volumeController.text} ${_units[_selectedIndex]}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB4E4F6),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
