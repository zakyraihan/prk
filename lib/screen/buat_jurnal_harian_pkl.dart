import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysmk_prakerin/model/create_laporan_model.dart';
import 'package:mysmk_prakerin/service/laporanpkl_service.dart';

class BuatJurnalHarianPkl extends StatefulWidget {
  const BuatJurnalHarianPkl({super.key});

  @override
  State<BuatJurnalHarianPkl> createState() => _BuatJurnalHarianPklState();
}

class _BuatJurnalHarianPklState extends State<BuatJurnalHarianPkl>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController judulController = TextEditingController();
  final TextEditingController isiController = TextEditingController();

  bool _isLoading = false;

  void createProses() async {
    setState(() {
      _isLoading = true;
    });

    if (_formKey.currentState?.validate() ?? false) {
      DataCreateLaporan laporan = DataCreateLaporan(
        judulKegiatan: judulController.text,
        isiLaporan: isiController.text,
        foto: _imageFile,
        longtitude: 8090,
        latitude: 8090,
        status: 'hadir',
        tanggal: _selectedDate,
      );

      await LaporanpklService().createLaporan(context, laporan);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _selectedDate = DateTime.now();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    judulController.dispose();
    isiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Jurnal Harian PKL'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.green,
          tabs: const [
            Tab(text: 'Hadir'),
            Tab(text: 'Izin'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFormPKL(context, lebar),
          _buildFormIzin(context, lebar),
        ],
      ),
    );
  }

  Widget _buildFormPKL(BuildContext context, lebar) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInput(
                'Judul Jurnal Harian',
                judulController,
                'Masukkan judul jurnal',
              ),
              const SizedBox(height: 16),
              _buildDatePicker(context),
              const SizedBox(height: 16),
              _buildImagePicker(),
              const SizedBox(height: 16),
              _buildTextArea('Deskripsi Jurnal Harian', isiController,
                  'Apa yang antum kerjakan hari ini?'),
              const SizedBox(height: 20),
              InkWell(
                onTap: createProses,
                child: Container(
                  alignment: Alignment.center,
                  width: lebar,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: const BoxDecoration(color: Colors.green),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Submit',
                          style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormIzin(BuildContext context, lebar) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextInput(
                  'Alasan Izin', isiController, 'Masukkan Alasan izin'),
              const SizedBox(height: 16),
              _buildDatePicker(context),
              const SizedBox(height: 16),
              _buildImagePicker(),
              const SizedBox(height: 16),
              _buildTextArea(
                  'Deskripsi Izin', judulController, 'Deskripsi izin?'),
              const SizedBox(height: 20),
              InkWell(
                onTap: createProses, // Call createProses on submit
                child: Container(
                  alignment: Alignment.center,
                  width: lebar,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: const BoxDecoration(color: Colors.green),
                  child: const Text('Submit',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput(
      String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field tidak boleh kosong';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tanggal'),
        const SizedBox(height: 5),
        InkWell(
          onTap: () => _selectDate(context),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            ),
            child: Text(
              _selectedDate == null
                  ? 'Pilih Tanggal'
                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              style: TextStyle(
                  color: _selectedDate == null ? Colors.grey : Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Bukti'),
        const SizedBox(height: 5),
        InkWell(
          onTap: _pickImage,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                _imageFile == null
                    ? const Text('Pilih Gambar')
                    : Image.file(
                        _imageFile!,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextArea(
      String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field tidak boleh kosong';
            }
            return null;
          },
        ),
      ],
    );
  }
}
