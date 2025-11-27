import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InputSampahPage extends StatefulWidget {
  const InputSampahPage({super.key});
  @override
  State<InputSampahPage> createState() => _InputSampahPageState();
}

class _InputSampahPageState extends State<InputSampahPage> {
  final nisController = TextEditingController();
  final kelasController = TextEditingController();
  final namaController = TextEditingController();
  final namaSampahController = TextEditingController();
  String? kategoriSampah;
  bool loading = false;

  final List<String> listKategori = [
    "Sampah Makanan",
    "Sampah Taman",
    "Kayu",
    "Kertas Karton dan Kardus",
    "Plastik - Lembaran",
    "Plastik - Kerasan",
    "Logam",
    "Kain dan Produk Tekstil",
    "Karet dan Kulit",
    "Kaca",
    "Sampah B3",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data Sampah'),
        backgroundColor: const Color(0xFF800020),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () => Navigator.pushNamed(context, '/list'),
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Navigator.pushNamed(context, '/dashboard'),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B62FF), Color(0xFF800020)],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField(nisController, 'NIS'),
                    const SizedBox(height: 12),
                    _buildTextField(kelasController, 'Kelas'),
                    const SizedBox(height: 12),
                    _buildTextField(namaController, 'Nama'),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: kategoriSampah,
                      decoration: const InputDecoration(
                        labelText: 'Kategori Sampah',
                        border: OutlineInputBorder(),
                      ),
                      items: listKategori
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => kategoriSampah = v),
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(namaSampahController, 'Nama Sampah'),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: loading ? null : _simpan,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF800020),
                        ),
                        child: loading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Simpan'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController c, String label) {
    return TextField(
      controller: c,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Future<void> _simpan() async {
    if (nisController.text.isEmpty ||
        kelasController.text.isEmpty ||
        namaController.text.isEmpty ||
        kategoriSampah == null ||
        namaSampahController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua field harus diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => loading = true);
    try {
      await FirebaseFirestore.instance.collection('sampah').add({
        'nis': nisController.text.trim(),
        'kelas': kelasController.text.trim(),
        'nama': namaController.text.trim(),
        'kategori': kategoriSampah,
        'nama_sampah': namaSampahController.text.trim(),
        'created_at': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data tersimpan'),
          backgroundColor: Colors.green,
        ),
      );

      nisController.clear();
      kelasController.clear();
      namaController.clear();
      namaSampahController.clear();
      setState(() => kategoriSampah = null);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal simpan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => loading = false);
    }
  }
}
