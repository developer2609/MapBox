


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedprefProvider=FutureProvider<SharedPreferences>((ref){
  return SharedPreferences.getInstance();
});

final themeSchitchProvider=StateProvider<bool>((ref){
  final sharedPraferences=ref.watch(sharedprefProvider);
  final theme=sharedPraferences.value?.getString("themeMode");
  return theme=="dark" ? true :false;
});

final themeModeProvider=StateProvider<ThemeMode>((ref){
  final sharedPraferences=ref.watch(sharedprefProvider);
  final themeSwitch=ref.watch(themeSchitchProvider);
    if(themeSwitch){
      sharedPraferences.value?.setString("themeMode", "dark");
    }else{
      sharedPraferences.value?.setString("themeMode", "light");

    }

     final theme=sharedPraferences.value?.getString("themeMode");

    return  theme == "dark"? ThemeMode.dark :ThemeMode.light;



});
