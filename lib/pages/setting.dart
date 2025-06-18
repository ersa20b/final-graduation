import "package:flutter/material.dart";

class Setting1 extends StatefulWidget {
  const Setting1({super.key});

  @override
  State<Setting1> createState() => _Setting1State();
}

class _Setting1State extends State<Setting1> {


    bool isThemeAutomatic = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF3FF),

     
body: SafeArea(
child: Column(
      children: [
      // CHILD NO.1 OF THE COLUMN
     Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25),

              //A
              // child of the first child= custom appbar
              child: Row(
              children: [
                  //1 
              Icon(Icons.arrow_back_ios, color: Colors.black),
                  //2 
              Text("Settings",
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black)),
                  //3
                  // to overlap or layer the Bell with the blue circle to indicate ON 
                  Stack(
                    children: [
                      // Bell
                      Icon(Icons.notifications_none, color: Colors.black),
                      //Blue circle
                      // First: determine the position of this circle where on the bell
                      Positioned(
                        top: 4,
                        right: 4,


// SECOND: create the circle which is just a container
child: Container(
// THIRD: shaping the container to a circle 
 width: 10,
 height: 10,
 decoration:BoxDecoration(
 color: Color(0xFF93D5E1),
 shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                // spread what is inside the row evenly throughout the row
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),





 // CHILD NO.2 OF THE COLUMN
  //B
  // FIRST segment options 
            const Center(
              // draw the line with divider and then set the length of that line with width
              // But we cannot determine the width of the Divider widget then how to set the length?
              // Divider wrapped around a sized box or a container and set their width which is gonna be the length of the line
              child: SizedBox(
                width: 350,
                child: Divider(thickness: 1, color: Colors.black),
              ),
            ),

            // SPACE 1
            // the space between the customized appbar and the first segment of the screen
            SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: Column(
                children: [
                  SettingsRow(
                    title: 'Share App',
                    onTap: () {},
                  ),
                  SettingsRow(
                    title: 'Logout',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            //C
            // SECOND segment of the screen

            // SPACE 1
            // the space between the FIRST segment and the SECOND segment of the screen
            SizedBox(height: 180),

            // CHILD NO.3 OF THE COLUMN
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 34),
                child: Text("Appearance",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black,
                    )),
              ),
            ),




            // CHILD NO.4 OF THE COLUMN
            Center(
              child: SizedBox(
                width: 350,
                child: Divider(thickness: 1, color: Colors.black),
              ),
            ),


        // CHILD NO.5 OF THE COLUMN
      Padding(
  padding: EdgeInsets.symmetric(horizontal: 34),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Theme Automatic',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      Switch(
        value: isThemeAutomatic,
        onChanged: (val) {
          setState(() => isThemeAutomatic = val);
        },
        activeColor: Colors.black,
        inactiveThumbColor: Colors.black,
        activeTrackColor: Color(0xFFEFF3FF),
        inactiveTrackColor: Color(0xFFEFF3FF),
      ),
    ],
    ),
      ),

    // CHILD NO.6 OF THE COLUMN 
      Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: Column(
                children: [
                  SettingsRow(
                    title: 'Language',
                    onTap: () {},
                  ),
                ]
  ),
),



// CHILD NO.7 OF THE COLUMN 
 const Spacer(),
              
        

  // CHILD NO.8 OF THE COLUMN 
  // floating action button is not the first to be mentioned and comes after the body (as in your structure)
  Container(
    height: 100,
    width: 60,
    decoration: BoxDecoration(
      shape: BoxShape.circle, ),
    margin: EdgeInsets.only(bottom: 80, left: 300),
    child: FloatingActionButton(
      backgroundColor: Color(0xFF93D5E1),
      onPressed: () {},
      child: Icon(Icons.add, color: Colors.white, size: 30),
      shape: CircleBorder(),
    ),
  ),
      ]
),
),
);
  }
}








//custom widget to reduce code and repetition

class SettingsRow extends StatelessWidget {
  // instead of text widget
  final String title;

  // function to be called when the whole row is tapped not just the text
  final VoidCallback onTap;


  // constructor taking in two named arguments the title and the function 
 SettingsRow({required this.title, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black)),
            Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black),
          ],
      
        ),
      ),
    );
  }
}
