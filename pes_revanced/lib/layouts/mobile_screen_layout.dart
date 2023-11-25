import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pes_revanced/constants.dart';
import 'package:pes_revanced/screens/courses.dart';
import 'package:pes_revanced/screens/notifications.dart';
// import 'package:insta_clone/db_access_provider/user_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:insta_clone/models/user.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  final List<NotificationModel> _notifs = [
    NotificationModel(
        branch: "CSE", sem: 1, message: "Hello", headline: "Guys"),
    NotificationModel(branch: "CSE", sem: 2, message: "Guys", headline: "Hello")
  ];

  final List<CoursesModel> _courses = [
    CoursesModel(
        name: "Programming in Python",
        code: "CS101",
        dept: "CSE",
        credits: 4,
        isEC: false,
        preReq: ""),
    CoursesModel(
        name: "Graph Thory and Algorithms",
        code: "CS404",
        dept: "CSE",
        credits: 4,
        isEC: true,
        preReq: "DSA"),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  // static List<Widget> homeScreenItems =

  static const primaryColor = Colors.pink;
  static const secondaryColor = Colors.grey;
  static const mobileBackgroundColor = Color.fromRGBO(0, 0, 0, 1);

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          Center(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _notifs.length,
                itemBuilder: (context, index) {
                  final item = _notifs[index];
                  return NotificationCard(notifItem: item);
                }),
          ),
          const Center(
            child: PopulateCourses(),
            // child: ListView.builder(
            //     physics: const BouncingScrollPhysics(),
            //     itemCount: _courses.length,
            //     itemBuilder: (context, index) {
            //       final item = _courses[index];
            //       return CourseCard(courseItem: item);
            //     }),
          ),
          Center(
            child: Text("Dashboard"),
          ),
          Center(child: Text("Exams")),
          Center(
              child: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(snapshot.data.toString());
              }
            },
          ))
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add_outlined,
                color: _page == 0 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded,
                color: _page == 1 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,
                color: _page == 2 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,
                color: _page == 3 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _page == 4 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          )
        ],
        onTap: navigationTapped,
      ),
    );
  }
}

Future<String> fetchData() async {
  // try {
  //   var settings = ConnectionSettings(
  //       host: '10.5.18.244',
  //       port: 3306,
  //       user: 'abhay',
  //       password: 'a123',
  //       db: 'Project');
  //   print("Starting");
  //   var conn = await MySqlConnection.connect(settings);
  //   var results = await conn.query('select * from student');
  //   print(results as String);
  //   return results.first as String;
  // } catch (e) {
  //   print(e.toString());
  // }
  // return "Hello";
  try {
    final response = await http.get(Uri.parse('$goURI/data'));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      return map.toString();
    } else {
      return "Error";
    }
  } catch (e) {
    return e.toString();
  }
}

class PopulateCourses extends StatelessWidget {
  const PopulateCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CoursesModel>>(
        future: fetchCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.data == null) {
            return const Center(
              child: Text("Error fetching data"),
            );
          } else {
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data?[index];
                  return Column(children: [
                    CourseCard(courseItem: item!),
                    const SizedBox(
                      height: 10,
                    )
                  ]);
                });
          }
        });
  }
}

Future<List<CoursesModel>> fetchCourses() async {
  try {
    final response =
        await http.get(Uri.parse("$goURI/course"));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> map2 = map["data"];
      var values = map2
          .map((e) => CoursesModel(
              name: e["name"]!,
              code: e["code"]!,
              dept: e["dept"]!,
              credits: int.parse(e["credits"]!),
              isEC: e["preReq"] != null ? true : false,
              preReq: e["preReq"] ?? " "))
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
