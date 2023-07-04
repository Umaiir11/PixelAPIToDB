import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_list/Routing/GetRoutes.dart';
import 'Routing/AppRoutes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: GetAppRoutes.Fnc_GetPages(),
      initialRoute: AppRoutes.initialRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

