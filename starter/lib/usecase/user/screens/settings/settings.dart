import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starter/common/widgets/appbar/appbar.dart';
import 'package:starter/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:starter/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:starter/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:starter/usecase/user/screens/settings/widgets/lang.dart';
import 'package:starter/usecase/user/screens/settings/widgets/theme.dart';
import 'package:starter/common/widgets/text/section_heading.dart';
import 'package:starter/core/controllers/auth_controller.dart';
import 'package:starter/usecase/user/screens/address/address.dart';
import 'package:starter/usecase/user/screens/profile/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  CustomAppBar(
                    title: Text(localizations.account, style: Theme.of(context).textTheme.headlineMedium!.apply(color: AppColors.white)),
                  ),
                  UserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: Sizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  // Account Settings
                  SectionHeading(title: localizations.accountSettings, showActionButton: false),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  SettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: localizations.myAddresses,
                    subTitle: localizations.myAddressesSubtitle,
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  //   SettingsMenuTile(
                  //     icon: Iconsax.shopping_cart,
                  //     title: 'My Cart',
                  //     subTitle: 'Add, remove products and move to checkout',
                  //     onTap: () {},
                  //   ),
                  //   SettingsMenuTile(
                  //     icon: Iconsax.bag_tick,
                  //     title: 'My Orders',
                  //     subTitle: 'In-progress and Completed Orders',
                  //     onTap: () {},
                  //   ),
                  //   const SettingsMenuTile(icon: Iconsax.bank, title: 'Bank Account', subTitle: 'Withdraw balance to registered bank account'),
                  //   const SettingsMenuTile(icon: Iconsax.discount_shape, title: 'My Coupons', subTitle: 'List of all the discounted coupons'),
                  SettingsMenuTile(icon: Iconsax.notification, title: localizations.notifications, subTitle: localizations.notificationsSubtitle),
                  SettingsMenuTile(icon: Iconsax.security_card, title: localizations.accountPrivacy, subTitle: localizations.accountPrivacySubtitle),
                  const SizedBox(height: Sizes.spaceBtwSections),
                  // App Settings
                  SectionHeading(title: localizations.appSettings, showActionButton: false),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  SettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: localizations.loadData,
                    subTitle: localizations.loadDataSubtitle,
                    onTap: () {},
                  ),
                //   SettingsMenuTile(
                //     icon: Iconsax.location,
                //     title: 'Geolocation',
                //     subTitle: 'Set recommendation based on location',
                //     trailing: Switch(value: true, onChanged: (value) {}),
                //   ),
                  SettingsMenuTile(
                    icon: Iconsax.moon,
                    title: localizations.darkMode,
                    subTitle: localizations.darkModeSubtitle,
                    trailing: ThemeSwitcherWidget(),
                  ),
                  LanguageSwitcherWidget(),
                  const SizedBox(height: Sizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: () => AuthController.instance.logout(), child: Text(localizations.logout)),
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
