import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List grafikData = [];

  Future fetchData() async {
    var url = Uri.parse("http://192.168.92.146/api_sampah/grafik.php");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      grafikData = jsonDecode(response.body);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        62,
        167,
        185,
      ), // biru maroon gelap
      appBar: AppBar(
        title: const Text("📊 Dashboard Sampah"),
        backgroundColor: const Color.fromARGB(255, 57, 126, 211),
      ),
      body: grafikData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY:
                      grafikData
                          .map((e) => int.parse(e['total']))
                          .reduce((a, b) => a > b ? a : b)
                          .toDouble() +
                      2,
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int i = value.toInt();
                          if (i < grafikData.length) {
                            return Text(
                              grafikData[i]['kategori'],
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            );
                          }
                          return const Text("");
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: grafikData.asMap().entries.map((entry) {
                    int i = entry.key;
                    var item = entry.value;
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: double.parse(item['total']),
                          width: 20,
                          color: const Color.fromARGB(255, 72, 177, 51),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
    );
  }
}
