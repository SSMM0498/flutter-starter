import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/utils/device_utility.dart';
import 'package:starter/utils/helper_functions.dart';
import 'package:get/get.dart'; // Import Get for navigation
import 'package:starter/routes/routes.dart'; // Import your routes

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final darkMode = HelperFunctions.isDarkMode(context);
    final TextEditingController controller = TextEditingController();

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: DeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(Sizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? darkMode
                    ? AppColors.dark
                    : AppColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
            border: showBorder ? Border.all(color: AppColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: darkMode ? AppColors.lightGrey : AppColors.darkerGrey),
              const SizedBox(width: Sizes.spaceBtwItems),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: text,
                    isDense: true, // Remove extra padding
                    contentPadding: EdgeInsets.zero, // Remove content padding
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none, // Remove border
                  ),
                  onSubmitted: (searchText) {
                    controller.clear();
                    Get.toNamed(Routes.search, arguments: {'search': searchText});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
