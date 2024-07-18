
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:starter/common/styles/sizes.dart';
import 'package:starter/common/widgets/appbar/appbar.dart';
import 'package:starter/usecase/auth/controllers/forget_password/forget_password_controller.dart';
import 'package:starter/utils/validation.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: const CustomAppBar(showBackArrow: true),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forget password",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: Sizes.spaceBtwItems),
            Text(
              "Don’t worry sometimes people can forget too, enter your email and we will send you a password reset link.",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: Sizes.spaceBtwSections * 2),
            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: Validator.validateEmail,
                decoration: const InputDecoration(
                  labelText: "E-Mail",
                  prefixIcon: Icon(Iconsax.direct_right),
                ),
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.sendPasswordResetEmail(),
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
