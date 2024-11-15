import 'package:flutter/material.dart';
import 'package:mysmk_prakerin/model/tugas_model.dart';
import 'package:mysmk_prakerin/utils/formated_date.dart';
import 'package:url_launcher/url_launcher.dart';

class TugasWidgetCard extends StatelessWidget {
  const TugasWidgetCard({
    super.key,
    required this.tugas,
    this.onTap,
  });

  final void Function()? onTap;
  final DataTugas tugas;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');

    }
  }

  @override
  Widget build(BuildContext context) {
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
            title: Text(
              tugas.tugas,
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
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _launchUrl(tugas.linkSoal),
                  child: Text(
                    tugas.linkSoal,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  tugas.deskripsiTugas,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  formattedDate(tugas.createdAt),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
