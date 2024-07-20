import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/widgets/images/circular_image.dart';
import 'package:starter/common/widgets/shimmers/shimmer.dart';
import 'package:starter/usecase/user/controllers/user_controller.dart';
import 'package:starter/utils/image_strings.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return ListTile(
      leading: Obx(() {
        final networkImage = controller.user.profilePicUrl;
        final image = networkImage != null ? networkImage.toString() : ImageStrings.user;
        return controller.imageUploading.value
            ? const CustomShimmerEffect(width: 50, height: 50, radius: 50)
            : CircularImage(image: image, width: 50, height: 50, isNetworkImage: networkImage != null, padding: 0);
      }),
      title: Text(
        controller.user.fullName,
        maxLines: 2,
        style: Theme.of(context).textTheme.headlineSmall!.apply(color: AppColors.white),
      ),
      subtitle: Text(
        controller.user.email,
        style: Theme.of(context).textTheme.bodyMedium!.apply(color: AppColors.white),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(Iconsax.edit, color: AppColors.white),
      ),
    );
  }
}
