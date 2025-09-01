import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';
import 'package:graduation_med_/util/base3donia.dart';

class Addmed19 extends StatefulWidget {
  const Addmed19({super.key});

  @override
  State<Addmed19> createState() => _Addmed19State();
}

class _Addmed19State extends State<Addmed19> {
  bool showPicker = false;
  final List<int> teardropOptions = [1, 2, 3, 4];

  void _togglePicker() {
    setState(() => showPicker = !showPicker);
  }

  void _goToNext() {
    Navigator.pushNamed(context, '/meddetail7'); 
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<MedicineProvider>();
    final selectedTeardrops = prov.teardropsPerDose;

    return Scaffold(
      backgroundColor: const Color(0xfff8faff),
      body: Base3(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              const Text(
                "Number of medication teardrops per dose:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              GestureDetector(
                onTap: _togglePicker,
                child: Container(
                  width: 100,
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(selectedTeardrops.toString(), style: const TextStyle(fontSize: 18)),
                      const SizedBox(width: 6),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              if (showPicker)
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Stack(
                    children: [
                      CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                          initialItem: teardropOptions.indexOf(selectedTeardrops),
                        ),
                        itemExtent: 40,
                        onSelectedItemChanged: (index) {
                          context.read<MedicineProvider>().setTeardropsPerDose(teardropOptions[index]);
                          setState(() => showPicker = false);
                        },
                        backgroundColor: Colors.transparent,
                        children: teardropOptions
                            .map((e) => Center(child: Text(e.toString(), style: const TextStyle(fontSize: 22))))
                            .toList(),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _goToNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffa5dbe6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5),
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
