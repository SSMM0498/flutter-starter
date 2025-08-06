import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/widgets/appbar/appbar.dart';
import 'package:starter/common/widgets/shimmers/shimmer.dart';
import 'package:starter/usecase/main/screens/home/widgets/action_counter.dart';
import 'package:starter/usecase/user/controllers/user_controller.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();
    return CustomAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Assalamu aleykum", style: Theme.of(context).textTheme.labelMedium!.apply(color: AppColors.grey)),
          Obx(
            () {
              if (controller.profileLoading.value) {
                return const CustomShimmerEffect(width: 80, height: 15);
              } else {
                return Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: AppColors.light));
              }
            },
          ),
        ],
      ),
      actions: const [
        ActionCounter(
          iconColor: AppColors.white,
        ),
      ],
    );
  }
}
