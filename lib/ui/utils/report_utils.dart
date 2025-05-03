import 'package:flutter/services.dart';

class ReportUtils {
  Future<Uint8List> loadLogoBytes() async {
    final bytes = await rootBundle.load('assets/images/logo.png');
    return bytes.buffer.asUint8List();
  }

  List<Map<String, dynamic>> normalizeToList(dynamic data) {
    if (data == null) return [];
    if (data is List) return List<Map<String, dynamic>>.from(data);
    if (data is Map<String, dynamic>) return [data];
    return [];
  }
}
