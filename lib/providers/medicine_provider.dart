import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_med_/models/dose_model.dart';
import 'package:graduation_med_/models/dose_state.dart';
import 'package:graduation_med_/models/medicine_card_model.dart';
import 'package:graduation_med_/models/medicine_full_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_med_/models/overdose_model.dart';
import 'package:graduation_med_/models/track_days.dart';
import 'package:graduation_med_/services/interaction_service.dart';
import 'package:graduation_med_/services/overdose_service.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final _firestore = FirebaseFirestore.instance;

class MedicineProvider with ChangeNotifier {
  // ================== الشكل المختار ==================
  String? _selectedShape;
  String? get selectedShape => _selectedShape;

  void selectShape(String shape) {
    _selectedShape = shape.trim();
    notifyListeners();
  }

  void clearSelectedShape() {
    _selectedShape = null;
    notifyListeners();
  }

  // ================== فلو "حبة" ==================
  int _numberOfBlisters = 1;
  int _pillsPerBlister = 1;

  int get numberOfBlisters => _numberOfBlisters;
  int get pillsPerBlister => _pillsPerBlister;

  void incrementBlisters() {
    _numberOfBlisters++;
    notifyListeners();
  }

  void decrementBlisters() {
    if (_numberOfBlisters > 1) {
      _numberOfBlisters--;
      notifyListeners();
    }
  }

  void incrementPillsPerBlister() {
    _pillsPerBlister++;
    notifyListeners();
  }

  void decrementPillsPerBlister() {
    if (_pillsPerBlister > 1) {
      _pillsPerBlister--;
      notifyListeners();
    }
  }

  void resetPillFlow() {
    _numberOfBlisters = 1;
    _pillsPerBlister = 1;
    notifyListeners();
  }

  // ================== فلو "حقنة" ==================
  String _injectionBottleVolume = '';
  String _injectionDosageValue = '';
  String _injectionDosageUnit = 'mg';

  String get injectionBottleVolume => _injectionBottleVolume;
  String get injectionDosageValue => _injectionDosageValue;
  String get injectionDosageUnit => _injectionDosageUnit;

  void setInjectionBottleVolume(String v) {
    _injectionBottleVolume = v;
    notifyListeners();
  }

  void setInjectionDosageValue(String v) {
    _injectionDosageValue = v;
    notifyListeners();
  }

  void setInjectionDosageUnit(String u) {
    _injectionDosageUnit = u;
    notifyListeners();
  }

  void resetInjectionFlow() {
    _injectionBottleVolume = '';
    _injectionDosageValue = '10';
    _injectionDosageUnit = 'mg';
    notifyListeners();
  }

  // ================== فلو "قطرة" ==================
  String _dropperBottleVolume = '';
  int _teardropsPerDose = 1;

  String get dropperBottleVolume => _dropperBottleVolume;
  int get teardropsPerDose => _teardropsPerDose;

  void setDropperBottleVolume(String v) {
    _dropperBottleVolume = v;
    notifyListeners();
  }

  void setTeardropsPerDose(int v) {
    _teardropsPerDose = v < 1 ? 1 : v;
    notifyListeners();
  }

  void resetDropperFlow() {
    _dropperBottleVolume = '';
    _teardropsPerDose = 1;
    notifyListeners();
  }

  // ================== فلو "شراب" ==================
  String _liquidBottleVolume = '';
  String _liquidDoseValue = '';
  String _liquidDoseUnit = 'Tablespoon';

  String get liquidBottleVolume => _liquidBottleVolume;
  String get liquidDoseValue => _liquidDoseValue;
  String get liquidDoseUnit => _liquidDoseUnit;

  void setLiquidBottleVolume(String v) {
    _liquidBottleVolume = v;
    notifyListeners();
  }

  void setLiquidDoseValue(String v) {
    _liquidDoseValue = v;
    notifyListeners();
  }

  void setLiquidDoseUnit(String u) {
    _liquidDoseUnit = u;
    notifyListeners();
  }

  void resetLiquidFlow() {
    _liquidBottleVolume = '';
    _liquidDoseValue = '';
    _liquidDoseUnit = 'Tablespoon';
    notifyListeners();
  }

  // ================== فلو "بخاخة" ==================
  String _inhalerPuffCount = '';
  int _puffsPerDose = 1;

  String get inhalerPuffCount => _inhalerPuffCount;
  int get puffsPerDose => _puffsPerDose;

