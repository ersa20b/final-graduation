import 'package:flutter/material.dart';
import 'package:graduation_med_/util/base3donia.dart';

class InjectionVolume extends StatefulWidget {
  const InjectionVolume({Key? key}) : super(key: key);

  @override
  State<InjectionVolume> createState() => _InjectionVolumeState();
}

class _InjectionVolumeState extends State<InjectionVolume> {


  // This variable of type "TextEditingController" is for the text input field to hold the data that will be entered by the user.
  final TextEditingController _volumeController = TextEditingController(text: "00");




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.light().colorScheme.onSurface,
      body: Base3(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 80),
              const Text(
                'Volume of injection medication bottle:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset(
                  'assets/images/brownbottle.PNG', 
                  height: 220,
                  fit: BoxFit.contain,
                ),
              ),


           
            // Space between the image and volume container button
              const SizedBox(height: 30),

            

             // enter volume row elements
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
                      //1
                      // to be able to write in the input field in a certin way 
                      controller: _volumeController,
                      //2
                      // to hold data entered by the user
                      keyboardType: TextInputType.number,
                      //3
                      textAlign: TextAlign.center,
                      //4
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),


                 //  horizontalspace between the input field and the unit text
                  const SizedBox(width: 10),



                  const Text("ml", style: TextStyle(fontSize: 16)),



                  // vertical space between the input field and the add button
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
