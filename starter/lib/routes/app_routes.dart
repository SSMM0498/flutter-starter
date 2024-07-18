import 'package:get/get.dart';
import 'package:starter/core/middleware/auth_guard.dart';
import 'package:starter/routes/routes.dart';
import 'package:starter/usecase/auth/screens/login/login.dart';
import 'package:starter/usecase/auth/screens/onboarding/onboarding.dart';
import 'package:starter/usecase/auth/screens/password_configuration/forget_password.dart';
import 'package:starter/usecase/auth/screens/signup/signup.dart';
import 'package:starter/usecase/main/screens/home_screen.dart';

class AppRoutes {
  static final pages = [
    GetPage(
      name: Routes.signup,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: Routes.signIn,
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
      name: Routes.home,
      page: () => const HomeScreen(),
      middlewares: [AuthGuard()]
    ),
  ];
}
