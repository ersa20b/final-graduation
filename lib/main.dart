import 'package:flutter/material.dart';
import 'package:graduation_med_/pages/med_details/addme10.dart';
import 'package:graduation_med_/pages/med_details/addmed12.dart';
import 'package:graduation_med_/pages/med_details/addmed13.dart';
import 'package:graduation_med_/pages/med_details/addmed14.dart';
import 'package:graduation_med_/pages/med_details/addmed15.dart';
import 'package:graduation_med_/pages/med_details/addmed16.dart';
import 'package:graduation_med_/pages/med_details/addmed17.dart';
import 'package:graduation_med_/pages/med_details/addmed18.dart';
import 'package:graduation_med_/pages/med_details/addmed19.dart';
import 'package:graduation_med_/pages/med_details/addmed6.dart';
import 'package:graduation_med_/pages/med_details/addmed9.dart';
import 'package:graduation_med_/pages/med_details/dose_details.dart';
import 'package:graduation_med_/pages/med_details/dose_selection.dart';
import 'package:graduation_med_/pages/screens/home_page.dart';
import 'package:graduation_med_/pages/med_details/med_detail7.dart';
import 'package:graduation_med_/on_boarding_screens/on_boarding_screen.dart';
import 'package:graduation_med_/on_boarding_screens/second_screen.dart';
import 'package:graduation_med_/on_boarding_screens/third_screen.dart';
import 'package:graduation_med_/pages/med_details/phase_details.dart';
import 'package:graduation_med_/pages/screens/otp_vervication_page.dart';
import 'package:graduation_med_/pages/screens/setting.dart';
import 'package:graduation_med_/pages/screens/setting2.dart';
import 'package:graduation_med_/pages/screens/signin_page.dart';
import 'package:graduation_med_/pages/screens/signup_page.dart';
import 'package:graduation_med_/pages/med_details/treatment_phases.dart';
import 'package:graduation_med_/pages/screens/tracker_page.dart';
import 'package:graduation_med_/services/interaction_service.dart';
import 'package:graduation_med_/services/notifications_service.dart';
import 'package:graduation_med_/services/overdose_service.dart';
import 'package:graduation_med_/util/medicine_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/medicine_provider.dart';
import 'providers/profiles_provider.dart';

import 'package:awesome_notifications/awesome_notifications.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //  تهيئة Awesome Notifications
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'med_channel',
        channelName: 'Medicine Reminders',
        channelDescription: 'Reminders for taking medicines',
        defaultColor: const Color(0xFF9D50DD),
        importance: NotificationImportance.Max,
        channelShowBadge: true,
      ),
    ],
    debug: true,
  );



WidgetsFlutterBinding.ensureInitialized();
   await NotificationsService.initialize();
  await OverdoseService.loadDatasetOnce();
  await InteractionService.loadInteractions();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MedicineProvider()),
        ChangeNotifierProvider(create: (_) => ProfilesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          surface: const Color(0xff93D5E1),
          onSurface: Colors.black,
          primary: const Color(0xFF2196F3),
          onPrimary: Colors.white,
          secondary: const Color(0xFF75B6C2),
          onSecondary: Colors.grey.shade300,
          error: Colors.red,
          onError: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
       '/': (context) => OnBoardingScreen(),
        '/secondsplash': (context) => SecondScreen(),
        '/thirdsplash': (context) => ThirdScreen(),
        '/login': (context) => SigninPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/setting1': (context) => const Setting1(),
        '/setting2': (context) => const Setting2(),
        '/addmed6': (context) => const Addmed6(),
        '/addmed14': (context) => Addmed14(),
        '/addmed10': (context) => Addme10(),
        '/meddetail7': (context) => MedDetail7(),
        '/medalarm18': (context) => TreatmentPhasesInput(),
        '/phasedetails': (context) => PhaseDetailsScreen(totalPhases: 1),
        '/doseselection': (context) => DosesSelectionScreen(
              totalPhases: 1,
              phaseDurations: List.generate(1, (_) => []),
              phaseStartDates: List.generate(1, (_) => null),
              phaseEndDates: List.generate(1, (_) => null),
            ),
        '/dosedetails': (context) => DoseDetailsScreen(),
        '/addmed13': (context) => Addmed13(),
        '/addmed9': (context) => Addmed9(),
        '/addmed18': (context) => Addmed18(),
        '/addmed19': (context) => Addmed19(),
        '/addmed12': (context) => Addmed12(),
        '/addmed15': (context) => Addmed15(),
        '/addmed16': (context) => Addmed16(),
        '/addmed17': (context) => Addmed17(),
        '/medicineDetails': (context) => const MedicineDetailsScreen(),
        '/tracker': (context) => const TrackerPage(),
        '/otp': (context) => OTPVerificationPage(),
      },
    );
  }
}
