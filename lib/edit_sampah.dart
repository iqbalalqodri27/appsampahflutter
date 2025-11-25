import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditSampahPage extends StatefulWidget {
  final Map data;
  const EditSampahPage({required this.data, super.key});

  @override
  State<EditSampahPage> createState() => _EditSampahPageState();
}

class _EditSampahPageState extends State<EditSampahPage> {
  late TextEditingController nis;
  late TextEditingController kelas;
  late TextEditingController nama;
  late TextEditingController kategori;
  late TextEditingController namaSampah;

  @override
  void initState() {
    nis = TextEditingController(text: widget.data['nis']);
    kelas = TextEditingController(text: widget.data['kelas']);
    nama = TextEditingController(text: widget.data['nama']);
    kategori = TextEditingController(text: widget.data['kategori']);
    namaSampah = TextEditingController(text: widget.data['nama_sampah']);
    super.initState();
  }

  Future updateData() async {
    var url = Uri.parse("http://192.168.92.146/api_sampah/edit.php");
    await http.post(
      url,
      body: {
        "id": widget.data['id'],
        "nis": nis.text,
        "kelas": kelas.text,
        "nama": nama.text,
        "kategori": kategori.text,
        "nama_sampah": namaSampah.text,
      },
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Sampah")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nis,
              decoration: const InputDecoration(labelText: "NIS"),
            ),
            TextField(
              controller: kelas,
              decoration: const InputDecoration(labelText: "Kelas"),
            ),
            TextField(
              controller: nama,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: kategori,
              decoration: const InputDecoration(labelText: "Kategori"),
            ),
            TextField(
              controller: namaSampah,
              decoration: const InputDecoration(labelText: "Nama Sampah"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: updateData, child: const Text("Update")),
          ],
        ),
      ),
    );
  }
}
