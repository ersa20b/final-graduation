import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class InteractionService {
  static List<dynamic> _interactions = [];

  /// تحميل الداتا من ملف JSON
  static Future<void> loadInteractions() async {
    final String response = await rootBundle.loadString('assets/interactions.json');
    _interactions = json.decode(response);

    print(" Loaded interactions: ${_interactions.length} entries");
    if (_interactions.isNotEmpty) {
      print(" First entry: ${_interactions.first}");
    }
  }

  /// فحص التداخل بين دوائين
  static String? checkPairInteraction(String? drug1, String? drug2) {
  try {
    final d1 = drug1?.toLowerCase().trim() ?? "";
    final d2 = drug2?.toLowerCase().trim() ?? "";

    print("DEBUG [InteractionService] checkPairInteraction → d1='$d1', d2='$d2'");

    if (d1.isEmpty || d2.isEmpty) {
      print("⚠️ [InteractionService] one of the drug names is empty → skip");
      return null;
    }

    // 👉 هنا منطقك الأصلي لمقارنة التداخل
    // if (_dataset.containsPair(d1, d2)) return "Conflict found";

    return null;
  } catch (e) {
    print("❌ [InteractionService] checkPairInteraction failed: $e");
    return null;
  }
}

}