  void setInhalerPuffCount(String v) {
    _inhalerPuffCount = v;
    notifyListeners();
  }

  void setPuffsPerDose(int value) {
    _puffsPerDose = value;
    notifyListeners();
  }

  void resetInhalerFlow() {
    _inhalerPuffCount = '';
    _puffsPerDose = 1;
    notifyListeners();
  }

  // ================== بيانات عامة ==================
  String? _medicineName;
  String? _doctorName;
  File? _medicineImage;

  String? get medicineName => _medicineName;
  String? get doctorName => _doctorName;
  File? get medicineImage => _medicineImage;

  void setMedicineName(String name) {
    _medicineName = name;
    notifyListeners();
  }

  void setDoctorName(String name) {
    _doctorName = name;
    notifyListeners();
  }

  void setMedicineImage(File image) {
    _medicineImage = image;
    notifyListeners();
  }

  // ================== مراحل العلاج ==================
  int _numberOfPhases = 1;
  int get numberOfPhases => _numberOfPhases;

  void setNumberOfPhases(int value) {
    _numberOfPhases = value;
    notifyListeners();
  }

  int _totalPhases = 1;
  List<List<String>> _phaseDurations = [];
  List<DateTime?> _phaseStartDates = [];
  List<DateTime?> _phaseEndDates = [];

  int get totalPhases => _totalPhases;
  List<List<String>> get phaseDurations => _phaseDurations;
  List<DateTime?> get phaseStartDates => _phaseStartDates;
  List<DateTime?> get phaseEndDates => _phaseEndDates;

  void initializePhases(int total) {
    _totalPhases = total;
    _phaseDurations = List.generate(total, (_) => []);
    _phaseStartDates = List.generate(total, (_) => null);
    _phaseEndDates = List.generate(total, (_) => null);
    notifyListeners();
  }

 void setPhaseDurations(int index, List<String> days) {
  final cleanedDays = days.map((d) {
    final trimmed = d.trim();

    
    if (trimmed.length >= 3) {
      return trimmed.substring(0, 3);
    }
    return trimmed;
  }).toList();

  _phaseDurations[index] = cleanedDays;
  notifyListeners();
}


  void setPhaseStartDate(int index, DateTime date) {
    _phaseStartDates[index] = date;
    notifyListeners();
  }

  void setPhaseEndDate(int index, DateTime date) {
    _phaseEndDates[index] = date;
    notifyListeners();
  }

  // ================== Doses Management ==================
  List<List<DoseModel>> _doses = [];
  List<List<DoseModel>> get doses => _doses;

  void initializeDoses(int totalPhases, List<int> dosesPerPhase) {
  _doses = List.generate(
    totalPhases,
    (phaseIndex) => List.generate(
      dosesPerPhase[phaseIndex],
      (doseIndex) => DoseModel(time: null), 
    ),
  );
  notifyListeners();
}

  void setDoseTime(int phaseIndex, int doseIndex, TimeOfDay time) {
    _doses[phaseIndex][doseIndex] =
        _doses[phaseIndex][doseIndex].copyWith(time: time);
    notifyListeners();
  }

  void setDoseState(int phaseIndex, int doseIndex, DoseState state, {String? userId, String? medicineId}) {
  _doses[phaseIndex][doseIndex] =
      _doses[phaseIndex][doseIndex].copyWith(state: state);
  notifyListeners();

  if (userId != null && medicineId != null) {
    _firestore
        .collection("users")
        .doc(userId)
        .collection("full_medicines")
        .doc(medicineId)
        .update({
      "doses.phase_$phaseIndex": _doses[phaseIndex].map((d) => d.toMap()).toList(),
    });
  }
}


// ================== Dose Sizes ==================
List<double> doseSizes = []; 
String _doseUnit = "mg";     


String get doseUnit => _doseUnit;

void setDoseUnit(String unit) {
  _doseUnit = unit;
  notifyListeners();
}

void initializeDoseSizes(int totalPhases) {
  doseSizes = List.generate(totalPhases, (_) => 0.0);
  notifyListeners();
}

void updateDoseSizeForPhase(int index, double value) {
  if (index >= 0 && index < doseSizes.length) {
    doseSizes[index] = value;
    notifyListeners();
  }
}


