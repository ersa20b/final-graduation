import 'package:flutter/material.dart';
import 'package:graduation_med_/util/base2donia.dart';




class PillCounterScreen extends StatefulWidget {
  const PillCounterScreen({super.key});

  @override
  State<PillCounterScreen> createState() => _BlisterCounterScreenState();
}

class _BlisterCounterScreenState extends State<PillCounterScreen> {
  int _pillCount = 1;



// Increment button on the right
  void _increment() {
    setState(() {
      _pillCount++;
     
    });
  }




// Decrement button on the left
  void _decrement() {
    setState(() {
      if (_pillCount > 0) _pillCount--;
      print('Decrement pressed. Count: $_pillCount');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.light().colorScheme.onSurface,
      body: Base2(
        child: Column(
          children: [
                      Align(
                      alignment: Alignment.centerLeft,
                     child: Padding(
                            padding: const EdgeInsets.only(left: 40, top:80), 
                            child: const Text(
                                               'Number of pills in a blister:',
                                               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                                               ),
                                     ),
                            ),


          const SizedBox(height: 10),


           // Blister counter row elements
            Padding(
               padding: const EdgeInsets.only(left: 40), 
              child: Row(
              
                children: [
                  _counterButton("-", _decrement),
                  Container(
                    width: 200,
                    height: 50,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$_pillCount',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _counterButton("+", _increment),
                ],
              ),
            ),



           // adding space between the increase/decrease cpntainer buttons and the next button
            const SizedBox(height: 30),



            // Next Button
          SizedBox(
                width: 320,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Handle action
                    print('Button pressed.');
                  },
                  child: Text("Next", style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary,) ),
                ),
              
            ),
          ],
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
          border: Border.all(color: Colors.grey),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
