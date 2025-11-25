import 'package:flutter/material.dart';
import 'list_sampah.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  final List<String> listKategori = [
    "Sampah Basah",
    "Sampah Kering",
    "Botol",
    "Sachet",
    "Tisu",
  ];

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 180, 209),
        title: const Text("Input Data Sampah"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A001F), Color(0xFF800020)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTextField(nisController, "NIS"),
                    const SizedBox(height: 15),
                    _buildTextField(kelasController, "Kelas"),
                    const SizedBox(height: 15),
                    _buildTextField(namaController, "Nama"),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value: kategoriSampah,
                      decoration: InputDecoration(
                        labelText: "Kategori Sampah",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: listKategori.map((kategori) {
                        return DropdownMenuItem(
                          value: kategori,
                          child: Text(kategori),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          kategoriSampah = value;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(namaSampahController, "Nama Sampah"),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () async {
                        var url = Uri.parse(
                          "http://192.168.92.146/api_sampah/insert_sampah.php",
                        );
                        var response = await http.post(
                          url,
                          body: {
                            "nis": nisController.text,
                            "kelas": kelasController.text,
                            "nama": namaController.text,
                            "kategori": kategoriSampah!,
                            "nama_sampah": namaSampahController.text,
                          },
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListSampahPage(),
                          ),
                        );
                      },
                      child: const Text("Simpan"),
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

  // VALIDASI
  bool _validasiInput() {
    if (nisController.text.isEmpty ||
        kelasController.text.isEmpty ||
        namaController.text.isEmpty ||
        kategoriSampah == null ||
        namaSampahController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua input harus diisi!"),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  // SIMPAN DATABASE
  Future<void> simpanData() async {
    if (!_validasiInput()) return;

    setState(() => loading = true);

    var url = Uri.parse("http://192.168.92.146/api_sampah/insert_sampah.php");
    var response = await http.post(
      url,
      body: {
        "nis": nisController.text,
        "kelas": kelasController.text,
        "nama": namaController.text,
        "kategori": kategoriSampah.toString(),
        "nama_sampah": namaSampahController.text,
      },
    );

    setState(() => loading = false);

    var data = json.decode(response.body);

    if (data["status"] == "success") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Data Berhasil Disimpan!"),
          backgroundColor: Colors.green,
        ),
      );
      _clearFields();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Gagal Simpan Data!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _clearFields() {
    nisController.clear();
    kelasController.clear();
    namaController.clear();
    namaSampahController.clear();
    kategoriSampah = null;
    setState(() {});
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
