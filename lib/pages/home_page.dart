import 'package:flutter/material.dart';
import 'package:graduation_med_/pages/on_boarding_screens/first_screen.dart';
import 'package:graduation_med_/pages/on_boarding_screens/second_screen.dart';
import 'package:graduation_med_/pages/on_boarding_screens/third_screen.dart';
import 'package:graduation_med_/pages/profilePage.dart';
import 'package:graduation_med_/pages/setting.dart';
import 'package:graduation_med_/pages/signin_page.dart';
import 'package:graduation_med_/pages/signup_page.dart';
import 'package:graduation_med_/util/health_journal_card.dart';
import 'package:graduation_med_/util/nav_bar.dart';
//import 'package:graduation_med_/util/medicine_page.dart';
import 'package:intl/intl.dart';
import 'package:graduation_med_/util/weekly_calendar.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? selectedDate=DateTime.now();
 int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
       bottomNavigationBar: NavBar(

        selectedIndex: _selectedIndex,
        onTabChange: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.surface,
    onPressed: () {
      // هنا تضيف وظيفة الزر لما يضغط المستخدم
      print('Floating Action Button pressed!');
    },
    child: const Icon(Icons.add),
  ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),

            // Header
            ListTile(
              leading: Image.asset('assets/images/user.png'),
              title: const Text(
                'Hello, Ali',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Let’s check your plan for today',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.notifications_none_outlined, size: 40),
            ),

            const SizedBox(height: 10),

            // ✅ التاريخ المختار يظهر هنا
            if (selectedDate != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  ' ${DateFormat.yMMMMEEEEd().format(selectedDate!)}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            SizedBox(height: 6,),
            // ✅ Weekly Calendar
            WeeklyCalendar(
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
           
            HealthJournalCard(),
            
          ],
           
        ),
        ),
      ProfilePage(),
      SecondScreen(),
      ThirdScreen()
        ]
        ),
        
        );
  }
}
      
      
      /* Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),

            // Header
            ListTile(
              leading: Image.asset('assets/images/user.png'),
              title: const Text(
                'Hello, Ali',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Let’s check your plan for today',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.notifications_none_outlined, size: 40),
            ),

            const SizedBox(height: 10),

            // ✅ التاريخ المختار يظهر هنا
            if (selectedDate != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  ' ${DateFormat.yMMMMEEEEd().format(selectedDate!)}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            SizedBox(height: 6,),
            // ✅ Weekly Calendar
            WeeklyCalendar(
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
           
            HealthJournalCard(),
            
          ],
           
        ),

      ),*/
 