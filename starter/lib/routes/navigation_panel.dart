import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/l10n/app_localizations.dart';
import 'package:starter/usecase/main/screens/device/device.dart';
import 'package:starter/usecase/main/screens/home/home.dart';
import 'package:starter/usecase/user/screens/settings/settings.dart';
import 'package:starter/utils/helper_functions.dart';

class NavigationPanel extends StatelessWidget {
  const NavigationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = HelperFunctions.isDarkMode(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 70,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? AppColors.dark : AppColors.light,
          indicatorColor: darkMode ? AppColors.white.withOpacity(0.1) : AppColors.dark.withOpacity(0.1),
          destinations: [
            NavigationDestination(icon: const Icon(Iconsax.home), label: localizations.home),
            NavigationDestination(icon: const Icon(Iconsax.grid_2), label: localizations.library),
            NavigationDestination(icon: const Icon(Iconsax.layer), label: localizations.category),
            NavigationDestination(icon: const Icon(Iconsax.user), label: localizations.profile),
          ],
        ),
      ),
      body: Obx(
        () => PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation, secondAnimation) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondAnimation,
              child: child,
            );
          },
          child: controller.screens[controller.selectedIndex.value],
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const DeviceAccessTestScreen(), // Placeholder for a feature
    Container(color: Colors.orange), // Placeholder for a feature
    const SettingsScreen(),
  ];
}
