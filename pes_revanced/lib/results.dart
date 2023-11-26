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
        title: Text('Results'),
      ),
      body: ListView.builder(
        itemCount: resultData.length,
        itemBuilder: (context, index) {
          final data = resultData[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      data.code,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPieChart(
                          data.isa1.toDouble(),
                          data.isa2.toDouble(),
                          'ISAs',
                        ),
                        _buildPieChart(
                          data.esa.toDouble(),
                          0.0,
                          'ESAs',
                        ),
                        _buildPieChart(
                          data.final1.toDouble(),
                          0.0,
                          'Final',
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
    return SizedBox(
      width: 100,
      height: 100,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: value1,
              color: Colors.blue,
            ),
            PieChartSectionData(
              value: value2,
              color: Colors.grey,
            ),
          ],
        ),
      ),
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
      grade,
      style: TextStyle(
        fontSize: 24,
        color: gradeColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}
