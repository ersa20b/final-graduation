class MedicineCardModel {
  final String id;             
  final String imagePath;     
  final String medicineName;  
  final String doctorName;     
  final List<String> days;    
  final int dosesPerDay;      

  MedicineCardModel({
    required this.id,
    required this.imagePath,
    required this.medicineName,
    required this.doctorName,
    required this.days,
    required this.dosesPerDay,
  });

  bool get isDaily => days.length == 7;

  String get displayDays => isDaily ? "Daily" : "Specific Days";

  //  لتحويل الكائن إلى Map للتخزين
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'medicineName': medicineName,
      'doctorName': doctorName,
      'days': days,
      'dosesPerDay': dosesPerDay,
    };
  }

  //  لإنشاء الكائن من Map عند القراءة من Firebase
  factory MedicineCardModel.fromMap(Map<String, dynamic> map) {
    return MedicineCardModel(
      id: map['id'],
      imagePath: map['imagePath'],
      medicineName: map['medicineName'],
      doctorName: map['doctorName'],
      days: List<String>.from(map['days']),
      dosesPerDay: map['dosesPerDay'],
    );
  }
}
