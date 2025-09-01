import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';
import 'package:graduation_med_/util/base3donia.dart';

class Addmed12 extends StatefulWidget {
  const Addmed12({Key? key}) : super(key: key);

  @override
  State<Addmed12> createState() => _Addmed12State();
}

class _Addmed12State extends State<Addmed12> {
  late TextEditingController _volumeController;

  @override
  void initState() {
    super.initState();
    final prov = context.read<MedicineProvider>();
    _volumeController = TextEditingController(text: prov.liquidBottleVolume);
  }

  @override
  void dispose() {
    _volumeController.dispose();
    super.dispose();
  }

  void _onAddPressed() {
    context.read<MedicineProvider>().setLiquidBottleVolume(_volumeController.text.trim());
    Navigator.pushNamed(context, '/addmed15'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Base3(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80),
              const Text(
                'Volume of liquid medication bottle:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset('assets/images/bluebottle.png', height: 200, fit: BoxFit.contain),
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
                      decoration: const InputDecoration(border: InputBorder.none),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text("ml", style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 20),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _onAddPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Add', style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
