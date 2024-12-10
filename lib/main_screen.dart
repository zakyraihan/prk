import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mysmk_prakerin/screen/absen_page.dart';
import 'package:mysmk_prakerin/screen/home.dart';
import 'package:mysmk_prakerin/screen/laporan_screen.dart';
import 'package:mysmk_prakerin/screen/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final pages = [
    const JurnalPKL(),
    const AbsenPage(),
    const LaporanWidget(),
    const ProfilePage(),
  ];

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  String statusCheck = 'Check your connectivity noew';
  Color statusColor = Colors.transparent;

  checkConnectivity() async {
    setState(() {
      statusCheck = 'Checking...';
    });

    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 10),
          content: Text('Connected to mobile network'),
        ),
      );
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(seconds: 10),
          content: Text('Connected to wifi network'),
        ),
      );
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 10),
          content: Text('No internet connection'),
        ),
      );
    }
  }

  late StreamSubscription<List<ConnectivityResult>> subscription;

  @override
  void initState() {
    subscription = Connectivity().onConnectivityChanged.listen((result) async {
      checkConnectivity();
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          changePage(value);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm_sharp), label: 'Absen'),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit_document), label: 'Laporan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
