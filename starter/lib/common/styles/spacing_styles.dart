import 'package:flutter/material.dart';

import 'package:starter/common/styles/sizes.dart';

class SpacingStyles {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: Sizes.appBarHeight,
    left: Sizes.defaultSpace,
    right: Sizes.defaultSpace,
    bottom: Sizes.defaultSpace,
  );
}
