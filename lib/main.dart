// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mysmk_prakerin/provider/camera_provider.dart';
import 'package:mysmk_prakerin/router/router.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  await initializeDateFormatting('id_ID', null);
  runApp(MyApp());

  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CameraProvider(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        builder: (context, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isWideScreen = constraints.maxWidth > 600;
              const mobileWidth = 650.0;

              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isWideScreen ? mobileWidth : constraints.maxWidth,
                    maxHeight: constraints.maxHeight, // Keep the full height
                  ),
                  child: Container(
                    alignment: Alignment.topCenter, // Align content properly
                    child: child,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
