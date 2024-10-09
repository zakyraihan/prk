import 'package:flutter/material.dart';

class LaporanDiniyyahHarian extends StatefulWidget {
  const LaporanDiniyyahHarian({super.key});

  @override
  State<LaporanDiniyyahHarian> createState() => _LaporanDiniyyahHarianState();
}

class _LaporanDiniyyahHarianState extends State<LaporanDiniyyahHarian> {
  String? selectedSurat;
  String? selectedAyat;
  String? selectedSholat;
  final List<String> suratList = ['Al-Fatihah', 'Al-Baqarah', 'Ali Imran'];
  final List<String> ayatList = ['1', '2', '3', '4', '5'];
  final List<String> sholatList = [
    'Keterangan 1',
    'Keterangan 2',
    'Keterangan 3'
  ];

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Diniyyah Harian'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdownField('Dari Surat', suratList, selectedSurat,
                  (value) {
                setState(() {
                  selectedSurat = value;
                });
              }),
              _buildDropdownField('Sampai Surat', suratList, selectedSurat,
                  (value) {
                setState(() {
                  selectedSurat = value;
                });
              }),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dari Ayat'),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sampai Ayat'),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 50,
              ),
              _buildDropdownField('Sholat Shubuh', sholatList, selectedSholat,
                  (value) {
                setState(() {
                  selectedSholat = value;
                });
              }),
              _buildDropdownField('Sholat Dzuhur', sholatList, selectedSholat,
                  (value) {
                setState(() {
                  selectedSholat = value;
                });
              }),
              _buildDropdownField('Sholat Ashar', sholatList, selectedSholat,
                  (value) {
                setState(() {
                  selectedSholat = value;
                });
              }),
              _buildDropdownField('Sholat Magrib', sholatList, selectedSholat,
                  (value) {
                setState(() {
                  selectedSholat = value;
                });
              }),
              _buildDropdownField('Sholat Isya', sholatList, selectedSholat,
                  (value) {
                setState(() {
                  selectedSholat = value;
                });
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (bool? value) {
                          // Action for Dzikr Pagi checkbox
                        },
                      ),
                      const Text('Dzikir Pagi'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (bool? value) {
                          // Action for Dzikr Petang checkbox
                        },
                      ),
                      const Text('Dzikir Petang'),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                width: lebar,
                padding: const EdgeInsets.symmetric(vertical: 13),
                decoration: const BoxDecoration(color: Colors.green),
                child:
                    const Text('Submit', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items,
      String? selectedValue, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 5),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            value: selectedValue,
            onChanged: onChanged,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
