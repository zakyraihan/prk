// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mysmk_prakerin/controller/location_controller.dart';
import 'package:mysmk_prakerin/provider/camera_provider.dart';
import 'package:mysmk_prakerin/router/router.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await initializeDateFormatting('id_ID', null);

  runApp(MyApp());

  await LocationController().getPermissionLocation();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CameraProvider(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
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
                      maxWidth:
                          isWideScreen ? mobileWidth : constraints.maxWidth,
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
      ),
    );
  }
}
