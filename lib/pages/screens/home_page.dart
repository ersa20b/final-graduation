import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:graduation_med_/services/notifications_service.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:graduation_med_/pages/screens/tracker_page.dart';
import 'package:graduation_med_/providers/medicine_provider.dart';
import 'package:graduation_med_/providers/profiles_provider.dart';
import 'package:graduation_med_/util/medicine_card.dart';
import 'package:graduation_med_/util/nav_bar.dart';
import 'package:graduation_med_/util/weekly_calendar.dart';
import 'package:graduation_med_/util/health_journal_card.dart';
import 'package:graduation_med_/pages/screens/profilePage.dart';
import 'package:graduation_med_/pages/screens/setting.dart';
import 'package:graduation_med_/constants/image_paths.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? selectedDate = DateTime.now();
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final DragController dragController = DragController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = context.read<ProfilesProvider>().activeProfile.id;
      context.read<MedicineProvider>().loadMedicinesFromFirebase(userId);
      
     NotificationsService.requestPermission();
    NotificationsService.listenNotificationActions(context);



    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }
Future<void> loadDrugInteractions() async {
  try {
    final String response = await rootBundle.loadString('assets/data/drug_interactions.json');
    final data = json.decode(response);

    print(" Loaded interactions: $data");
  } catch (e) {
    print(" Error loading interactions: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfilesProvider>().activeProfile;
    final userId = profile.id;
    final fullMedicines =
        context.watch<MedicineProvider>().getFullMedicinesForUser(userId);

    print(" HomePage medicines count for $userId → ${fullMedicines.length}");

    final gender = profile.gender.toLowerCase();
    final avatarPath = gender == 'male'
        ? ImagePaths.maleAvatar
        : gender == 'female'
            ? ImagePaths.femaleAvatar
            : ImagePaths.defaultAvatar;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onTabChange: _onItemTapped,
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage(avatarPath),
                      ),
                      title: Text(
                        'Hello, ${profile.name}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                        'Let’s check your plan for today',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (selectedDate != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          DateFormat.yMMMMEEEEd().format(selectedDate!),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    const SizedBox(height: 6),
                    WeeklyCalendar(
                      onDateSelected: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                    ),
                    const HealthJournalCard(),
                   

      
                    fullMedicines.isEmpty
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Track your medications schedule.',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    'Press + to add your first medicine',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            children:
                                fullMedicines.asMap().entries.map((entry) {
                              final index = entry.key;
                              final medicine = entry.value;

                              return Slidable(
                                key: ValueKey(
                                    '${medicine.medicineName}_$index'),
                                direction: Axis.horizontal,
                                startActionPane: ActionPane(
                                  motion: const StretchMotion(),
                                  extentRatio: 0.25,
                                  children: [
                                    CustomSlidableAction(
                                      onPressed: (_) async {
                                        final confirm = await showDialog<bool>(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            backgroundColor:
                                                Colors.grey.shade100,
                                            title:
                                                const Text('Delete Medicine'),
                                            content: const Text(
                                                "Do you want to delete this medicine?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child: const Text('Delete',
                                                    style: TextStyle(
                                                        color: Colors.red)),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (confirm == true) {
                                          final userId = context
                                              .read<ProfilesProvider>()
                                              .activeProfile
                                              .id;
                                          print(
                                              ' Deleting medicine for userId: $userId at index: $index');

                                          final provider = context
                                              .read<MedicineProvider>();
                                          final medicine = provider
                                              .getFullMedicinesForUser(userId)[
                                                  index];

                                          await provider
                                              .deleteMedicineFromFirebase(
                                                  userId, medicine.id);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Medicine deleted successfully ')));
                                        }
                                      },
                                      backgroundColor: Colors.transparent,
                                      flex: 1,
                                      child: const Icon(Icons.delete,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/medicineDetails',
                                      arguments: {
                                        'index': index,
                                        'userId': userId,
                                      },
                                    );
                                  },
                                  child: MedicineCard(
                                    medicine: medicine,
                                    userId: userId,
                                    medicineIndex: index,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const ProfilePage(),
              const TrackerPage(),
              const Setting1(),
            ],
          ),
          if (_selectedIndex == 0)
            DraggableWidget(
              bottomMargin: 120,
              topMargin: kToolbarHeight + 20,
              horizontalSpace: 16,
              initialPosition: AnchoringPosition.bottomRight,
              dragController: dragController,
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.surface,
                onPressed: () {
                  Navigator.pushNamed(context, '/addmed6');
                },
                child: const Icon(Icons.add),
              ),
            ),
        ],
      ),
    );
  }
}
