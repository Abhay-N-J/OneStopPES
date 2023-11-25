import 'package:flutter/material.dart';

class MiscPage extends StatefulWidget {
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
              decoration: InputDecoration(
                labelText: 'Select an option',
              ),
            ),
            SizedBox(height: 20),
            if (selectedOption == 'scholarship') ScholarshipWidget(),
            if (selectedOption == 'elective') ElectiveCoursesWidget(),
            if (selectedOption == 'feedback') FeedbackFormWidget(),
          ],
        ),
      ),
    );
  }
}

class ScholarshipWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Add your logic here to fetch scholarship details

    // Example: Dummy boolean value
    bool requiresBankDetails = true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Scholarship Details'),
        if (requiresBankDetails) Text('Please provide bank details'),
        // Add other scholarship details widgets
      ],
    );
  }
}

class ElectiveCoursesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Add your logic here to create elective courses form
    // Include a form with checkboxes for each elective course

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Elective Courses'),
        // Add elective courses form widgets
      ],
    );
  }
}

class FeedbackFormWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Add your logic here to create feedback form

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Feedback Form'),
        // Add feedback form widgets
      ],
    );
  }
}
