import 'package:flutter/material.dart';
import 'package:mysmk_prakerin/screen/absen_page.dart';
import 'package:mysmk_prakerin/screen/home.dart';
import 'package:mysmk_prakerin/screen/profile_page.dart';
import 'package:mysmk_prakerin/screen/laporan_screen.dart';

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
