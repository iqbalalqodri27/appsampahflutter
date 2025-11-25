import 'package:flutter/material.dart';

void main() {
  runApp(const PilahSampahApp());
}

class PilahSampahApp extends StatelessWidget {
  const PilahSampahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistem Pilah Sampah',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const DashboardPage(),
    );
  }
}

// ========================== DASHBOARD ==========================
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F8),
      appBar: AppBar(
        title: const Text('Dashboard Pilah Sampah'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selamat Datang!",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "Silahkan pilih menu di bawah untuk mulai memilah sampah.",
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                children: [
                  buildCard(
                    icon: Icons.add_circle_outline,
                    title: "Input Sampah",
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PilahSampahForm(),
                      ),
                    ),
                  ),
                  buildCard(
                    icon: Icons.analytics,
                    title: "Laporan",
                    onTap: () {},
                  ),
                  buildCard(
                    icon: Icons.info_outline,
                    title: "Info Sampah",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black.withOpacity(0.06),
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 45, color: Colors.green),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// ====================== FORM INPUT SAMPAH ======================
class PilahSampahForm extends StatefulWidget {
  const PilahSampahForm({super.key});

  @override
  State<PilahSampahForm> createState() => _PilahSampahFormState();
}

class _PilahSampahFormState extends State<PilahSampahForm> {
  final TextEditingController jamController = TextEditingController();
  String? jenisSampah;

  final List<String> listJenis = [
    'Plastik',
    'Kertas',
    'Kantong plastik keresek',
    'Sachet',
    'Sisa makanan',
    'Karton',
    'Kaleng minuman',
    'Stereofoam',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Data Sampah')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: jamController,
              decoration: const InputDecoration(
                labelText: 'Jam',
                hintText: 'Contoh: 14:30',
              ),
            ),
            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: jenisSampah,
              decoration: const InputDecoration(labelText: "Jenis Sampah"),
              items: listJenis
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
              onChanged: (value) => setState(() => jenisSampah = value),
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (jamController.text.isEmpty || jenisSampah == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Isi semua data!')),
                    );
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data berhasil disimpan! (Belum Firebase)'),
                    ),
                  );
                },
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
