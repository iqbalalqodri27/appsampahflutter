import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String, int> counts = {};

  @override
  void initState() {
    super.initState();
    // realtime listener: hitung jumlah per kategori
    FirebaseFirestore.instance.collection('sampah').snapshots().listen((snap) {
      final Map<String, int> m = {};
      for (var d in snap.docs) {
        final k = (d.data()['kategori'] ?? 'Lainnya') as String;
        m[k] = (m[k] ?? 0) + 1;
      }
      setState(() => counts = m);
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = counts.keys.toList();
    final values = counts.values.toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: counts.isEmpty
            ? const Center(child: Text('Belum ada data'))
            : Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY:
                            (values.reduce(
                              (a, b) => a > b ? a : b,
                            )).toDouble() +
                            2,
                        barGroups: List.generate(values.length, (i) {
                          return BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: values[i].toDouble(),
                                width: 18,
                              ),
                            ],
                          );
                        }),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final idx = value.toInt();
                                if (idx < 0 || idx >= categories.length) {
                                  return const SizedBox.shrink();
                                }
                                return Text(
                                  categories[idx],
                                  style: const TextStyle(fontSize: 11),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (c, i) => ListTile(
                        title: Text(categories[i]),
                        trailing: Text(values[i].toString()),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
