import 'package:shared_preferences/shared_preferences.dart';
class StorageServices {
  late final SharedPreferences _pref;

  Future<StorageServices> init() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }
  String getString(String key){
    return _pref.getString(key)??" ";
  }

//   String getUserToken(){
//     return _pref.getString(AppConstants.storageUserTokenKey)??"";
// }

  Future<bool> setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  // bool getUserRegisteredEarlier(){
  //   // give the value of bool if it has been set early and if it is not set then give false as the value
  //   return _pref.getBool(AppConstants.userRegisteredEarlier) ?? false;
  // }
  // bool getOpenedFirstTime(){
  //   // give the value of bool if it has been set early and if it is not set then give false as the value
  //   return _pref.getBool(AppConstants.openedFirstTime) ?? true;
  // }
  // bool getLocationGranted(){
  //   // give the value of bool if it has been set early and if it is not set then give false as the value
  //   return _pref.getBool(AppConstants.locationGranted) ?? false;
  // }
  // bool getNameSet(){
  //   // give the value of bool if it has been set early and if it is not set then give false as the value
  //   return _pref.getBool(AppConstants.nameSet) ?? false;
  // }

}
