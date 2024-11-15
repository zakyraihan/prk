import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mysmk_prakerin/model/laporanpkl_model.dart';
import 'package:mysmk_prakerin/model/tugas_model.dart';
import 'package:mysmk_prakerin/router/router_name.dart';
import 'package:mysmk_prakerin/screen/detail_laporan_screen.dart';
import 'package:mysmk_prakerin/screen/jawaban_screen.dart';
import 'package:mysmk_prakerin/service/laporanpkl_service.dart';
import 'package:mysmk_prakerin/service/tugas_service.dart';
import 'package:mysmk_prakerin/widget/laporan_widget_card.dart';
import 'package:mysmk_prakerin/widget/tugas_widget_card.dart';

class JurnalPKL extends StatefulWidget {
  const JurnalPKL({super.key});

  @override
  State<JurnalPKL> createState() => _JurnalPKLState();
}

class _JurnalPKLState extends State<JurnalPKL> {
  List<DataLaporann> _originalData = [];
  List<DataTugas> _originalDataTugas = [];
  bool isFetching = false;

  Future _fetchData() async {
    setState(() {
      isFetching = true;
    });
    try {
      final data = await LaporanpklService().getLaporanPkl();
      setState(() {
        _originalData = data;
      });
    } catch (e) {
      log('$e');
    }
    setState(() {
      isFetching = false;
    });
  }

  Future _fetchDataTugas() async {
    setState(() {
      isFetching = true;
    });
    try {
      final data = await TugasService().getTugas();
      setState(() {
        _originalDataTugas = data;
      });
    } catch (e) {
      log('$e');
    }
    setState(() {
      isFetching = false;
    });
  }

  DateTime? selectedDate;

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: const Locale('en', 'GB'),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  String? selectedValue;

  @override
  void initState() {
    _fetchDataTugas();
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: filterWidget(context, () => selectDate()),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  height: 250,
                  width: lebar,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'images/Penerimaan-siswa-magang-SMKN-1-BANTUL-2-1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  width: lebar,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent, // Bagian atas transparan
                        Colors.black.withOpacity(0.7), // Bagian bawah gelap
                      ],
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '',
                      // 'Prakerin bukan hanya tentang bekerja, tetapi juga tentang menemukan minat dan potensi dirimu. Manfaatkan setiap momen untuk mengeksplorasi hal-hal baru.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customButton('Laporan PKL', Colors.green, () {}),
                  Builder(builder: (context) {
                    return InkWell(
                      onTap: () {
                        context.goNamed(Routes.laporanPkl);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              color: Colors.black87,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: const Text(
                            'Lihat Semua',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            // laporan pkl
            isFetching
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: _originalData.isNotEmpty
                        ? Wrap(
                            children: List.generate(
                              3,
                              (index) => buildLaporanCard(
                                _originalData[index],
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailLaporanScreen(
                                        id: _originalData[index].id.toString()),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const Text('tidak ada data')),
            const Divider(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // padding: const EdgeInsets.symmetric(
                          // horizontal: 20, vertical: 10),
                          // decoration: const BoxDecoration(
                          //   color: Colors.green,
                          //   borderRadius: BorderRadius.all(
                          //     Radius.circular(5),
                          //   ),
                          // ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tugas PKL',
                                // maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Pak Nurdiansyah',
                          // maxLines: 2,
                          style: TextStyle(color: Colors.grey, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      return InkWell(
                        onTap: () {
                          context.goNamed(Routes.tugas);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                color: Colors.black87,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: const Text(
                              'Lihat Semua',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // tugas section
            isFetching
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: _originalDataTugas.isNotEmpty
                        ? Wrap(
                            children: List.generate(
                              _originalDataTugas.length,
                              (index) {
                                final tugas = _originalDataTugas[index];
                                return TugasWidgetCard(
                                    tugas: tugas,
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => JawabanScreen(
                                          id: tugas.id.toString(),
                                        ),
                                      ));
                                    });
                              },
                            ),
                          )
                        : const Text('tidak ada data')),
          ],
        ),
      ),
    );
  }

  Widget _customButton(String text, Color color, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget filterWidget(context, Function() onTap) {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 40, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _filterSection('Dari Tanggal', onTap),
                const SizedBox(height: 20),
                _filterSection('Sampai Tanggal', onTap),
                const SizedBox(height: 20),
                const Text(
                  'Status Kehadiran',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  hint: const Text('Pilih Status'),
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  },
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: Colors.green,
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                ),
                const SizedBox(height: 20),
                _customButton('Apply Filters', Colors.blue, () {}),
                const SizedBox(height: 10),
                _customButton('Clear Filters', Colors.red, () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _filterSection(String label, Function() onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'DD/MM/yy',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ),
      ],
    );
  }
}
