import 'package:flutter/material.dart';

import 'package:starter/common/styles/colors.dart';
import 'package:starter/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:starter/utils/helper_functions.dart';
import 'circular_container.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);

    return CurvedEdgeWidget(
      child: Container(
        color: isDark ? AppColors.primary : AppColors.darkPrimary,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: CircularContainer(backgroundColor: AppColors.textWhite.withOpacity(0.1)),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: CircularContainer(backgroundColor: AppColors.textWhite.withOpacity(0.1)),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