  // ================== تكوين موديل الدواء ==================
MedicineFullModel extractCurrentMedicine() {
  final med = MedicineFullModel(
    id: const Uuid().v4(),
    medicineName: _medicineName ?? '',
    doctorName: _doctorName ?? '',
    imagePath: _getImagePathForShape(_selectedShape),
    shape: _selectedShape,
    numberOfPhases: _numberOfPhases,
    phaseDurations: _phaseDurations,
    phaseStartDates: _phaseStartDates,
    phaseEndDates: _phaseEndDates,
    doses: _doses,
    doseStates: {}, // 👈 مبدئياً فاضي
    doseSizes: doseSizes,
    doseUnit: _doseUnit,
    medicineType: _selectedShape ?? 'unknown',
    numberOfBlisters: _numberOfBlisters,
    pillsPerBlister: _pillsPerBlister,
    injectionBottleVolume: _injectionBottleVolume,
    injectionDosageValue: _injectionDosageValue,
    injectionDosageUnit: _injectionDosageUnit,
    dropperBottleVolume: _dropperBottleVolume,
    teardropsPerDose: _teardropsPerDose,
    liquidBottleVolume: _liquidBottleVolume,
    liquidDoseValue: _liquidDoseValue,
    liquidDoseUnit: _liquidDoseUnit,
    inhalerPuffCount: _inhalerPuffCount,
    puffsPerDose: _puffsPerDose,
  );

  // ✅ نولّد الـ doseStates مباشرة
  final newStates = <DateTime, DoseState>{};
  for (int i = 0; i < _phaseStartDates.length; i++) {
    final start = _phaseStartDates[i];
    final end = _phaseEndDates[i];
    final days = _phaseDurations[i];

    if (start != null && end != null) {
      DateTime current = DateTime(start.year, start.month, start.day);
      while (!current.isAfter(end)) {
        final dayName = DateFormat('EEE', 'en_US').format(current);
        if (days.contains(dayName)) {
          newStates[current] = DoseState.none;
        }
        current = current.add(const Duration(days: 1));
      }
    }
  }

  return med.copyWith(doseStates: newStates);
}




  // ================== Reset All Fields ==================
  

void resetAllFields() {
  _selectedShape = null;
  _medicineImage = null;
  _medicineName = '';
  _doctorName = '';
  _numberOfPhases = 1;
  _phaseDurations = [];
  _phaseStartDates = [];
  _phaseEndDates = [];

 
  doseSizes = [0.0];
  _doseUnit = "mg";

  _doses = [];
  _numberOfBlisters = 1;
  _pillsPerBlister = 1;
  _injectionBottleVolume = '';
  _injectionDosageValue = '';
  _injectionDosageUnit = 'mg';
  _dropperBottleVolume = '';
  _teardropsPerDose = 1;
  _liquidBottleVolume = '';
  _liquidDoseValue = '';
  _liquidDoseUnit = 'Tablespoon';
  _inhalerPuffCount = '';
  _puffsPerDose = 1;

  notifyListeners();
}


  // ================== صورة حسب الشكل ==================
  String? _getImagePathForShape(String? shape) {
    switch (shape) {
      case 'حبة':
        return 'assets/images/drug.png';
      case 'حقنة':
        return 'assets/images/injection.png';
      case 'قطرة':
        return 'assets/images/dropper.png';
      case 'شراب':
        return 'assets/images/bluebottle.png';
      case 'كريم':
        return 'assets/images/C9C395AC-FCE9-471C-8A72-0BC6803BB887 1.png';
      case 'بخاخة':
        return 'assets/images/6AEAE757-D8BE-4C19-9FCA-560FA3CE2239.png';
      default:
        return 'assets/images/drug.png';
    }
  }

  // ================== قائمة الأدوية ==================
  final Map<String, List<MedicineFullModel>> _userFullMedicines = {};
  final Map<String, List<MedicineCardModel>> _userMedicines = {};

  List<MedicineFullModel> getFullMedicinesForUser(String userId) {
    return _userFullMedicines[userId] ?? [];
  }

  List<MedicineCardModel> getMedicinesForUser(String userId) {
    return _userMedicines[userId] ?? [];
  }

