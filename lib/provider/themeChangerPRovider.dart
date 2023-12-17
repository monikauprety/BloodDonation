import 'package:flutter/material.dart';

class themeChangerProvider with ChangeNotifier {
  var _themeModeChanger = ThemeMode.light;
  ThemeMode get thememode => _themeModeChanger;
  void setTheme(thememode) {
    _themeModeChanger = thememode;
    notifyListeners();
  }
}
