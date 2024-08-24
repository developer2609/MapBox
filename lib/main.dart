import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_flutter/presentation/pages/explore_page/Explore_page.dart';
import 'package:task_flutter/presentation/pages/profil_page/Profil_page.dart';
import 'package:task_flutter/presentation/viewmodels/theme_notifier.dart';

import 'data/models/theme_model.dart';

 void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final themeMode=ref.watch(themeModeProvider.notifier);
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode.state,
      home: ExplorePage(),
    );
  }
}