  void addFullMedicineForUser(String userId, MedicineFullModel medicine, int age) async {
    if (!_userFullMedicines.containsKey(userId)) {
      _userFullMedicines[userId] = [];
    }
    _userFullMedicines[userId]!.add(medicine);
    notifyListeners();

    //  مباشرة بعد الإضافة نفحص الأوفر دوز
    await _checkMedicineOverdose(medicine, age);
  }

Future<void> _checkMedicineOverdose(MedicineFullModel med, int age) async {
  try {
   
    final model = OverdoseModel(
      drugName: med.medicineName,
      age: age,
      perDose: med.doseSizes.isNotEmpty ? med.doseSizes.first : 0.0,
      dosesPerDay: med.dosesPerDay,
    );

    //  جلب بيانات من DailyMed
final status = await OverdoseService.checkOverdoseWithFallback(model);
med.overdoseStatus = status;
notifyListeners();

print(" Overdose check for ${med.medicineName} → $status");

  } catch (e) {
    print(" Overdose check failed for ${med.medicineName}: $e");
  }
}

  // ================== Interaction Warnings ==================
  final Map<String, List<String>> _medicineWarnings = {};
  Map<String, List<String>> get medicineWarnings => _medicineWarnings;

void addMedicineForUser(String userId, MedicineCardModel card) {
  if (!_userMedicines.containsKey(userId)) {
    _userMedicines[userId] = [];
  }

  final existingMeds = _userMedicines[userId]!;

  //  فحص التداخل مع الأدوية القديمة فقط
  List<String> conflicts = [];
  for (var oldMed in existingMeds) {
    final interaction = InteractionService.checkPairInteraction(
      card.medicineName,
      oldMed.medicineName,
    );
    if (interaction != null) {
      conflicts.add("${oldMed.medicineName} → $interaction");
    }
  }

  //  لو فيه تداخل، خزّنه
  if (conflicts.isNotEmpty) {
    _medicineWarnings[card.medicineName] = conflicts;
    print(" Interaction found for ${card.medicineName} → $conflicts");
  }

  //  نضيف الدواء الجديد بعد الفحص
  _userMedicines[userId]!.add(card);

  notifyListeners();
}



  void removeFullMedicineForUser(String userId, int index) {
    if (_userFullMedicines.containsKey(userId)) {
      _userFullMedicines[userId]!.removeAt(index);
      notifyListeners();
    }
  }

  void removeMedicineForUser(String userId, int index) {
    if (_userMedicines.containsKey(userId)) {
      _userMedicines[userId]!.removeAt(index);
      notifyListeners();
    }
  }

  int getMedicineCountForUser(String userId) {
    return _userFullMedicines[userId]?.length ?? 0;
  }
  //دالة مساعدة لحساب العمر
int _calculateAge(DateTime birthDate) {
  final now = DateTime.now();
  int age = now.year - birthDate.year;
  if (now.month < birthDate.month ||
      (now.month == birthDate.month && now.day < birthDate.day)) {
    age--;
  }
  return age;
}

  // ================== Firebase Integration ==================
Future<void> saveMedicineToFirebase({
  required String userId,
  required MedicineFullModel fullMedicine,
  required DateTime birthDate,
}) async {
  try {
    final age = _calculateAge(birthDate);

    //  نبني OverdoseModel
    final model = OverdoseModel(
      drugName: fullMedicine.medicineName,
      age: age,
      perDose: fullMedicine.doseSizes.isNotEmpty ? fullMedicine.doseSizes.first : 0.0,
      dosesPerDay: fullMedicine.dosesPerDay,
    );

   
   
//  فحص الجرعة باستخدام DailyMed أو JSON fallback
final status = await OverdoseService.checkOverdoseWithFallback(model);
fullMedicine = fullMedicine.copyWith(overdoseStatus: status);

    // Debug log
    print(" Saving medicine → "
        "name: ${fullMedicine.medicineName}, "
        "doseSizes: ${fullMedicine.doseSizes}, "
        "unit: ${fullMedicine.doseUnit}, "
        "status: ${fullMedicine.overdoseStatus}");

    //  تخزين في Firebase
    final userRef = _firestore.collection('users').doc(userId);
    await userRef
        .collection('full_medicines')
        .doc(fullMedicine.id)
        .set(fullMedicine.toMap());

    //  إعادة تحميل من Firebase  المزامنة
    await loadMedicinesFromFirebase(userId);

    print(" Medicine saved with overdose status: ${fullMedicine.overdoseStatus}");
  } catch (e) {
    print(" Error saving medicine: $e");
  }
}


