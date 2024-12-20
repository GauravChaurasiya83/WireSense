import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wire_sense/features/ForwardProcessing/ForwardInput/view/forward_input.dart';
import 'package:wire_sense/features/LoginScreen/view/login_scr.dart';
import 'package:wire_sense/features/optionsScreen/view/options_scr.dart';
import '../../features/ForwardProcessing/ForwardOutputScreen/view/forward_output.dart';
import '../../features/MainDashBoard/view/dashboard.dart';
import '../../features/ReversedProcessing/ReverseInputscreen/reverse_input_screen.dart';
import '../../features/ReversedProcessing/reverseOutPutScreen/reverse_output.dart';
import 'app_routes.dart';
class appPages {
  static List<RouteEntity> routes() {
    return [
      RouteEntity(
          path: AppRoutes.DASHBOARD,
          page: const ProviderScope(child: Dashboard())),
      RouteEntity(
          path: AppRoutes.OPTIONS,
          page: ProviderScope(child: FancyAuthScreen())),
      RouteEntity(
          path: AppRoutes.FORWARDINPUTS,
          page: const ProviderScope(child: ForwardInputScreen())),
      RouteEntity(
          path: AppRoutes.FORWARDOUTPUTS,
          page: const ProviderScope(child: ForwardOutput(null,null,null))),
      RouteEntity(
          path: AppRoutes.LOGIN,
          page: const ProviderScope(child: LoginPage())),
      RouteEntity(
          path: AppRoutes.REVERSEINPUTS,
          page: ProviderScope(child: ControlCenterPage())),
      RouteEntity(
          path: AppRoutes.REVERSEOUTPUTS,
          page: const ProviderScope(child: ReverseOutput(uts: null, conductivity: null, elongation: null,))),
    ];
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (kDebugMode) {
      print('current route name is ${settings.name}');
    }
    if (settings.name != null) {
      var result = routes().where((element) => element.path == settings.name);

      if(result.first.path ==AppRoutes.LOGIN)
        {
          return MaterialPageRoute(
              builder: (_) => const ProviderScope(child: LoginPage()),
              settings: settings);
        }
      else{
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
      //   bool userRegisteredEarlier =
      //   Global.storageServices.getUserRegisteredEarlier();
      //   bool locationGranted = Global.storageServices.getLocationGranted();
      //
      //   bool openedFirstTime = Global.storageServices.getOpenedFirstTime();
      //
      //   /// NOW HERE WE ARE CHECKING IF THE CURRENT ROUTE IS WELCOME PAGE ROUTE AND Device has been opened earlier...
      //   /// and if it is true then navigate the user to the login screen..not to the welcome screen anymore
      //   /// NOTE- THIS INFORMATION WHETHER THE DEVICE IS OPENED FIRST TIME OR NOT WILL BE STORED UNDER THE getDeviceOpenedEarlier()
      //   /// FUNCTION OF STORAGE SERVICES WHICH IS CAPABLE OF STORING THE STATE EVEN IF THE APP IS CLOSED....
      //   ///  THIS STATE OF getDeviceOpenedEarlier() WILL BE STORED IN THE PERMANENT MEMORY...
      //   if (result.first.path == AppRoutes.WELCOME && !openedFirstTime) {
      //     {
      //       bool isLoggedIn = userRegisteredEarlier;
      //       if (isLoggedIn) {
      //         bool isLocationGranted = locationGranted;
      //         if (isLocationGranted) {
      //           return MaterialPageRoute(
      //               builder: (_) =>
      //               const ProviderScope(child: Application()),
      //               settings: settings);
      //         } else {
      //           return MaterialPageRoute(
      //               builder: (_) =>
      //               const ProviderScope(child: LocationRequestScreen()),
      //               settings: settings);
      //         }
      //       } else {
      //         return MaterialPageRoute(
      //             builder: (_) => const ProviderScope(child: SignUpScreen()),
      //             settings: settings);
      //       }
      //     }
      //   } else {
      //     return MaterialPageRoute(
      //         builder: (_) => result.first.page, settings: settings);
      //   }
      // }
      // return MaterialPageRoute(
      //     builder: (_) => const ProviderScope(child: ControlCommand()),
      //     settings: settings);
    }
    return MaterialPageRoute(
        builder: (_) =>  ProviderScope(child: ControlCenterPage()),
        settings: settings);
  }
}

class RouteEntity {
  String path;
  Widget page;

  RouteEntity({required this.path, required this.page});
}
