import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';
import 'package:graduation_med_/util/base3donia.dart';

class Addmed9 extends StatefulWidget {
  const Addmed9({super.key});

  @override
  State<Addmed9> createState() => _Addmed9State();
}

class _Addmed9State extends State<Addmed9> {
  late TextEditingController _dosageController;
  final List<String> _units = ['ml', 'mg'];
  bool _showUnitPicker = false;
  Timer? _pickerDebounce;

  @override
  void initState() {
    super.initState();
    final prov = context.read<MedicineProvider>();
    _dosageController = TextEditingController(text: prov.injectionDosageValue);
  }

  @override
  void dispose() {
    _dosageController.dispose();
    _pickerDebounce?.cancel();
    super.dispose();
  }

  void _togglePicker() {
    setState(() => _showUnitPicker = !_showUnitPicker);
  }

  void _goNext() {
    
    context.read<MedicineProvider>().setInjectionDosageValue(_dosageController.text.trim());
    Navigator.pushNamed(context, '/meddetail7');
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<MedicineProvider>();
    final unit = prov.injectionDosageUnit;
    final selectedIndex = _units.indexOf(unit); 

    return Scaffold(
      backgroundColor: const Color(0xfff8faff),
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
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset('assets/images/injection.png', height: 200, fit: BoxFit.contain),
              ),
              const SizedBox(height: 10),
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
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _dosageController,
                      onChanged: (v) => context.read<MedicineProvider>().setInjectionDosageValue(v.trim()),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(border: InputBorder.none),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _togglePicker,
                    child: Container(
                      width: 80,
                      height: 50,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(unit, style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_drop_down, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_showUnitPicker)
                Container(
                  height: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: CupertinoPicker(
                    backgroundColor: Colors.transparent,
                    scrollController: FixedExtentScrollController(
                      initialItem: selectedIndex < 0 ? 0 : selectedIndex,
                    ),
                    itemExtent: 40.0,
                    onSelectedItemChanged: (int index) {
                      context.read<MedicineProvider>().setInjectionDosageUnit(_units[index]);
                      _pickerDebounce?.cancel();
                      _pickerDebounce = Timer(const Duration(milliseconds: 300), () {
                        if (!mounted) return;
                        setState(() => _showUnitPicker = false);
                      });
                    },
                    children: _units.map((u) => Center(
                      child: Text(u, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    )).toList(),
                  ),
                ),
              const SizedBox(height: 10),
              SizedBox(
                width: 120,
                height: 48,
                child: ElevatedButton(
                  onPressed: _goNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffa5dbe6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text('Next', style: TextStyle(fontSize: 18, color: Colors.white)),
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
