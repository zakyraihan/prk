import 'package:flutter/material.dart';
import 'package:mysmk_prakerin/model/detail_laporanpkl_model.dart';
import 'package:mysmk_prakerin/service/laporanpkl_service.dart';

class DetailLaporanScreen extends StatefulWidget {
  const DetailLaporanScreen({super.key, required this.id});

  final String id;

  @override
  State<DetailLaporanScreen> createState() => _DetailLaporanScreenState();
}

class _DetailLaporanScreenState extends State<DetailLaporanScreen> {
  bool isFetching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Laporan Anda'),
      ),
      body: FutureBuilder(
        future: LaporanpklService().getLaporanDetailPkl(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Data detail = snapshot.data;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul Kegiatan
                  Image.network(
                    detail.foto,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.judulKegiatan,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Tanggal: ${detail.createdAt}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Isi Laporan
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Isi Laporan:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            detail.isiLaporan,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Status Kehadiran
                  ListTile(
                    leading: Icon(
                      detail.isAbsen ? Icons.check_circle : Icons.cancel,
                      color: detail.isAbsen ? Colors.green : Colors.red,
                      size: 30,
                    ),
                    title: Text(
                      'Status Kehadiran: ${detail.isAbsen ? "Hadir" : "Alpha"}',
                      style: TextStyle(
                        fontSize: 18,
                        color: detail.isAbsen ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Keterangan
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Keterangan Tambahan:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Tidak ada keterangan.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Laporan Diniyyah Harian:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: detail.laporanDiniyyahHarian.length,
                            itemBuilder: (context, index) {
                              final laporan =
                                  detail.laporanDiniyyahHarian[index];
                              return Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(
                                    'Tanggal: ${laporan.tanggal.toLocal().toString().split(' ')[0]}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Dzikir Pagi: ${laporan.dzikirPagi ? 'Ya' : 'Tidak'}'),
                                      Text(
                                          'Dzikir Petang: ${laporan.dzikirPetang ?? 'Tidak hadir'}'),
                                      Text(
                                          'Sholat Shubuh: ${laporan.sholatShubuh ?? 'Belum absen'}'),
                                      Text(
                                          'Sholat Dzuhur: ${laporan.sholatDzuhur ?? 'Belum absen'}'),
                                      Text(
                                          'Sholat Ashar: ${laporan.sholatAshar ?? 'Belum absen'}'),
                                      Text(
                                          'Sholat Magrib: ${laporan.sholatMagrib ?? 'Belum absen'}'),
                                      Text(
                                          'Sholat Isya: ${laporan.sholatIsya ?? 'Belum absen'}'),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else {
            return const Center(
              child: Text('tidak ada ada'),
            );
          }
        },
      ),
    );
  }
}
