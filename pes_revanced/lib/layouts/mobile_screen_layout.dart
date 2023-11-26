import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pes_revanced/constants.dart';
import 'package:pes_revanced/screens/auth.dart';
import 'package:pes_revanced/screens/courses.dart';
import 'package:pes_revanced/screens/dashboard.dart';
import 'package:pes_revanced/screens/misc.dart';
import 'package:pes_revanced/screens/notifications.dart';
import 'package:pes_revanced/screens/results.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  static const primaryColor = Colors.pink;
  static const secondaryColor = Colors.grey;
  static const mobileBackgroundColor = Color.fromRGBO(0, 0, 0, 1);

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 350), curve: Curves.bounceOut);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          Builder(builder: (context) {
            return IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Auth()));
                  }
                });
          })
        ],
      ),
      body: PageView(
        physics: const BouncingScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          Center(child: PopulateNotfis()),
          Center(
            child: PopulateCourses(),
          ),
          Center(
            child: DashBoard(),
          ),
          Center(
            child: PopulateResults(),
          ),
          Center(
            child: MiscPage(),
          )
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
            icon: Icon(Icons.home,
                color: _page == 2 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grade_outlined,
                color: _page == 3 ? primaryColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.miscellaneous_services,
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String srn = prefs.getString("srn")!;
    final response = await http.get(Uri.parse("$goURI/course?srn=$srn"));
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

class PopulateNotfis extends StatelessWidget {
  const PopulateNotfis({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NotificationModel>>(
        future: fetchNotifs(),
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
                    NotificationCard(notifItem: item!),
                    const SizedBox(
                      height: 10,
                    )
                  ]);
                });
          }
        });
  }
}

Future<List<NotificationModel>> fetchNotifs() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String srn = prefs.getString("srn")!;
    final String branch = prefs.getString("branch")!;
    final String sem = prefs.getString("sem")!;
    final response = await http.get(Uri.parse("$goURI/notifs?srn=$srn"));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> map2 = map["data"];
      var values = map2
          .map((e) => NotificationModel(
              branch: branch,
              sem: int.parse(sem),
              message: e["message"],
              headline: e["title"],
              link: e["link"]))
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

class PopulateResults extends StatelessWidget {
  const PopulateResults({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ResultModel>>(
        future: fetchResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.data == null) {
            return const Center(
              child: Text("Error fetching data"),
            );
          } else {
            return ResultPage(resultData: snapshot.data!);
          }
        });
  }
}

Future<List<ResultModel>> fetchResults() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String srn = prefs.getString("srn")!;
    final response = await http.get(Uri.parse("$goURI/results?srn=$srn"));
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> map2 = map["data"];
      var values = map2
          .map((e) => ResultModel(
              isa1: double.parse(e["isa1"]),
              isa2: double.parse(e["isa2"]),
              esa: double.parse(e["esa"]),
              final1: double.parse(e["final"]),
              code: e["code"],
              grade: e["grade"]))
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
