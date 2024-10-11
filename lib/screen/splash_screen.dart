// ignore_for_file: use_key_in_widget_constructors, annotate_overrides, prefer_const_constructors, duplicate_ignore, unused_import, unused_local_variable

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysmk_prakerin/model/login_model.dart';
import 'package:mysmk_prakerin/router/router_name.dart';
import 'package:mysmk_prakerin/service/auth_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:permission_handler/permission_handler.dart';

class SplashScreenView extends StatefulWidget {
  static const routeName = '/SplashScreen';
  @override
  _SplashScreenView createState() => _SplashScreenView();
}

class _SplashScreenView extends State<SplashScreenView> {
  bool status = true;

  startSplashScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? tgl = preferences.getString('tanggalLogin');
    if (tgl != "" && tgl != null) {
      DateTime tanggal = DateTime.parse(tgl);
      DateTime tglskrg = DateTime.now();
      DateTime tglExp = DateTime(tanggal.year, tanggal.month, tanggal.day + 6);
      bool cekTanggal = tglskrg.isBefore(tglExp);
      if (!cekTanggal) {
        await AuthService().authMe(context: context).then((value) {
          if (!value) {
            gagalAuth();
          } else {
            setState(() {
              status = true;
            });
          }
        });
      }
    }

    String? dataLogin = preferences.getString('login');
    var duration = const Duration(seconds: 3);

    if (dataLogin == "" || dataLogin == null) {
      return Timer(duration, () {
        if (status) {
          context.goNamed(Routes.login);
        }
      });
    } else {
      LoginModel data = loginModelFromJson(dataLogin);
      return Timer(duration, () {
        if (status) {
          context.goNamed(Routes.main, extra: data);
        }
      });
    }
  }

  void gagalAuth() {
    setState(() {
      status = false;
    });
    Alert(
        context: context,
        title: "Pengambilan Data Gagal",
        desc: "Harap nyalakan paket data / restart aplikasinya",
        type: AlertType.error,
        buttons: [
          DialogButton(
              color: Colors.red,
              child: Text("OK",
                  style: TextStyle(color: Colors.white, fontSize: 26)),
              onPressed: () {
                int count = 0;
                context.pop();
                context.goNamed(Routes.login);
              })
        ]).show();
  }

  void initState() {
    super.initState();
    startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "images/logoMysmk.png",
              width: 300,
            ),
            SizedBox(height: 24.0),
            Text(
              "PRAKERIN",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
