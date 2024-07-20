import 'package:get/get.dart';
import 'package:starter/core/middleware/auth_guard.dart';
import 'package:starter/routes/navigation_panel.dart';
import 'package:starter/routes/routes.dart';
import 'package:starter/usecase/auth/screens/login/login.dart';
import 'package:starter/usecase/auth/screens/onboarding/onboarding.dart';
import 'package:starter/usecase/auth/screens/password_configuration/forget_password.dart';
import 'package:starter/usecase/auth/screens/signup/signup.dart';
import 'package:starter/usecase/main/screens/home_screen.dart';
import 'package:starter/usecase/user/screens/profile/profile.dart';
import 'package:starter/usecase/user/screens/settings/settings.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: Routes.signup,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.forgetPassword,
      page: () => const ForgetPassword(),
    ),
    GetPage(
      name: Routes.onBoarding,
      page: () => const OnBoardingScreen(),
    ),
    GetPage(
      name: Routes.navigationPanel,
      page: () => const NavigationPanel(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: Routes.userProfile,
      page: () => const ProfileScreen(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: Routes.settings,
      page: () => const SettingsScreen(),
      middlewares: [AuthGuard()],
    ),
  ];
}
