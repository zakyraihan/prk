import 'package:flutter/material.dart';
import 'package:mysmk_prakerin/screen/buat_jurnal_harian_pkl.dart';
import 'package:mysmk_prakerin/screen/laporan_diniyah_harian.dart';

class LaporanWidget extends StatefulWidget {
  const LaporanWidget({super.key});

  @override
  State<LaporanWidget> createState() => _LaporanWidgetState();
}

class _LaporanWidgetState extends State<LaporanWidget> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LAPORAN'),
      ),
      endDrawer: filterWidget(context, () => selectDate()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            _customButton('+', Colors.blue, () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  content: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.9,
                                    height:
                                        MediaQuery.of(context).size.height *
                                            0.8,
                                    child: const BuatJurnalHarianPkl(),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text("Laporan PKL"),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.9, // Adjust width
                                    child:
                                        const LaporanDiniyyahHarian(), // Insert the form widget here
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text("Laporan Diniyah"),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
            Wrap(
              children: List.generate(
                10,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        leading: Container(
                          height: 120,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        title: const Text(
                          'Membaca Alquran',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: const Text(
                          '28 Agustus 2024',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
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
