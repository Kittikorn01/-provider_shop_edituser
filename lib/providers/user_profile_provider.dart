import 'package:flutter/foundation.dart';

class UserProfileProvider extends ChangeNotifier {
  String _username = 'Student101'; // ชื่อผู้ใช้เริ่มต้น

  String get username => _username;

  void changeUsername(String newName) {
    _username = newName;
    notifyListeners();
  }
}
