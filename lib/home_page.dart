import 'package:flutter/material.dart';
import 'list_sampah.dart';
import 'inputsampah.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF0B62FF), Color(0xFF800020)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Logo (taruh file al_azhar_logo.png di assets/images/)
//               // SizedBox(
//               //   height: 120,
//               //   child: Image.asset(
//               //     'assets/images/al_azhar_logo.png',
//               //     fit: BoxFit.contain,
//               //   ),
//               // ),
//               // const SizedBox(height: 12),
//               const Text(
//                 'AL AZHAR',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1.5,
//                 ),
//               ),
//               const SizedBox(height: 32),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Text(
//                   'Catat Sampahmu',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 36),
//               ElevatedButton(
//                 onPressed: () => Navigator.pushNamed(context, '/input'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: const Color(0xFF800020),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 40,
//                     vertical: 14,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Mulai',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

class Item {
  final String title;
  final IconData icon;
  final Color color;

  Item({required this.title, required this.icon, required this.color});
}

final items = [
  Item(title: "Home Page", icon: Icons.home, color: Colors.redAccent),
  Item(title: "Profile Page", icon: Icons.person, color: Colors.blueAccent),
  Item(title: "Settings Page", icon: Icons.settings, color: Colors.cyan),
  Item(title: "Email Page", icon: Icons.email, color: Colors.green),
  Item(title: "Phone Page", icon: Icons.phone, color: Colors.purpleAccent),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hero List View")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ListTile(
          minTileHeight: 100,
          title: Text(items[index].title),
          leading: Hero(
            tag: "hero_list_item_$index",
            child: Container(
              width: 60,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: items[index].color.withValues(alpha: 0.1),
              ),
              child: Icon(items[index].icon, color: items[index].color),
            ),
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HeroListItemPage(index: index),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroListItemPage extends StatelessWidget {
  final int index;
  const HeroListItemPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hero List Item Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Hero(
              tag: "hero_list_item_$index",
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: items[index].color.withValues(alpha: 0.1),
                ),
                child: Center(
                  child: Icon(
                    items[index].icon,
                    color: items[index].color,
                    size: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              items[index].title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
