import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';
import 'package:graduation_med_/util/base3donia.dart';

class Addmed15 extends StatefulWidget {
  const Addmed15({super.key});

  @override
  State<Addmed15> createState() => _Addmed15State();
}

class _Addmed15State extends State<Addmed15> {
  late TextEditingController _doseController;
  final List<String> _units = ['Oz', 'ml', 'Tablespoon', 'Teaspoon', 'Fluid Ouns'];
  bool _showPicker = false;

  @override
  void initState() {
    super.initState();
    final prov = context.read<MedicineProvider>();
    _doseController = TextEditingController(text: prov.liquidDoseValue);
  }

  @override
  void dispose() {
    _doseController.dispose();
    super.dispose();
  }

  void _togglePicker() => setState(() => _showPicker = !_showPicker);

  void _onAddPressed() {
    
    context.read<MedicineProvider>().setLiquidDoseValue(_doseController.text.trim());
    Navigator.pushNamed(context, '/meddetail7');
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<MedicineProvider>();

   
    final selectedIndex = _units.indexOf(prov.liquidDoseUnit);
    final initialIndex = selectedIndex >= 0 ? selectedIndex : 2; 

    return Scaffold(
      backgroundColor: const Color(0xfff8faff),
      body: Base3(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Unit of liquid medication dosing:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                        onChanged: (v) => context.read<MedicineProvider>().setLiquidDoseValue(v.trim()),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(border: InputBorder.none),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(width: 12),
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
                            Text(prov.liquidDoseUnit, style: const TextStyle(fontSize: 16, color: Colors.black)),
                            const Icon(Icons.arrow_drop_down, size: 24, color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
            
                if (_showPicker)
                  Container(
                    height: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: CupertinoPicker(
                      backgroundColor: Colors.transparent,
                      itemExtent: 40.0,
                      scrollController: FixedExtentScrollController(initialItem: initialIndex),
                      onSelectedItemChanged: (int index) {
                        context.read<MedicineProvider>().setLiquidDoseUnit(_units[index]);
                        setState(() => _showPicker = false);
                      },
                      children: _units.map((unit) => Center(
                        child: Text(unit, style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500)),
                      )).toList(),
                    ),
                  ),
            
                const SizedBox(height: 30),
                SizedBox(
                  width: 120,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _onAddPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffa5dbe6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                    child: const Text('Add', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
