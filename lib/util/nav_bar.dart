import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const NavBar(
      {super.key, required this.selectedIndex, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration
        (
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(40)
        ),
        
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: GNav(
            padding: EdgeInsets.all(8),
            backgroundColor: Colors.grey.shade300,
            color: Colors.black,
            activeColor: Theme.of(context).colorScheme.surface,
            tabActiveBorder: Border.all(
              color:Colors.grey,
            ),
            gap: 16,
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
            tabs: const [
              GButton(
                icon: Icons.home_filled,
                //text: 'الرئيسية',
              ),
              GButton(
                icon: Icons.person_outline,
               
              ),
              GButton(
                icon: Icons.filter_frames,
               
              ),
              GButton(
                icon: Icons.settings,
              
              ),
            ],
          ),
        ),
      ),
    );
  }
}