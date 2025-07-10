import 'package:flutter/material.dart';
import 'package:graduation_med_/util/base3donia.dart';

class BottleVolume extends StatefulWidget {
  const BottleVolume({super.key});

  @override
  State<BottleVolume> createState() => _PillCounterScreenState();
}

class _PillCounterScreenState extends State<BottleVolume> {
  // for the text input field 
  final TextEditingController _volumeController = TextEditingController(text: "00");

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
                'Volume of injection medication bottle:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset(
                  'assets/images/brownbottle.PNG', 
                  height: 220,
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
                      // to be able to write in the input field in a certin way 
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
                  const Text("ml", style: TextStyle(fontSize: 16)),

                  const SizedBox(width: 20),

                  // Add button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print("Volume: ${_volumeController.text} ml");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Add',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
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
