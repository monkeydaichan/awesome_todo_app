import 'dart:async';

import 'package:awesome_todo_app/resource/entity/todo.dart';
import 'package:awesome_todo_app/screen/todo_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await runZonedGuarded<Future<void>>(() async {
    runApp(ProviderScope(
        // overrides: [boxProvider.overrideWithProvider(Provider((_) => box))],
        child: MyApp()));
  }, (error, stackTrace) {});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
