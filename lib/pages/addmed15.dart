import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_med_/util/base3donia.dart';

class LiquidDose extends StatefulWidget {
  const LiquidDose({super.key});

  @override
  State<LiquidDose> createState() => _LiquidDoseState();
}

class _LiquidDoseState extends State<LiquidDose> {
  final TextEditingController _doseController = TextEditingController(text: "200");
  final List<String> _units = ['Oz', 'ml', 'Tablespoon', 'Teaspoon', 'Fluid Ouns'];
  int _selectedIndex = 2; // Tablespoon is initially selected
  bool _showPicker = false;

  void _togglePicker() {
    setState(() {
      _showPicker = !_showPicker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8faff),
      body: Base3(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              const Text(
                'Unit of liquid medication dosing:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Input + Dropdown row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Input box
                  Container(
                    width: 100,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _doseController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(border: InputBorder.none),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Dropdown box
                  GestureDetector(
                    onTap: _togglePicker,
                    child: Container(
                      width: 140,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _units[_selectedIndex],
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          const Icon(Icons.arrow_drop_down, size: 24, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Picker that appears in layout (not modal)
              if (_showPicker)
                Container(
                  height: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Stack(
                    children: [
                      CupertinoPicker(
                        backgroundColor: Colors.transparent,
                        itemExtent: 40.0,
                        scrollController: FixedExtentScrollController(initialItem: _selectedIndex),
                        onSelectedItemChanged: (int index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        children: _units.map((unit) {
                          return Center(
                            child: Text(
                              unit,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      // Highlight overlay
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 30),

              // Add Button
              SizedBox(
                width: 120,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final selectedUnit = _units[_selectedIndex];
                    final dose = _doseController.text;
                    print("Dose: $dose $selectedUnit");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffa5dbe6), // Tiffany Blue
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
