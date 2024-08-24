import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_flutter/presentation/viewmodels/theme_notifier.dart';

class ProfilPage extends ConsumerWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tSwitchProvider = ref.watch(themeSchitchProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profil Page",style: TextStyle(fontSize: 20),),
      ),
      body: Center(
        child: Switch(
          value: tSwitchProvider,
          onChanged: (value) {
            // Update the switch state
            ref.read(themeSchitchProvider.notifier).state = value;
          },
        ),
      ),
    );
  }
}
