import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dose_state.dart'; 

class DoseModel {
  final String id;           
  final TimeOfDay? time;      
  DoseState state;            

  DoseModel({
    String? id,
    this.time,              
    this.state = DoseState.none,
  }) : id = id ?? const Uuid().v4();

  // تحويل الجرعة إلى Map لتخزينها في Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time != null
          ? "${time!.hour.toString().padLeft(2, '0')}:${time!.minute.toString().padLeft(2, '0')}"
          : null, 
      'state': state.name,
    };
  }

  // استرجاع الجرعة من Map عند القراءة من Firebase
  factory DoseModel.fromMap(Map<String, dynamic> map) {
    final timeStr = map['time'] as String?;
    return DoseModel(
      id: map['id'],
      time: timeStr != null ? TimeOfDayX.from24Format(timeStr) : null,
      state: DoseState.values.firstWhere(
        (e) => e.name == map['state'],
        orElse: () => DoseState.none,
      ),
    );
  }

  // نسخة جديدة من الجرعة مع تعديل أي قيمة
  DoseModel copyWith({
    String? id,
    TimeOfDay? time,
    DoseState? state,
  }) {
    return DoseModel(
      id: id ?? this.id,
      time: time ?? this.time,
      state: state ?? this.state,
    );
  }
}

extension TimeOfDayX on TimeOfDay {
  String to24Format() {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }

  static TimeOfDay from24Format(String timeStr) {
    final parts = timeStr.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
}
