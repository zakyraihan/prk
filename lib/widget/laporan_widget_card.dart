import 'package:flutter/material.dart';
import 'package:mysmk_prakerin/model/laporanpkl_model.dart';
import 'package:mysmk_prakerin/utils/formated_date.dart';

Widget buildLaporanCard(DataLaporann data, {void Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),
          // leading: SizedBox(
          //     width: 50,
          //     height: 50,
          //     child: Image.network(
          //       data.foto.toString(),
          //       fit: BoxFit.cover,
          //       errorBuilder: (context, error, stackTrace) {
          //         return const Icon(
          //           Icons.broken_image,
          //           size: 50,
          //           color: Colors.grey,
          //         );
          //       },
          //       loadingBuilder: (context, child, loadingProgress) {
          //         if (loadingProgress == null) return child;
          //         return Center(
          //           child: CircularProgressIndicator(
          //             value: loadingProgress.expectedTotalBytes != null
          //                 ? loadingProgress.cumulativeBytesLoaded /
          //                     loadingProgress.expectedTotalBytes!
          //                 : null,
          //           ),
          //         );
          //       },
          //     )),
          title: Text(
            data.judulKegiatan ?? 'No Title',
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
              const SizedBox(height: 5),
              Text(
                data.isiLaporan ?? 'No Content',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 7),
              Text(
                formattedDate(data.createdAt),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  StatusBadge(isAbsen: data.isAbsen),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class StatusBadge extends StatelessWidget {
  final bool isAbsen;

  const StatusBadge({super.key, required this.isAbsen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: isAbsen ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isAbsen ? 'HADIR' : 'ALPHA',
        style: const TextStyle(
          fontSize: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
