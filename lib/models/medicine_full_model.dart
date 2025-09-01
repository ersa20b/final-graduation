import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_med_/models/overdose_model.dart';
import 'dose_model.dart';
import 'dose_state.dart';

class MedicineFullModel {
  final String id;
  final String medicineName;
  final String doctorName;
  final String? imagePath;
  final String? shape;

  final int numberOfPhases;
  final List<List<String>> phaseDurations;
  final List<DateTime?> phaseStartDates;
  final List<DateTime?> phaseEndDates;

  //  الجرعات (للإشعارات)
  final List<List<DoseModel>> doses;

  //  الحالات (للتتبع)
  final Map<DateTime, DoseState> doseStates;

  final String medicineType;

  // النوع حسب الحاجة
  final int? numberOfBlisters;
  final int? pillsPerBlister;

  final String? injectionBottleVolume;
  final String? injectionDosageValue;
  final String? injectionDosageUnit;

  final String? dropperBottleVolume;
  final int? teardropsPerDose;

  final String? liquidBottleVolume;
  final String? liquidDoseValue;
  final String? liquidDoseUnit;

  final String? inhalerPuffCount;
  final int? puffsPerDose;

  final List<double> doseSizes;   
final String doseUnit;         


  // حالة الأوفر دوز
  OverdoseStatus overdoseStatus;

  MedicineFullModel({
    required this.id,
    required this.medicineName,
    required this.doctorName,
    this.imagePath,
    this.shape,
    required this.numberOfPhases,
    required this.phaseDurations,
    required this.phaseStartDates,
    required this.phaseEndDates,
    required this.doses,
    required this.doseStates,
    required this.medicineType,
    this.numberOfBlisters,
    this.pillsPerBlister,
    this.injectionBottleVolume,
    this.injectionDosageValue,
    this.injectionDosageUnit,
    this.dropperBottleVolume,
    this.teardropsPerDose,
    this.liquidBottleVolume,
    this.liquidDoseValue,
    this.liquidDoseUnit,
    this.inhalerPuffCount,
    this.puffsPerDose,
   required this.doseSizes,
this.doseUnit = "mg",

    this.overdoseStatus = OverdoseStatus.unknown,
  });

  MedicineFullModel copyWith({
    String? id,
    String? medicineName,
    String? doctorName,
    String? imagePath,
    String? shape,
    int? numberOfPhases,
    List<List<String>>? phaseDurations,
    List<DateTime?>? phaseStartDates,
    List<DateTime?>? phaseEndDates,
    List<List<DoseModel>>? doses,
    Map<DateTime, DoseState>? doseStates,
    String? medicineType,
    int? numberOfBlisters,
    int? pillsPerBlister,
    String? injectionBottleVolume,
    String? injectionDosageValue,
    String? injectionDosageUnit,
    String? dropperBottleVolume,
    int? teardropsPerDose,
    String? liquidBottleVolume,
    String? liquidDoseValue,
    String? liquidDoseUnit,
    String? inhalerPuffCount,
    int? puffsPerDose,
    List<double>? doseSizes,
String? doseUnit,
    OverdoseStatus? overdoseStatus,
  }) {
    return MedicineFullModel(
      id: id ?? this.id,
      medicineName: medicineName ?? this.medicineName,
      doctorName: doctorName ?? this.doctorName,
      imagePath: imagePath ?? this.imagePath,
      shape: shape ?? this.shape,
      numberOfPhases: numberOfPhases ?? this.numberOfPhases,
      phaseDurations: phaseDurations ?? this.phaseDurations,
      phaseStartDates: phaseStartDates ?? this.phaseStartDates,
      phaseEndDates: phaseEndDates ?? this.phaseEndDates,
      doses: doses ?? this.doses,
      doseStates: doseStates ?? this.doseStates,
      medicineType: medicineType ?? this.medicineType,
      numberOfBlisters: numberOfBlisters ?? this.numberOfBlisters,
      pillsPerBlister: pillsPerBlister ?? this.pillsPerBlister,
      injectionBottleVolume:
          injectionBottleVolume ?? this.injectionBottleVolume,
      injectionDosageValue: injectionDosageValue ?? this.injectionDosageValue,
      injectionDosageUnit: injectionDosageUnit ?? this.injectionDosageUnit,
      dropperBottleVolume: dropperBottleVolume ?? this.dropperBottleVolume,
      teardropsPerDose: teardropsPerDose ?? this.teardropsPerDose,
      liquidBottleVolume: liquidBottleVolume ?? this.liquidBottleVolume,
      liquidDoseValue: liquidDoseValue ?? this.liquidDoseValue,
      liquidDoseUnit: liquidDoseUnit ?? this.liquidDoseUnit,
      inhalerPuffCount: inhalerPuffCount ?? this.inhalerPuffCount,
      puffsPerDose: puffsPerDose ?? this.puffsPerDose,
      doseSizes: doseSizes ?? this.doseSizes,
doseUnit: doseUnit ?? this.doseUnit,
      overdoseStatus: overdoseStatus ?? this.overdoseStatus,
    );
  }

