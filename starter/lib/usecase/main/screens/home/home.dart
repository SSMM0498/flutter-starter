import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:starter/common/widgets/custom_shapes/containers/search_container.dart';

import 'package:starter/usecase/main/screens/home/widgets/home_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PrimaryHeaderContainer(
              child: Column(
                children: [
                  HomeAppBar(),
                  SizedBox(height: Sizes.spaceBtwSections),
                  SearchContainer(text: "Search items"),
                  SizedBox(height: Sizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [Text(localizations.helloWorld)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
