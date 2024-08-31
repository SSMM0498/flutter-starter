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
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  const SizedBox(height: Sizes.spaceBtwSections * 0.25),
                  const HomeAppBar(),
                  const SizedBox(height: Sizes.spaceBtwSections * 0.5),
                  SearchContainer(text: localizations.search),
                  const SizedBox(height: Sizes.spaceBtwSections * 1.5),
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
