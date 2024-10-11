import 'package:flutter/material.dart';

class Laporan {
  final String title;
  final String description;
  final String date;

  Laporan({
    required this.title,
    required this.description,
    required this.date,
  });
}

class Tugas {
  final String namaTugas;
  final String namaGuru;
  final String tanggal;

  Tugas({
    required this.namaTugas,
    required this.namaGuru,
    required this.tanggal,
  });
}

class JurnalPKL extends StatefulWidget {
  const JurnalPKL({super.key});

  @override
  State<JurnalPKL> createState() => _JurnalPKLState();
}

class _JurnalPKLState extends State<JurnalPKL> {
  final List<Laporan> laporanList = [
    Laporan(
      title: 'Membaca Alquran',
      description: 'Membaca Alquran Juz 1',
      date: '28 Agustus 2024',
    ),
    Laporan(
      title: 'Mengerjakan Tugas Matematika',
      description: 'Tugas Aljabar',
      date: '29 Agustus 2024',
    ),
    Laporan(
      title: 'Menghafal Hadis',
      description: 'Menghafal Hadis tentang Puasa',
      date: '30 Agustus 2024',
    ),
  ];

  // Contoh daftar tugas
  final List<Tugas> tugasList = [
    Tugas(
      namaTugas: 'Membuat Laporan PKL',
      namaGuru: 'Pak Nurdiansyah',
      tanggal: '27 Agustus 2024',
    ),
    Tugas(
      namaTugas: 'Menyiapkan Presentasi',
      namaGuru: 'Bu Ani',
      tanggal: '28 Agustus 2024',
    ),
    Tugas(
      namaTugas: 'Kerja Kelompok Proyek',
      namaGuru: 'Pak Fajar',
      tanggal: '29 Agustus 2024',
    ),
  ];

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
                      'Prakerin bukan hanya tentang bekerja, tetapi juga tentang menemukan minat dan potensi dirimu. Manfaatkan setiap momen untuk mengeksplorasi hal-hal baru.',
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
                        // Get.to(() => const LaporanWidget());
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: List.generate(
                  laporanList.length,
                  (index) {
                    final laporan = laporanList[index];
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
                          title: Text(
                            laporan.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            laporan.date,
                            style: const TextStyle(
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
            ),
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
                          // Scaffold.of(context).openEndDrawer()
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: List.generate(
                  tugasList.length,
                  (index) {
                    final tugas = tugasList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          title: Text(
                            tugas.namaTugas,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tugas.namaGuru,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                tugas.tanggal,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
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
