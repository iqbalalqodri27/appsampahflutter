// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ListSampahPage extends StatefulWidget {
//   const ListSampahPage({super.key});

//   @override
//   State<ListSampahPage> createState() => _ListSampahPageState();
// }

// class _ListSampahPageState extends State<ListSampahPage> {
//   List dataSampah = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   Future<void> getData() async {
//     var url = Uri.parse("http://192.168.92.146/api_sampah/get_sampah.php");
//     var response = await http.get(url);
//     setState(() {
//       dataSampah = json.decode(response.body);
//       loading = false;
//     });
//   }

//   Future<void> hapusData(String id) async {
//     var url = Uri.parse("http://192.168.92.146/api_sampah/delete_sampah.php");
//     await http.post(url, body: {"id": id});
//     getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF800020),
//         title: const Text("Data Sampah"),
//         actions: [
//           IconButton(icon: const Icon(Icons.refresh), onPressed: getData),
//         ],
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : dataSampah.isEmpty
//           ? const Center(
//               child: Text(
//                 "Belum ada data",
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//             )
//           : ListView.builder(
//               padding: const EdgeInsets.all(10),
//               itemCount: dataSampah.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 5,
//                   child: ListTile(
//                     title: Text(dataSampah[index]["nama"]),
//                     subtitle: Text(
//                       "NIS : ${dataSampah[index]["nis"]}\nKategori : ${dataSampah[index]["kategori"]}",
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit, color: Colors.blue),
//                           onPressed: () {
//                             // TODO EDIT
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () {
//                             hapusData(dataSampah[index]["id"]);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text("Data berhasil dihapus!"),
//                                 backgroundColor: Colors.red,
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class ListSampahPage extends StatelessWidget {
  const ListSampahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Sampah")),
      body: const Center(child: Text("Data sampah tampil di sini")),
    );
  }
}
