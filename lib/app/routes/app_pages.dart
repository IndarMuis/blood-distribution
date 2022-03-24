import 'package:blood_distirbution/app/modules/profile/bindings/profile_binding.dart';
import 'package:get/get.dart';

import 'package:blood_distirbution/app/modules/blood_donor/bindings/blood_donor_binding.dart';
import 'package:blood_distirbution/app/modules/blood_donor/views/blood_donor_view.dart';
import 'package:blood_distirbution/app/modules/home/bindings/home_binding.dart';
import 'package:blood_distirbution/app/modules/home/views/home_view.dart';
import 'package:blood_distirbution/app/modules/login/bindings/login_binding.dart';
import 'package:blood_distirbution/app/modules/login/views/login_view.dart';
import 'package:blood_distirbution/app/modules/register/bindings/register_binding.dart';
import 'package:blood_distirbution/app/modules/register/views/register_view.dart';
import 'package:blood_distirbution/app/modules/search_donor/bindings/search_donor_binding.dart';
import 'package:blood_distirbution/app/modules/search_donor/views/search_donor_view.dart';
import 'package:blood_distirbution/app/modules/splash/bindings/splash_binding.dart';
import 'package:blood_distirbution/app/modules/splash/views/splash_view.dart';

import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BLOOD_DONOR,
      page: () => BloodDonorView(),
      binding: BloodDonorBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_DONOR,
      page: () => SearchDonorView(),
      binding: SearchDonorBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
