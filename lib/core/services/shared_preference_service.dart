import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_notes/core/utils/constants.dart';

class SharedPreferenceService {
  late SharedPreferences _preferences;
  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  double getSpeed() {
    return _preferences.getDouble(AppConstants.speed) ?? 1;
  }

  Future<void> setSpeed(double val) {
    return _preferences.setDouble(AppConstants.speed, val);
  }
}