  // حفظ البيانات في Firestore
Map<String, dynamic> toMap() {
  final map = {
    'id': id,
    'medicineName': medicineName,
    'doctorName': doctorName,
    'imagePath': imagePath,
    'shape': shape,
    'numberOfPhases': numberOfPhases,
    'phaseDurations': List.generate(
      phaseDurations.length,
      (i) => {"phase": i, "days": phaseDurations[i]},
    ),
    'phaseStartDates': phaseStartDates
        .map((d) => d != null ? Timestamp.fromDate(d) : null)
        .toList(),
    'phaseEndDates': phaseEndDates
        .map((d) => d != null ? Timestamp.fromDate(d) : null)
        .toList(),
    'doses': {
      for (int i = 0; i < doses.length; i++)
        'phase_$i': doses[i].map((d) => d.toMap()).toList(),
    },
    'doseStates': {
      for (var entry in doseStates.entries)
        entry.key.toIso8601String(): entry.value.name,
    },
    'medicineType': medicineType,

    
    'doseSizes': doseSizes,
    'doseUnit': doseUnit,

   
    'overdoseStatus': overdoseStatus.toString().split('.').last,
  };

  
  if (medicineType == "حبة") {
    map['numberOfBlisters'] = numberOfBlisters;
    map['pillsPerBlister'] = pillsPerBlister;
  } else if (medicineType == "حقنة") {
    map['injectionBottleVolume'] = injectionBottleVolume;
    map['injectionDosageValue'] = injectionDosageValue;
    map['injectionDosageUnit'] = injectionDosageUnit;
  } else if (medicineType == "قطرة") {
    map['dropperBottleVolume'] = dropperBottleVolume;
    map['teardropsPerDose'] = teardropsPerDose;
  } else if (medicineType == "شراب") {
    map['liquidBottleVolume'] = liquidBottleVolume;
    map['liquidDoseValue'] = liquidDoseValue;
    map['liquidDoseUnit'] = liquidDoseUnit;
  } else if (medicineType == "بخاخة") {
    map['inhalerPuffCount'] = inhalerPuffCount;
    map['puffsPerDose'] = puffsPerDose;
  }

  return map;
}


  ///  استرجاع البيانات من Firestore
factory MedicineFullModel.fromMap(Map<String, dynamic> map) {
  return MedicineFullModel(
    id: map['id'],
    medicineName: map['medicineName'] ?? "",
    doctorName: map['doctorName'] ?? "",
    imagePath: map['imagePath'],
    shape: map['shape'],
    numberOfPhases: map['numberOfPhases'] ?? 1,
  phaseDurations: (map['phaseDurations'] as List)
    .map<List<String>>((e) {
      final rawDays = e['days'] as List<dynamic>;
      return rawDays.map((day) {
        final d = day.toString().trim();
        return d.length >= 3 ? d.substring(0, 3) : d;
      }).toList();
    })
    .toList(),



    phaseStartDates: (map['phaseStartDates'] as List).map((d) {
      if (d == null) return null;
      if (d is Timestamp) return d.toDate();
      return DateTime.tryParse(d.toString());
    }).toList(),
    phaseEndDates: (map['phaseEndDates'] as List).map((d) {
      if (d == null) return null;
      if (d is Timestamp) return d.toDate();
      return DateTime.tryParse(d.toString());
    }).toList(),

    
    doseSizes: (map['doseSizes'] as List? ?? [])
    .map((e) => (e as num).toDouble())
    .toList(),


    doseUnit: map['doseUnit'] ?? "mg",

  doses: (map['doses'] as Map<String, dynamic>?)
        ?.entries
        .map((entry) {
          final phaseList = entry.value as List<dynamic>;
          return phaseList
              .map((d) => DoseModel.fromMap(d as Map<String, dynamic>))
              .toList();
        })
        .toList()
        .cast<List<DoseModel>>() 
    ?? [],

    doseStates: (map['doseStates'] as Map<String, dynamic>?)?.map((key, value) {
          final date = DateTime.tryParse(key);
          final state = DoseState.values.firstWhere(
            (e) => e.name == value || e.toString() == value,
            orElse: () => DoseState.none,
          );
          return MapEntry(date!, state);
        }) ??
        {},
    medicineType: map['medicineType'] ?? "",
    numberOfBlisters: map['numberOfBlisters'],
    pillsPerBlister: map['pillsPerBlister'],
    injectionBottleVolume: map['injectionBottleVolume'],
    injectionDosageValue: map['injectionDosageValue'],
    injectionDosageUnit: map['injectionDosageUnit'],
    dropperBottleVolume: map['dropperBottleVolume'],
    teardropsPerDose: map['teardropsPerDose'],
    liquidBottleVolume: map['liquidBottleVolume'],
    liquidDoseValue: map['liquidDoseValue'],
    liquidDoseUnit: map['liquidDoseUnit'],
    inhalerPuffCount: map['inhalerPuffCount'],
    puffsPerDose: map['puffsPerDose'],
    overdoseStatus: _parseOverdoseStatus(map['overdoseStatus']),
  );
}


  //تحويل النص القادم من Firebase إلى Enum
  static OverdoseStatus _parseOverdoseStatus(dynamic value) {
    if (value == null) return OverdoseStatus.unknown;
    return OverdoseStatus.values.firstWhere(
      (e) => e.toString().split('.').last == value,
      orElse: () => OverdoseStatus.unknown,
    );
  }

  // عدد الجرعات اليومية
 int get dosesPerDay {
  if (doses.isNotEmpty) {
    return doses.first.length;
  }
  return 0;
}

}

///  امتداد لتحويل TimeOfDay إلى نص (24h)
extension TimeOfDayFormatter on TimeOfDay {
  String format24() {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return "$h:$m";
  }
}
