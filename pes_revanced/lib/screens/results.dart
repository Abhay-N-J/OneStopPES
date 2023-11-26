import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ResultModel {
  final double isa1;
  final double isa2;
  final double esa;
  final double final1;
  final String code;
  final String grade;

  ResultModel({
    required this.isa1,
    required this.isa2,
    required this.esa,
    required this.final1,
    required this.code,
    required this.grade,
  });
}

List<ResultModel> resultData = [
  ResultModel(
    isa1: 30,
    isa2: 25,
    esa: 70,
    final1: 81,
    code: 'CSCI101',
    grade: 'B',
  ),
  ResultModel(
    isa1: 35,
    isa2: 28,
    esa: 60,
    final1: 91,
    code: 'CSCI201',
    grade: 'C',
  ),
  ResultModel(
    isa1: 38,
    isa2: 35,
    esa: 55,
    final1: 86,
    code: 'CSCI301',
    grade: 'D',
  ),
  ResultModel(
    isa1: 40,
    isa2: 39,
    esa: 80,
    final1: 96,
    code: 'CSCI401',
    grade: 'A',
  ),
  ResultModel(
    isa1: 30,
    isa2: 31,
    esa: 75,
    final1: 83,
    code: 'CSCI501',
    grade: 'B',
  ),
];

class ResultPage extends StatelessWidget {
  final List<ResultModel> resultData;

  const ResultPage({
    super.key,
    required this.resultData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        //backgroundColor: Colors.pinkAccent,
      ),
      body: ListView.builder(
        itemCount: resultData.length,
        itemBuilder: (context, index) {
          final data = resultData[index];
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      data.code,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            _buildPieChart(
                              data.isa1.toDouble(),
                              40 - data.isa1.toDouble(),
                              'ISA1',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            _buildPieChart(
                              data.isa2.toDouble(),
                              40 - data.isa2.toDouble(),
                              'ISA2',
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            _buildPieChart(
                              data.esa.toDouble(),
                              100 - data.esa.toDouble(),
                              'ESA',
                            ),
                            const SizedBox(height: 10),
                            _buildPieChart(
                              data.final1.toDouble(),
                              100 - data.final1.toDouble(),
                              'FINAL',
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildGradeText(data.grade),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPieChart(double value1, double value2, String title) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 20,
              color: Colors.pinkAccent,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 150,
          height: 150,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 7,
              //pieTouchData: PieTouchData(enabled: true),
              borderData: FlBorderData(show: false),
              sectionsSpace: 2,
              sections: [
                PieChartSectionData(
                  value: value1.roundToDouble(),
                  color: Colors.green,
                  showTitle: true,
                  titleStyle: const TextStyle(fontSize: 24),
                  radius: 60,
                ),
                PieChartSectionData(
                  value: value2.truncateToDouble(),
                  color: Colors.red,
                  showTitle: true,
                  radius: 60,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGradeText(String grade) {
    Color gradeColor = Colors.grey;

    switch (grade) {
      case 'S':
        gradeColor = Colors.amber;
        break;
      case 'A':
        gradeColor = Colors.green;
        break;
      case 'B':
        gradeColor = Colors.blue;
        break;
      case 'C':
        gradeColor = Colors.cyan;
        break;
      case 'D':
        gradeColor = Colors.yellow;
        break;
      case 'E':
        gradeColor = Colors.red;
        break;
      default:
        gradeColor = Colors.grey;
    }

    return Text(
      "Grade: $grade",
      style: TextStyle(
        fontSize: 30,
        color: gradeColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}
