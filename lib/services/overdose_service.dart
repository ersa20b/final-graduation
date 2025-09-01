import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:graduation_med_/models/overdose_model.dart';

class OverdoseService {
  static List<Map<String, dynamic>>? _cachedDataset;

  /// تحميل الداتا مرة وحدة
  static Future<void> loadDatasetOnce() async {
    if (_cachedDataset == null) {
      final jsonString = await rootBundle.loadString('assets/overdose_dataset.json');
      final localData = json.decode(jsonString) as List<dynamic>;
      _cachedDataset = localData.cast<Map<String, dynamic>>();
      print("✅ Dataset loaded once with ${_cachedDataset!.length} records");
    }
  }

  static List<Map<String, dynamic>> get dataset {
    if (_cachedDataset == null) {
      throw Exception("❌ Dataset not loaded yet. Call loadDatasetOnce() first.");
    }
    return _cachedDataset!;
  }

  /// 🔎 فحص الجرعة بالاعتماد على الداتا المحلية فقط
  static Future<OverdoseStatus> checkOverdoseWithFallback(OverdoseModel model) async {
    try {
      final safeDrugName = model.drugName?.toLowerCase().trim() ?? "";
      print("DEBUG [OverdoseService] drugName='$safeDrugName', age=${model.age}, dailyDose=${model.dailyDose}");

      if (safeDrugName.isEmpty) {
        print("⚠️ [OverdoseService] drugName is empty → skipping overdose check");
        return OverdoseStatus.unknown;
      }

      final localData = dataset;

      final drugData = localData.firstWhere(
        (d) {
          final dName = (d["drugName"] as String?)?.toLowerCase().trim() ?? "";
          final ageRange = (d["ageRange"] as String).split("-");
          final minAge = int.tryParse(ageRange[0]) ?? 0;
          final maxAge = int.tryParse(ageRange[1]) ?? 200;

          return dName == safeDrugName &&
                 model.age >= minAge && model.age <= maxAge;
        },
        orElse: () => <String, dynamic>{},
      );

      if (drugData.isNotEmpty) {
        final maxPerDose = (drugData["maxPerDose_mg"] as num).toDouble();
        final maxDosesPerDay = drugData["maxDosesPerDay"] as int;
        final allowedDaily = maxPerDose * maxDosesPerDay;

        print("DEBUG [OverdoseService] local check for $safeDrugName → "
            "allowedDaily=$allowedDaily, modelDaily=${model.dailyDose}");

        return model.dailyDose > allowedDaily
            ? OverdoseStatus.overdose
            : OverdoseStatus.safe;
      }
    } catch (e) {
      print("❌ [OverdoseService] dataset check failed: $e");
    }

    return OverdoseStatus.unknown;
  }
}
