import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysmk_prakerin/model/profile_model.dart';
import 'package:mysmk_prakerin/router/router_name.dart';
import 'package:mysmk_prakerin/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  Siswa? _dataProfile;
  bool _isLoading = true;

  Future fetchProfileData() async {
    try {
      final profile = await AuthService().getProfile();
      setState(() {
        _dataProfile = profile;
        _isLoading = false;
      });
    } catch (e) {
      log('$e');
      _isLoading = false;
    }
  }

  @override
  void initState() {
    fetchProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double coverHeight = 200;
    const double profileHeight = 100;
    const double top = coverHeight - profileHeight / 2;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.white,
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: profileHeight / 2),
                      color: Colors.green,
                      height: coverHeight,
                    ),
                    const Positioned(
                      top: top,
                      child: CircleAvatar(
                        radius: profileHeight / 2,
                        backgroundColor: Colors.white,
                        // backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Center(
                  child: Column(
                    children: [
                      _dataProfile!.status == 'active'
                          ? Container(
                              decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              child: Text(_dataProfile!.status,
                                  style: const TextStyle(color: Colors.white)),
                            )
                          : Container(),
                      const SizedBox(height: 10),
                      Text(
                        _dataProfile!.namaSiswa,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'NIS ${_dataProfile!.nis}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person, color: Colors.black),
                        title: const Text('Detail Profile'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          dialogDetailProfile(context);
                        },
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.settings, color: Colors.green),
                        title: const Text('Settings'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Navigate to Settings
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.lock, color: Colors.green),
                        title: const Text('Change Password'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          _showChangePasswordDialog(context);
                        },
                      ),
                      ListTile(
                          leading: const Icon(Icons.logout, color: Colors.red),
                          title: const Text('Logout'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            await preferences.clear();

                            context.goNamed(Routes.login);
                          }),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future<dynamic> dialogDetailProfile(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('NAMA: ${_dataProfile!.namaSiswa}'),
                  Text('NIS: ${_dataProfile!.nis}'),
                  Text('NISN: ${_dataProfile!.nisn}'),
                  Text('TEMPAT LAHIR: ${_dataProfile!.tempatLahir}'),
                  Text('TANGGAL LAHIR: ${_dataProfile!.tanggalLahir}'),
                  Text('ALAMAT: ${_dataProfile!.alamat}'),
                  Text('SEKOLAH ASAL: ${_dataProfile!.sekolahAsal}'),
                  Text('JENIS KELAMIN: ${_dataProfile!.jenisKelamin}'),
                  Text('TANGGAL DITERIMA: ${_dataProfile!.tanggalDiterima}'),
                  Text(
                      'ANGKATAN: ${_dataProfile!.angkatan} / ${_dataProfile!.tahunAjaran}'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Old Password',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New Password',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _changePassword();
                Navigator.of(context)
                    .pop(); // Close the dialog after submission
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  // Handle the password change logic here
  void _changePassword() {
    String oldPassword = oldPasswordController.text;
    String newPassword = newPasswordController.text;

    // Perform password change logic (e.g., API call)
    print('Old Password: $oldPassword');
    print('New Password: $newPassword');

    // Clear the text fields after submission
    oldPasswordController.clear();
    newPasswordController.clear();
  }
}