  Future<void> loadMedicinesFromFirebase(String userId) async {
    try {
      final userRef = _firestore.collection('users').doc(userId);

      final fullSnapshot = await userRef.collection('full_medicines').get();
      _userFullMedicines[userId] = fullSnapshot.docs.map((doc) {
        return MedicineFullModel.fromMap(doc.data());
      }).toList();

      notifyListeners();
      print(" Medicines loaded successfully for user: $userId");
      print(" Loaded medicines for $userId → ${_userFullMedicines[userId]?.length}");
    } catch (e) {
      print(" Error loading medicines: $e");
    }
  }

Future<void> deleteMedicineFromFirebase(String userId, String medicineId) async {
  try {
    final userRef = _firestore.collection('users').doc(userId);

   
    await userRef.collection('full_medicines').doc(medicineId).delete();

  
    await loadMedicinesFromFirebase(userId);

    print(" Medicine deleted successfully: $medicineId");
  } catch (e) {
    print(" Failed to delete medicine: $e");
  }
}

  // ================== Editing Mode ==================
  bool _isEditing = false;
  int? _editingIndex;
  String? _editingUserId;

  bool get isEditing => _isEditing;
  int? get editingIndex => _editingIndex;
  String? get editingUserId => _editingUserId;

  void startEditing(String userId, int index) {
    _isEditing = true;
    _editingUserId = userId;
    _editingIndex = index;
    notifyListeners();
  }

  void stopEditing() {
    _isEditing = false;
    _editingUserId = null;
    _editingIndex = null;
    notifyListeners();
  }

  void loadMedicineToEdit(MedicineFullModel medicine, String userId, int index) {
    _isEditing = true;
    _editingUserId = userId;
    _editingIndex = index;

    _medicineName = medicine.medicineName;
    _doctorName = medicine.doctorName;
    _selectedShape = medicine.shape;

    _numberOfBlisters = medicine.numberOfBlisters ?? 1;
    _pillsPerBlister = medicine.pillsPerBlister ?? 1;

    _injectionBottleVolume = medicine.injectionBottleVolume ?? '';
    _injectionDosageValue = medicine.injectionDosageValue ?? '';
    _injectionDosageUnit = medicine.injectionDosageUnit ?? 'mg';

    _dropperBottleVolume = medicine.dropperBottleVolume ?? '';
    _teardropsPerDose = medicine.teardropsPerDose ?? 1;

    _liquidBottleVolume = medicine.liquidBottleVolume ?? '';
    _liquidDoseValue = medicine.liquidDoseValue ?? '';
    _liquidDoseUnit = medicine.liquidDoseUnit ?? 'Tablespoon';

    _inhalerPuffCount = medicine.inhalerPuffCount ?? '';
    _puffsPerDose = medicine.puffsPerDose ?? 1;

    _numberOfPhases = medicine.numberOfPhases;
    _phaseDurations = List.from(medicine.phaseDurations);
    _phaseStartDates = List.from(medicine.phaseStartDates);
    _phaseEndDates = List.from(medicine.phaseEndDates);

    _doses = List.generate(
      medicine.doses.length,
      (i) => List.from(medicine.doses[i]),
    );

    doseSizes = List.from(medicine.doseSizes);

    notifyListeners();
  }

