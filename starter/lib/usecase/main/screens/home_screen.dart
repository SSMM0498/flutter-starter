import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pocketbase/pocketbase.dart';

import 'package:starter/common/widgets/switcher/lang.dart';
import 'package:starter/common/widgets/switcher/theme.dart';
import 'package:starter/core/controllers/auth_controller.dart';
import 'package:starter/core/services/pocketbase/pocketbase.dart';
import 'package:starter/data/models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  final PocketBase pb = PocketBaseSingleton().client;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final user = UserModel.fromJson(json.decode(json.encode(pb.authStore.model)));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(localizations.helloWorld),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(pb.authStore.isValid.toString()),
            Text("${user.firstName} ${user.lastName}"),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(onPressed: () => AuthController.instance.logout(), child: const Text('Logout')),
            ),
            LanguageSwitcherWidget(),
            ThemeSwitcherWidget()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
