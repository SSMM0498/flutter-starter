import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/colors.dart';

class ActionCounter extends StatelessWidget {
  const ActionCounter({
    super.key,
    this.iconColor,
  });

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: () {}, icon: Icon(Iconsax.shopping_bag, color: iconColor)),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                "4",
                style: Theme.of(context).textTheme.labelLarge!.apply(color: AppColors.white, fontSizeFactor: 0.8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
