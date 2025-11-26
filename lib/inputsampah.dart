import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class InputSampahPage extends StatefulWidget {
  const InputSampahPage({super.key});

  @override
  State<InputSampahPage> createState() => _InputSampahPageState();
}

class _InputSampahPageState extends State<InputSampahPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _jamController = TextEditingController();
  String? _selectedJenisSampah;
  Uint8List? _pickedImageBytes;
  String? _pickedImageName;

  final List<String> jenisSampahList = [
    "Plastik",
    "Kertas",
    "Kantong Kresek",
    "Sachet",
    "Sisa Makanan",
    "Karton",
    "Kaleng Minuman",
    "Styrofoam",
  ];

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _pickedImageBytes = result.files.single.bytes;
        _pickedImageName = result.files.single.name;
      });
    }
  }

  Future<void> saveData() async {
    if (!_formKey.currentState!.validate()) return;

    String? imageUrl;

    if (_pickedImageBytes != null && _pickedImageName != null) {
      final storageRef = FirebaseStorage.instance.ref(
        "sampah_images/${DateTime.now().millisecondsSinceEpoch}_$_pickedImageName",
      );

      await storageRef.putData(_pickedImageBytes!);
      imageUrl = await storageRef.getDownloadURL();
    }

    await FirebaseFirestore.instance.collection("input_sampah").add({
      "jam": _jamController.text,
      "jenis_sampah": _selectedJenisSampah,
      "url_gambar": imageUrl,
      "tanggal_input": Timestamp.now(),
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Data berhasil disimpan!")));

    _jamController.clear();
    setState(() {
      _selectedJenisSampah = null;
      _pickedImageBytes = null;
      _pickedImageName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Input Sampah")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _jamController,
                decoration: const InputDecoration(
                  labelText: "Jam",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Jam tidak boleh kosong" : null,
              ),
              const SizedBox(height: 14),

              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Jenis Sampah",
                  border: OutlineInputBorder(),
                ),
                initialValue: _selectedJenisSampah,
                items: jenisSampahList.map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedJenisSampah = value;
                  });
                },
                validator: (value) =>
                    value == null ? "Pilih jenis sampah" : null,
              ),
              const SizedBox(height: 14),

              if (_pickedImageBytes != null)
                Image.memory(_pickedImageBytes!, height: 150),

              const SizedBox(height: 14),

              ElevatedButton(
                onPressed: pickImage,
                child: const Text("Pilih Gambar"),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: saveData,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
