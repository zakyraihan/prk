import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mysmk_prakerin/model/laporanpkl_model.dart';
import 'package:mysmk_prakerin/router/router_name.dart';
import 'package:mysmk_prakerin/screen/detail_laporan_screen.dart';
import 'package:mysmk_prakerin/service/laporanpkl_service.dart';
import 'package:mysmk_prakerin/widget/laporan_widget_card.dart';

class LaporanWidget extends StatefulWidget {
  const LaporanWidget({super.key});

  @override
  State<LaporanWidget> createState() => _LaporanWidgetState();
}

class _LaporanWidgetState extends State<LaporanWidget> {
  List<DataLaporann> _originalData = [];
  List<DataLaporann> _filterData = [];
  bool isFetching = false;


  final TextEditingController _searchController = TextEditingController();

  Future _fetchData() async {
    setState(() {
      isFetching = true;
    });
    try {
      final data = await LaporanpklService().getLaporanPkl();
      setState(() {
        _originalData = data;
        _filterData = data;
      });
    } catch (e) {
      log('$e');
    }
    setState(() {
      isFetching = false;
    });
  }

  void _filteredData(String query) {
    final results = _originalData.where((items) {
      final title = items.judulKegiatan?.toLowerCase() ?? '';

      final date = items.createdAt != null
          ? DateFormat('dd MMM yyyy').format(items.createdAt!)
          : '';

      return title.contains(query.toLowerCase()) ||
          date.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filterData = results;
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
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // get();
    return Scaffold(
      appBar: AppBar(
        title: const Text('LAPORAN'),
      ),
      endDrawer: filterWidget(context, () => selectDate()),
      body: isFetching
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  _filteredData(value);
                                },
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  border: OutlineInputBorder(),
                                  hintText: 'Cari judul | Tanggal',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 12),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                context.goNamed(Routes.buatJurnalPkl),
                            icon: const Icon(Icons.note_add_outlined, size: 35),
                          )
                        ],
                      ),
                    ),
                    _filterData.isNotEmpty
                        ? Wrap(
                            children: List.generate(
                              _filterData.length,
                              (index) => buildLaporanCard(_filterData[index],
                                  onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            DetailLaporanScreen(
                                                id: _filterData[index]
                                                    .id
                                                    .toString()),
                                      ))),
                            ),
                          )
                        : const Text('data tidak ditemukan')
                  ],
                ),
              ),
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _customButton('+', Colors.blue, () {
      //       showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //             content: SingleChildScrollView(
      //               scrollDirection: Axis.horizontal,
      //               child: Row(
      //                 children: [
      //                   ElevatedButton(
      //                     onPressed: () {
      //                       // showDialog(
      //                       //   context: context,
      //                       //   builder: (BuildContext context) {
      //                       //     return AlertDialog(
      //                       //       contentPadding: EdgeInsets.zero,
      //                       //       content: SizedBox(
      //                       //         width:
      //                       //             MediaQuery.of(context).size.width * 0.9,
      //                       //         height: MediaQuery.of(context).size.height *
      //                       //             0.8,
      //                       //         child: const BuatJurnalHarianPkl(),
      //                       //       ),
      //                       //     );
      //                       //   },
      //                       // );
      //                       context.goNamed(Routes.buatJurnalPkl);
      //                     },
      //                     child: const Text("Laporan PKL"),
      //                   ),
      //                   const SizedBox(width: 10),
      //                   ElevatedButton(
      //                     onPressed: () {
      //                       showDialog(
      //                         context: context,
      //                         builder: (BuildContext context) {
      //                           return AlertDialog(
      //                             content: SizedBox(
      //                               width: MediaQuery.of(context).size.width *
      //                                   0.9, // Adjust width
      //                               // child:
      //                               //     const LaporanDiniyyahHarian(), // Insert the form widget here
      //                             ),
      //                           );
      //                         },
      //                       );
      //                     },
      //                     child: const Text("Laporan Diniyah"),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           );
      //         },
      //       );
      //     });
      //   },
      // ),
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
}
