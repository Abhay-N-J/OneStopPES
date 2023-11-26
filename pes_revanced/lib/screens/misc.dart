import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pes_revanced/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MiscPage extends StatefulWidget {
  const MiscPage({super.key});

  @override
  State<MiscPage> createState() => _MiscPageState();
}

class _MiscPageState extends State<MiscPage> {
  String?
      selectedOption; // Use nullable type to represent initial non-selection
  List<String> options = ['scholarship', 'elective', 'feedback'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                });
              },
              items: options
                  .map((option) => DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      ))
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Select an option',
              ),
            ),
            const SizedBox(height: 20),
            if (selectedOption == 'scholarship') const ScholarshipWidget(),
            if (selectedOption == 'elective') const ElectiveCoursesWidget(),
            if (selectedOption == 'feedback') FeedbackFormWidget(),
          ],
        ),
      ),
    );
  }
}

class ScholarshipWidget extends StatefulWidget {
  const ScholarshipWidget({super.key});

  @override
  State<ScholarshipWidget> createState() => _ScholarshipWidgetState();
}

class _ScholarshipWidgetState extends State<ScholarshipWidget> {
  bool requiresBankDetails = false;
  final TextEditingController _controller = TextEditingController();
  late List<dynamic> scholars = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchScholars().then((value) {
        scholars = value;
      });
    });
  }

  void submit(String bankAcc) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String srn = prefs.getString("srn")!;
    await http
        .post(Uri.parse("$goURI/bank"), body: {"bank": bankAcc, "srn": srn});
  }

  Future<List<dynamic>> fetchScholars() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String srn = prefs.getString("srn")!;
      final response = await http.get(Uri.parse("$goURI/scholar?srn=$srn"));
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> map2 = map["data"];
        setState(() {
          requiresBankDetails = bool.parse(map["isReq"]);
        });
        return map2;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // Add your logic here to fetch scholarship details

    // Example: Dummy boolean value

    return SingleChildScrollView(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (scholars.isEmpty) const Text("No Scholarships"),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: scholars.length,
              itemBuilder: (context, index) {
                final item = scholars[index];
                return Row(
                  children: [
                    Text(item["type"]),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(item["sem"])
                  ],
                );
              }),
          if (requiresBankDetails)
            TextField(
                controller: _controller,
                style: const TextStyle(
                  fontSize: 20,
                ),
                decoration: kTextInputDecoration.copyWith(
                    hintText: 'Bank Acc Details')),
          if (requiresBankDetails)
            ElevatedButton(
                onPressed: () {
                  if (_controller.value.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text(
                        "Emtpy Acc details",
                        textAlign: TextAlign.center,
                      ),
                      duration: const Duration(seconds: 5),
                      backgroundColor: Colors.deepOrange,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ));
                  } else {
                    submit(_controller.value.text);
                  }
                },
                child: const Text("Submit"))
          // Add other scholarship details widgets
        ],
      ),
    );
  }
}

class ElectiveCoursesWidget extends StatelessWidget {
  const ElectiveCoursesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Add your logic here to create elective courses form
    // Include a form with checkboxes for each elective course

    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Elective Courses'),
        // Add elective courses form widgets
      ],
    );
  }
}

class FeedbackFormWidget extends StatelessWidget {
  FeedbackFormWidget({super.key});

  final TextEditingController _controller = TextEditingController();

  void submit(String query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String srn = prefs.getString("srn")!;
    final res = await http.post(Uri.parse("$goURI/feedPost"), body: {
      "query": query,
      "srn": srn,
    });
    print(res.body);
  }

  Future<List<dynamic>> fetchFeedBack() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String srn = prefs.getString("srn")!;
      final response = await http.get(Uri.parse("$goURI/feed?srn=$srn"));
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        List<dynamic> map2 = map["data"];
        return map2;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // Add your logic here to create feedback form

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<List<dynamic>>(
              future: fetchFeedBack(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.data == null) {
                  return const Center(
                    child: Text("Error fetching data"),
                  );
                } else {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data?[index];
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(item["query"]),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(item["reply"])
                            ],
                          ),
                        );
                      });
                }
              }),
          TextField(
              controller: _controller,
              style: const TextStyle(
                fontSize: 20,
              ),
              decoration: kTextInputDecoration.copyWith(
                  hintText: 'Ask Query or send Feedback')),
          ElevatedButton(
              onPressed: () {
                if (_controller.value.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                      "Emtpy Query details",
                      textAlign: TextAlign.center,
                    ),
                    duration: const Duration(seconds: 5),
                    backgroundColor: Colors.deepOrange,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.red, width: 1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ));
                } else {
                  submit(_controller.value.text);
                }
              },
              child: const Text("Submit"))
          // Add feedback form widgets
        ],
      ),
    );
  }
}
