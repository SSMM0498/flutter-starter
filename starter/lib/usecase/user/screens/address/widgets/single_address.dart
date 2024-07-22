
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:starter/usecase/user/controllers/address_controller.dart';
import 'package:starter/data/models/address_model.dart';
import 'package:starter/utils/helper_functions.dart';


class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = HelperFunctions.isDarkMode(context);
    return Obx(
      () {
        final selectedAddressId = controller.selectedAddress.value.id;

        final selectedAddress = selectedAddressId == address.id;
        return InkWell(
          onTap: onTap,
          radius: Sizes.cardRadiusLg,
          child: RoundedContainer(
            padding: const EdgeInsets.all(Sizes.md),
            width: double.infinity,
            showBorder: true,
            backgroundColor: selectedAddress ? AppColors.primary.withOpacity(0.5) : Colors.transparent,
            borderColor: selectedAddress
                ? Colors.transparent
                : dark
                    ? AppColors.darkerGrey
                    : AppColors.grey,
            margin: const EdgeInsets.only(bottom: Sizes.spaceBtwItems),
            child: Stack(
              children: [
                Positioned(
                  right: 5,
                  top: 0,
                  child: Icon(
                    selectedAddress ? Iconsax.tick_circle5 : null,
                    color: selectedAddress
                        ? dark
                            ? AppColors.light
                            : AppColors.dark
                        : null,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: Sizes.sm / 2),
                    Text(address.formattedPhoneNo, maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: Sizes.sm / 2),
                    Text(address.toString(), softWrap: true),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