  void updateFullMedicineForUser(
      String userId, int index, MedicineFullModel updatedMedicine) {
    if (_userFullMedicines.containsKey(userId) &&
        index >= 0 &&
        index < _userFullMedicines[userId]!.length) {
      _userFullMedicines[userId]![index] = updatedMedicine;
      notifyListeners();
    }
  }
  Map<DateTime, DoseState> _doseStates = {};
Map<DateTime, DoseState> get doseStates => _doseStates;
void generateDoseStates() {
  _doseStates = {};
  for (int i = 0; i < _phaseStartDates.length; i++) {
    final start = _phaseStartDates[i];
    final end = _phaseEndDates[i];
    final days = _phaseDurations[i];

    if (start != null && end != null) {
      DateTime current = DateTime(start.year, start.month, start.day);
      while (!current.isAfter(end)) {
       
        final dayName = DateFormat('EEE', 'en_US').format(current);

        if (days.contains(dayName)) {
          _doseStates[current] = DoseState.none;

          
          print(" Added tracking day $dayName "
              "${DateFormat('yyyy-MM-dd').format(current)} "
              "with state: ${DoseState.none.name}");
        }

        current = current.add(const Duration(days: 1));
      }
    }
  }
  notifyListeners();
}

Future<void> updateDoseState(
  String userId,
  String medicineId,
  DateTime date,
  DoseState newState,
) async {
  try {
    //  تحديث محلي
    final medicines = _userFullMedicines[userId];
    if (medicines != null) {
      final index = medicines.indexWhere((m) => m.id == medicineId);
      if (index != -1) {
        medicines[index].doseStates[date] = newState;
        notifyListeners();
      }
    }

    //  تحديث في Firestore
    await _firestore
        .collection("users")
        .doc(userId)
        .collection("full_medicines")
        .doc(medicineId)
        .update({
      "doseStates.${date.toIso8601String()}": newState.name,
    });

    print(" Dose state updated for $medicineId at $date → ${newState.name}");
  } catch (e) {
    print(" Error updating dose state: $e");
  }
}
List<TrackingDay> generateTrackingDays(MedicineFullModel medicine) {
  final List<TrackingDay> trackingDays = [];

  print("🔎 Generating tracking days for ${medicine.medicineName}");
  print("   - numberOfPhases: ${medicine.numberOfPhases}");
  print("   - dosesPerDay: ${medicine.dosesPerDay}");

  for (int phaseIndex = 0; phaseIndex < medicine.numberOfPhases; phaseIndex++) {
    final start = medicine.phaseStartDates[phaseIndex];
    final end = medicine.phaseEndDates[phaseIndex];
    final days = medicine.phaseDurations[phaseIndex];

    print("   Phase $phaseIndex → start=$start, end=$end, days=$days");

    if (start == null || end == null) {
      print("    Skipping phase $phaseIndex: start or end is null");
      continue;
    }

    DateTime current = DateTime(start.year, start.month, start.day);
    while (!current.isAfter(end)) {
      final currentDay = DateFormat.E('en_US').format(current); 

      if (days.contains(currentDay)) {
        
        final dailyDoses = List.generate(
          medicine.dosesPerDay,
          (i) => DoseModel(time: null, state: DoseState.none),
        );

        trackingDays.add(
          TrackingDay(
            date: current,
            doses: dailyDoses,
          ),
        );

        print("       Added ${currentDay} ${DateFormat('yyyy-MM-dd').format(current)}"
            " with ${dailyDoses.length} doses");
      }

      current = current.add(const Duration(days: 1));
    }
  }

  print(" Done → ${trackingDays.length} tracking days");
  return trackingDays;
}





/// ✅ تحديث حالة الجرعة القادمة من الإشعار
Future<void> updateDoseStateFromNotification({
  required String userId,
  required String medicineId,
  required int phaseIndex,
  required String doseId,
  required DoseState newState,
}) async {
  try {
    final medicines = _userFullMedicines[userId];
    if (medicines == null) return;

    // نلقى الدواء
    final medIndex = medicines.indexWhere((m) => m.id == medicineId);
    if (medIndex == -1) return;

    final medicine = medicines[medIndex];
    final phaseDoses = medicine.doses[phaseIndex];

    // نلقى الجرعة بالـ doseId
    final doseIndex = phaseDoses.indexWhere((d) => d.id == doseId);
    if (doseIndex == -1) return;

    // ✅ تعديل محلي للجرعة
    phaseDoses[doseIndex] =
        phaseDoses[doseIndex].copyWith(state: newState);

    // ✅ تحديث doseStates حسب تاريخ اليوم
    final today = DateTime.now();
    final normalizedDate = DateTime(today.year, today.month, today.day);
    medicine.doseStates[normalizedDate] = newState;

    // ✅ نخزن في Firebase
    await _firestore
        .collection("users")
        .doc(userId)
        .collection("full_medicines")
        .doc(medicineId)
        .update({
      "doses.phase_$phaseIndex": phaseDoses.map((d) => d.toMap()).toList(),
      "doseStates.${normalizedDate.toIso8601String()}": newState.name,
    });

    print("🔔 Notification update → "
        "userId=$userId, medicineId=$medicineId, "
        "phase=$phaseIndex, doseId=$doseId, "
        "state=${newState.name}");

    // ✅ نرجع نعمل notifyListeners → باش التراك يعاود يترسم
    notifyListeners();

  } catch (e) {
    print("❌ Error updating dose state from notification: $e");
  }
}




}
