import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_med_/util/base3donia.dart';

class InjectionDosage extends StatefulWidget {
  const InjectionDosage({super.key});

  @override
  State<InjectionDosage> createState() => _InjectionDosageState();
}

class _InjectionDosageState extends State<InjectionDosage> {

//1
  // This variable of type "TextEditingController" is for the text input field to hold the data that will be choosen by the user.
  // variable with a place holder "10" to be used as the default value in the text input field. 
  final TextEditingController _volumeController = TextEditingController(text: "10");


//2
  // List of units for the dropdown menue
  final List<String> _units = ['ml', 'mg'];


//3
  // Variable to hold the index of the selected unit in the dropdown menue
  int _selectedIndex = 1;


//4
  // Variable to control the visibility of the CupertinoPicker for unit selection
  // CupertionPicker=  scrollable iOS-style selection wheel
  bool _showUnitPicker = false;




// method to change the visibility of the cupertino picker when the user taps on the dropdown field
  void _togglePicker() {
    setState(() {
      _showUnitPicker = !_showUnitPicker;
    });
  }



  @override
  Widget build(BuildContext context) {
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


              // 1]Dosage input box + 2]unit dropdown menue
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 1]Dosage input box container
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
                      controller: _volumeController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(border: InputBorder.none),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),


                    //  horizontalspace between the input field and the dropdown menue container button
                  const SizedBox(width: 10),



                  // 2]Dropdown menue container
                  //  Use GestureDetector and not DropdownButton widget as the parent widget. why? Because:
                  // A: custom dropdown UI, +
                  // B: trigger a specific function (like _togglePicker()) when the user taps a container.

                  // Displays defualt basic Dropdown menue small box (GestureDetector widget+ Container widget)
                  GestureDetector(
                 
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
                          Text(
                            // calling the selected unit(_selectedIndex variable declared) from the list of units( _units variable declared) 
                            _units[_selectedIndex],
                            style: const TextStyle(fontSize: 16),
                          ),

                          const SizedBox(width: 4),

                          const Icon(Icons.arrow_drop_down, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),



              const SizedBox(height: 16),


              // Embedded CupertinoPicker Displays a:
             // (A):scrollable list in iOS-style selection wheel  that shows up only if _showUnitPicker == true + 
             // (B):Adds a Tiffany blue highlight over the selected item
             // [1]define the behavior and layout of the picker
              if (_showUnitPicker)
                Container(
                  height: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  // you want to highlight the selected item in the picker 
                  //Stack here is used to highlight bar to sit on top of the CupertinoPicker without affecting its scroll behavior.
                  //Stack lets both widgets share the same space and be drawn on top of each other.
                  child: Stack(
                    children: [
                      CupertinoPicker(
                        backgroundColor: Colors.transparent,
                        scrollController: FixedExtentScrollController(initialItem: _selectedIndex),
                        //  Each row in the wheel is 40px high.
                        itemExtent: 40.0,

                        onSelectedItemChanged: (int index) {
                          // When user scrolls and selects a new unit update the _selectedIndex varible
                          setState(() {
                            _selectedIndex = index;
                          });
                        },



                      // [2] define what the picker shows
                      // .maps((unit) = Creates the actual rows shown in the picker)
                        children: _units.map((unit) {
                          return Center(
                            // 	Displays the text for each unit
                            child: Text(
                              unit,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                          //	Converts the mapped result into a list of widgets for children
                        }).toList(),
                      ),

                      // creates the highlighted background (Tiffany blue) that visually indicates which row is currently selected in the CupertinoPicker
                     // why use Align?  used inside a Stack to position a child relative to the Stack's size.
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color:Theme.of(context).colorScheme.secondary.withOpacity(0.6), 
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),



              
             // vertical space between the input field and the add button
              const SizedBox(height: 30),



              // Add Button
              SizedBox(
                width: 120,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    print("Dosage: ${_volumeController.text} ${_units[_selectedIndex]}");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffa5dbe6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
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
