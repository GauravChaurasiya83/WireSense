import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:wire_sense/common/services/storage.dart';
class Global {
   static late StorageServices storageServices;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // this is for initialising the storage services
    storageServices = await StorageServices().init();
    if (kDebugMode) {
      print('successfully initialized all the services');
    }
  }
}
