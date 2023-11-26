import 'package:flutter/material.dart';

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

var studItem = [
  StudentModel(
    srn: 1234,
    branch: 'Computer Science',
    email: 'student1@example.com',
    sem: 3,
    name: 'John Doe',
    cgpa: 8.5,
  ),
];

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
    var montserrat = const TextStyle(
      fontSize: 12,
    );
    return Column(
      children: [
        Material(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
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
                                  color: darkColor,
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
                                    backgroundImage: NetworkImage(
                                        "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/22/22a4f44d8c8f1451f0eaa765e80b698bab8dd826_full.jpg"),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        studItem.name,
                                        style: const TextStyle(
                                          fontSize: 32,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Branch : ${studItem.branch}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: darkColor,
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
                          vertical: 30,
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "SRN: \n Email: ",
                                  style: montserrat,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "SEM: \n CGPA: ",
                                  style: montserrat,
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(studItem.srn.toString(),
                                    style: montserrat),
                                Text(studItem.email, style: montserrat),
                                const SizedBox(height: 16),
                                Text(studItem.sem.toString(),
                                    style: montserrat),
                                Text(studItem.cgpa.toString(),
                                    style: montserrat),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          headingRowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return Theme.of(context).primaryColor; // Custom header color
            },
          ),
          headingTextStyle:
              TextStyle(color: Colors.white), // Text style for header text
          dataRowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return Colors.grey[800]!; // Custom cell color
            },
          ),
          columns: [
            DataColumn(
              label: Text('Day'),
              onSort: (columnIndex, ascending) {
                setState(() {
                  if (_sortAscending) {
                    widget.timetableData.sort((a, b) => a.day.compareTo(b.day));
                  } else {
                    widget.timetableData.sort((a, b) => b.day.compareTo(a.day));
                  }
                  _sortAscending = !_sortAscending;
                });
              },
            ),
            DataColumn(label: Text('Room No')),
            DataColumn(
              label: Text('Time'),
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
            DataColumn(label: Text('Code')),
            DataColumn(label: Text('Instructor Name')),
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
