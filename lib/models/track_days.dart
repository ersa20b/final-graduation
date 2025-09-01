import 'package:graduation_med_/models/dose_model.dart';

class TrackingDay {
  final DateTime date;
  final List<DoseModel> doses;

  TrackingDay({required this.date, required this.doses});
}
