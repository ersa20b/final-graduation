class V {
  //  الدالة ترجع null = التحقق ناجح، وترجع نص = رسالة خطأ

  // تحقق الحقل مطلوب
  static String? required(String? v, {String msg = 'هذا الحقل مطلوب'}) {
    if (v == null || v.trim().isEmpty) return msg;
    return null;
  }

  // بريد إلكتروني صحيح
  static String? email(String? v) {
    if (required(v) != null) return 'البريد الإلكتروني مطلوب';
    final re = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!re.hasMatch(v!.trim())) return 'صيغة البريد غير صحيحة';
    return null;
  }

  // رقم هاتف ليبي
  static String? libyaPhone(String? v) {
    if (required(v) != null) return 'رقم الهاتف مطلوب';
    final s = v!.replaceAll(' ', '');
    final re = RegExp(r'^(\+218|00218|0)(9[1-8]\d{7})$');
    if (!re.hasMatch(s)) return 'أدخل رقم ليبي صحيح (مثال: 0912345678)';
    return null;
  }

  // طول أدنى للنص
  static String? minLen(String? v, int n, {String? label}) {
    if (v == null || v.trim().length < n) {
      return '${label ?? "النص"} يجب ألا يقل عن $n أحرف';
    }
    return null;
  }

  // كلمة مرور قوية
  static String? strongPassword(String? v, {int min = 8}) {
    if (required(v) != null) return 'كلمة المرور مطلوبة';
    final s = v!.trim();
    if (s.length < min) return 'كلمة المرور لا تقل عن $min أحرف';
    if (!RegExp(r'[A-Z]').hasMatch(s)) return 'تتطلب حرف كبير واحد على الأقل';
    if (!RegExp(r'[a-z]').hasMatch(s)) return 'تتطلب حرف صغير واحد على الأقل';
    if (!RegExp(r'\d').hasMatch(s)) return 'تتطلب رقمًا واحدًا على الأقل';
    return null;
  }
  
}
