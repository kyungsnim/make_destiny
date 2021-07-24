import 'package:get/get.dart';
import 'package:make_destiny/ui/ui.dart';
import 'package:make_destiny/ui/auth/auth.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => SplashUI()),
    GetPage(name: '/newsignin', page: () => NewSignInUI()),
    GetPage(name: '/signup', page: () => SignUpUI()),
    GetPage(name: '/home', page: () => HomeUI(0)),
    GetPage(name: '/settings', page: () => SettingsUI()),
    GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    GetPage(name: '/update-profile', page: () => UpdateProfileUI()),
  ];
}
