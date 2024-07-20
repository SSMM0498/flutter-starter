import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:starter/core/services/pocketbase/pocketbase.dart';
import 'package:starter/routes/routes.dart';

class AuthGuard extends GetMiddleware {
  final PocketBase pb = PocketBaseSingleton().client;

  @override
  RouteSettings? redirect(String? route) {
    // User is not authenticated, redirect to login page
    if (!pb.authStore.isValid) {
      print("❌ Screen protected");
      return const RouteSettings(name: Routes.login);
    }

    return null;
  }
}
