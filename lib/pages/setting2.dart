import "package:flutter/material.dart";

class Setting2 extends StatefulWidget {
  const Setting2({super.key});

  @override
  State<Setting2> createState() => _Setting2State();
}

class _Setting2State extends State<Setting2> {
  bool isThemeAutomatic = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onError,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80), // Add bottom padding
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25),
                  child: Center(
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                    children: [
                      Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.onSecondary),
                      Text("Language",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black)),
                     Stack(
                        children: [
                          Icon(Icons.notifications_none, color: Theme.of(context).colorScheme.onSecondary),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                              color:  Theme.of(context).colorScheme.secondary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),]
                     ),
                    ],
                    ),
                  ),
                ),
                const Center(
                  child: SizedBox(
                    width: 300,
                    child: Divider(thickness: 1, color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: Column(
                    children: [
                      SettingsRow(
                        title: 'English',
                        onTap: () {},
                      ),
                      SettingsRow(
                        title: 'Arabic',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              
              SizedBox(height: 300),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 34, bottom: 10), 
                    child: Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(shape: BoxShape.circle, color:Theme.of(context).colorScheme.secondary,),
                    
                      child: FloatingActionButton(
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Icon(Icons.add, color: Colors.white, size: 30),
                      ),
                    ),
                  ),
                ),



              ]
        ),
      ),





      
    ),
      ),
    );
  }
}










class SettingsRow extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SettingsRow({required this.title, required this.onTap, super.key});

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
