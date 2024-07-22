import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/common/widgets/appbar/appbar.dart';
import 'package:starter/usecase/user/controllers/address_controller.dart';
import 'package:starter/usecase/user/screens/address/add_new_address.dart';
import 'package:starter/usecase/user/screens/address/widgets/single_address.dart';
import 'package:starter/utils/cloud_helper_functions.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        backgroundColor: AppColors.primary,
        child: const Icon(Iconsax.add, color: AppColors.white),
      ),
      appBar: CustomAppBar(showBackArrow: true, title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Obx(
          () => FutureBuilder(
            key: Key(controller.refreshData.value.toString()),
            future: controller.getAllUserAddresses(),
            builder: (context, snapshot) {
              final response = CloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);

              if (response != null) return response;

              final addresses = snapshot.data!;

              return ListView.builder(
                shrinkWrap: true,
                itemCount: addresses.length,
                itemBuilder: (_, index) => SingleAddress(
                  address: addresses[index],
                  onTap: () => controller.selectAddress(addresses[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
