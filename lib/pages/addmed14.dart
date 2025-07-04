import 'package:flutter/material.dart';
import 'package:graduation_med_/util/base.dart';





class BlisterCounterScreen extends StatefulWidget {
  const BlisterCounterScreen({super.key});

  @override
  State<BlisterCounterScreen> createState() => _BlisterCounterScreenState();
}

class _BlisterCounterScreenState extends State<BlisterCounterScreen> {
  int _blisterCount = 1;

  void _increment() {
    setState(() {
      _blisterCount++;
    });
  }

  void _decrement() {
    setState(() {
      if (_blisterCount > 0) _blisterCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.light().colorScheme.onSurface,
      body: Base(
      
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              // Row of blister images
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

Image.asset(
          'assets/images/blister1.png',
          height: 100,
          width: 100,
          errorBuilder: (context, error, stackTrace) {
            return const Text(
              '❌ Image not found',
              style: TextStyle(fontSize: 18, color: Colors.red),
            );
          },
        ),




                ],
              ),
              const SizedBox(height: 20),

              // Text label
              const Text(
                'Number of blisters:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),

              // Counter Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _counterButton("-", _decrement),
                  Container(
                    width: 80,
                    height: 50,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$_blisterCount',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _counterButton("+", _increment),
                ],
              ),
              const SizedBox(height: 30),

              // Next Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA5DCE7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Handle action
                  },
                  child: const Text("Next", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
       ),
    );
  }

  Widget _counterButton(String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}