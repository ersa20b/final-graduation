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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80), // Add bottom padding
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back_ios, color: Colors.black),
                      Text("Settings",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.black)),
                      Stack(
                        children: [
                          Icon(Icons.notifications_none, color: Colors.black),
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Center(
                  child: SizedBox(
                    width: 100,
                    child: Divider(thickness: 1, color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),
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
                SizedBox(height: 100),
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
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Divider(thickness: 1, color: Colors.black),
                  ),
                ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: Column(children: [
                    SettingsRow(
                      title: 'Language',
                      onTap: () {},
                    ),
                  ]),
                ),

                
                SizedBox(height: 300),


                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 34, bottom: 20),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: FloatingActionButton(
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Icon(Icons.add, color: Colors.white, size: 30),
                      ),
                    ),
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
