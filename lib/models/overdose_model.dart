/// ✅ Enum يحدد حالة الجرعة
enum OverdoseStatus { safe, overdose, unknown }

class OverdoseModel {
  final String drugName;     // اسم الدواء
  final int age;             // عمر المستخدم بالسنوات
  final double perDose;      // حجم الجرعة 
  final int dosesPerDay;     // عدد المرات في اليوم
  OverdoseStatus status;     // النتيجة safe / overdose / unknown

  OverdoseModel({
    required this.drugName,
    required this.age,
    required this.perDose,
    required this.dosesPerDay,
    this.status = OverdoseStatus.unknown,
  });

  // يحسب الجرعة اليومية
  double get dailyDose => perDose * dosesPerDay;

  // تحويل  JSON  
  Map<String, dynamic> toJson() {
    return {
      "drugName": drugName,
      "age": age,
      "perDose": perDose,
      "dosesPerDay": dosesPerDay,
      "dailyDose": dailyDose,
      "status": status.toString().split('.').last, 
    };
  }
}
