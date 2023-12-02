import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pes_revanced/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StudentModel {
  final int srn;
  final String branch;
  final String email;
  final int sem;
  final double cgpa;
  final String name;

  StudentModel(
      {required this.srn,
      required this.branch,
      required this.email,
      required this.sem,
      required this.name,
      required this.cgpa});
}

var studItem = StudentModel(
  srn: 1234,
  branch: 'Computer Science',
  email: 'student1@example.com',
  sem: 3,
  name: 'John Doe',
  cgpa: 8.5,
);

class TimeTableModel {
  final String day;
  final int roomNo;
  final String time;
  final String code;
  final String instructorName;

  TimeTableModel({
    required this.day,
    required this.roomNo,
    required this.time,
    required this.code,
    required this.instructorName,
  });
}

List<TimeTableModel> timetableData = [
  TimeTableModel(
    day: 'Monday',
    roomNo: 101,
    time: '9:00 AM',
    code: 'CSCI101',
    instructorName: 'John Doe',
  ),
  TimeTableModel(
    day: 'Tuesday',
    roomNo: 102,
    time: '11:00 AM',
    code: 'CSCI201',
    instructorName: 'Alice Smith',
  ),
  // Add more entries as needed
];

const darkColor = Color(0xFF49535C);

class ProfileScreen extends StatelessWidget {
  final StudentModel studItem;
  //final TimeTableModel timetableData;
  const ProfileScreen({super.key, required this.studItem});

  @override
  Widget build(BuildContext context) {
    var montserrat = buildMontserrat(Colors.pinkAccent);
    return Column(
      children: [
        Material(
          child: Container(
            // height: double.infinity,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 44, 58, 71),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 5,
                        blurRadius: 2,
                        //offset: Offset(0, 3), // Changes the position of the shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 150,
                        child: Stack(
                          children: [
                            ClipPath(
                              clipper: AvatarClipper(),
                              child: Container(
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 11,
                              top: 50,
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('assets/person.jpg')),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        studItem.name,
                                        style: const TextStyle(
                                          fontSize: 32,
                                          color: Colors.greenAccent,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        studItem.branch,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      const SizedBox(height: 8)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 17,
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "SRN: \nEmail: ",
                                  style: montserrat,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "SEM: \nCGPA: ",
                                  style: montserrat,
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  studItem.srn.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  studItem.email,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  studItem.sem.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  studItem.cgpa.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      //const SizedBox(height: 4)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  TextStyle buildMontserrat(
    Color color, {
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: 18,
      color: color,
      fontWeight: fontWeight,
    );
  }
}

class TimeTableWidget extends StatefulWidget {
  final List<TimeTableModel> timetableData;

  const TimeTableWidget({super.key, required this.timetableData});

  @override
  State<TimeTableWidget> createState() => _TimeTableWidgetState();
}

class _TimeTableWidgetState extends State<TimeTableWidget> {
  bool _sortAscending = true;
  // int _sortColumnIndex = 2; // Index of 'Time' column

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            headingRowColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return Theme.of(context).primaryColor; // Custom header color
              },
            ),
            headingTextStyle: const TextStyle(
                fontSize: 20,
                color: Colors.green), // Text style for header text
            dataRowColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                return const Color.fromARGB(
                    255, 22, 40, 62); // Custom cell color
              },
            ),
            columns: [
              DataColumn(
                label: const Text('Day'),
                onSort: (columnIndex, ascending) {
                  setState(() {
                    if (_sortAscending) {
                      widget.timetableData
                          .sort((a, b) => a.day.compareTo(b.day));
                    } else {
                      widget.timetableData
                          .sort((a, b) => b.day.compareTo(a.day));
                    }
                    _sortAscending = !_sortAscending;
                  });
                },
              ),
              const DataColumn(label: Text('Room No')),
              DataColumn(
                label: const Text('Time'),
                onSort: (columnIndex, ascending) {
                  setState(() {
                    if (_sortAscending) {
                      widget.timetableData
                          .sort((a, b) => a.time.compareTo(b.time));
                    } else {
                      widget.timetableData
                          .sort((a, b) => b.time.compareTo(a.time));
                    }
                    _sortAscending = !_sortAscending;
                  });
                },
              ),
              const DataColumn(label: Text('Code')),
              const DataColumn(label: Text('Instructor Name')),
            ],
            rows: widget.timetableData.map((data) {
              return DataRow(cells: [
                DataCell(Text(data.day)),
                DataCell(Text(data.roomNo.toString())),
                DataCell(Text(data.time)),
                DataCell(Text(data.code)),
                DataCell(Text(data.instructorName)),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class AvatarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height)
      ..lineTo(8, size.height)
      ..arcToPoint(Offset(114, size.height), radius: const Radius.circular(1))
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        FutureBuilder<StudentModel?>(
            future: fetchProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.data == null) {
                return const Center(
                  child: Text("Error fetching data"),
                );
              } else {
                return ProfileScreen(studItem: snapshot.data!);
              }
            }),
        FutureBuilder<List<TimeTableModel>>(
            future: fetchTimeTable(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.data == null) {
                return const Center(
                  child: Text("Error fetching data"),
                );
              } else {
                return Flexible(
                    child: TimeTableWidget(timetableData: snapshot.data!));
              }
            })
      ],
    );
  }
}

Future<StudentModel?> fetchProfile() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String srn = prefs.getString("srn")!;
    final response = await http.get(Uri.parse("$goURI/profile?srn=$srn"));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      final value = StudentModel(
          srn: int.parse(map["srn"]),
          branch: map["branch"],
          email: map["email"],
          sem: int.parse(map["sem"]),
          name: map["name"],
          cgpa: double.parse(map["cgpa"]));
      return value;
    } else {
      return null;
    }
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<List<TimeTableModel>> fetchTimeTable() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String sem = prefs.getString("sem")!;
    final response = await http.get(Uri.parse("$goURI/timetable?sem=$sem"));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> map2 = map["data"];
      var values = map2
          .map((e) => TimeTableModel(
              day: e["day"],
              roomNo: int.parse(e["room"]),
              time: e["time"],
              code: e["code"],
              instructorName: e["name"]))
          .toList();
      return values;
    } else {
      return [];
    }
  } catch (e) {
    print(e.toString());
    return [];
  }
}
