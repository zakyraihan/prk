import 'package:flutter/material.dart';
import 'package:mysmk_prakerin/screen/buat_jurnal_harian_pkl.dart';
import 'package:mysmk_prakerin/service/tugas_service.dart';

class JawabanScreen extends StatefulWidget {
  const JawabanScreen({super.key, required this.id});

  final String id;

  @override
  State<JawabanScreen> createState() => _JawabanScreenState();
}

class _JawabanScreenState extends State<JawabanScreen> {
  TextEditingController jawabanController = TextEditingController();
  TextEditingController jawabanControllerRevisi = TextEditingController();
  bool _isLoading = false;

  void createProses() async {
    setState(() {
      _isLoading = true;
    });
    await TugasService()
        .createJawaban(jawabanController.text, widget.id, context);

    setState(() {
      _isLoading = false;
    });
  }

  void revisiProses() async {
    setState(() {
      _isLoading = true;
    });
    await TugasService()
        .revisiJawaban(jawabanControllerRevisi.text, widget.id, context);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Jawaban dengan id ${widget.id}'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Kirim Jawaban'),
              Tab(text: 'Revisi Jawaban'),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TabBarView(
              children: [
                _createJawaban(lebar), // First tab view
                _revisiJawaban(lebar), // Second tab view
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createJawaban(double lebar) {
    return Column(
      children: [
        buildTextInput('Link Tugas', jawabanController, 'Link tugas'),
        const SizedBox(height: 10),
        InkWell(
          onTap: createProses,
          child: Container(
            alignment: Alignment.center,
            width: lebar,
            padding: const EdgeInsets.symmetric(vertical: 13),
            decoration: const BoxDecoration(color: Colors.green),
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Submit', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _revisiJawaban(double lebar) {
    return Column(
      children: [
        buildTextInput('Link Tugas', jawabanControllerRevisi, 'Link tugas'),
        const SizedBox(height: 10),
        InkWell(
          onTap: revisiProses,
          child: Container(
            alignment: Alignment.center,
            width: lebar,
            padding: const EdgeInsets.symmetric(vertical: 13),
            decoration: const BoxDecoration(color: Colors.green),
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Submit', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
