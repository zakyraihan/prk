import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysmk_prakerin/model/tugas_model.dart';
import 'package:mysmk_prakerin/service/tugas_service.dart';
import 'package:mysmk_prakerin/widget/tugas_widget_card.dart';

class TugasScreen extends StatefulWidget {
  const TugasScreen({super.key});

  @override
  State<TugasScreen> createState() => _TugasScreenState();
}

class _TugasScreenState extends State<TugasScreen> {
  List<DataTugas> _originalData = [];
  List<DataTugas> _filterData = [];
  bool isFetching = false;
  bool isFetchingMore = false;
  final int batchSize = 5;
  int currentIndex = 0;

  final TextEditingController _searchController = TextEditingController();

  Future _fetchData({bool isInitialLoad = false}) async {
    if (isInitialLoad) {
      setState(() {
        isFetching = true;
      });
    } else {
      setState(() {
        isFetchingMore = true;
      });
    }
    try {
      final data = await TugasService().getTugas();
      setState(() {
        if (isInitialLoad) {
          _originalData = data;
          _filterData = data.take(batchSize).toList();
          currentIndex = _filterData.length;
        } else {
          final nextBatch = data.skip(currentIndex).take(batchSize).toList();
          _filterData.addAll(nextBatch);
          currentIndex += int.parse(nextBatch.length);
        }
      });
    } catch (e) {
      log('$e');
    }
    setState(() {
      isFetching = false;
      isFetchingMore = false;
    });
  }

  void _filteredData(String query) {
    final results = _originalData.where((items) {
      final title = items.tugas.toLowerCase() ?? '';
      final date = items.createdAt != null
          ? DateFormat('dd MMM yyyy').format(items.createdAt)
          : '';

      return title.contains(query.toLowerCase()) ||
          date.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filterData = results.take(batchSize).toList();
      currentIndex = _filterData.length;
    });
  }

  @override
  void initState() {
    _fetchData(isInitialLoad: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TUGAS ANDA'),
      ),
      body: SafeArea(
        child: isFetching
            ? const Center(child: CircularProgressIndicator())
            : NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (!isFetchingMore &&
                      scrollNotification.metrics.pixels ==
                          scrollNotification.metrics.maxScrollExtent) {
                    _fetchData();
                  }
                  return false;
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSearchBar(),
                        _buildDataList(),
                        if (isFetchingMore)
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
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
                      borderSide: BorderSide(color: Colors.grey)),
                  border: OutlineInputBorder(),
                  hintText: 'Cari judul | Tanggal',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataList() {
    return _filterData.isNotEmpty
        ? Wrap(
            children: List.generate(
              _filterData.length,
              (index) {
                final tugas = _filterData[index];
                return TugasWidgetCard(tugas: tugas);
              },
            ),
          )
        : const Text('data tidak ditemukan');
  }
}
