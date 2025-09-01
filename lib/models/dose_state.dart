import 'package:flutter/material.dart';

// حالات الجرعة
enum DoseState {
  none,       
  taken,      
  missed,     
  cancelled   
}


extension DoseStateExtension on DoseState {
  /// يرجع اللون المناسب للحالة
  Color get color {
    switch (this) {
      case DoseState.taken:
        return Colors.green;
      case DoseState.missed:
        return Colors.red;
      case DoseState.cancelled:
        return Colors.brown;
      case DoseState.none:
      default:
        return Colors.grey;
    }
  }

 
  String get label {
    switch (this) {
      case DoseState.taken:
        return "Taken";
      case DoseState.missed:
        return "Missed";
      case DoseState.cancelled:
        return "Cancelled";
      case DoseState.none:
      default:
        return "None"; 
    }
  }
}
