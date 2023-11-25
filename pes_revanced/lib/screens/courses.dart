import 'package:flutter/material.dart';
import 'package:pes_revanced/components/image_container.dart';
// import '/models/news_item_model.dart';
// import '/screens/event_detail_screen.dart';

class CoursesModel {
  final String name;
  final String code;
  final int credits;
  final String dept;
  final bool isEC;
  final String preReq;

  CoursesModel({
    required this.name,
    required this.code,
    required this.dept,
    required this.credits,
    required this.isEC,
    required this.preReq,
  });
}

class CourseCard extends StatefulWidget {
  final CoursesModel courseItem;
  const CourseCard({super.key, required this.courseItem});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: toggleExpansion,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 20, 20, 20), // Starting color (gray)
                  Color.fromARGB(255, 145, 144, 144), // Ending color (white)
                ],
                stops: [0.0, 1.0], // Set the stops for the gradient
              ),
              border: Border.all(
                color: Colors.black, // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(8.0), // Border radius
            ),
            child: Row(
              children: [
                ImageContainer(
                  // padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(1, 1),
                      color: Colors.grey,
                    ),
                  ],
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.1,
                  imageUrl:
                      'https://i.pinimg.com/736x/1f/aa/9c/1faa9cd83704870669717e8b98c31102.jpg',
                ),
                Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // height: MediaQuery.of(context).size.height * 0.4,
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.orange,
                          ),
                          child: Text(
                            widget.courseItem.code,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    height: 1.25,
                                    color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.courseItem.name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  height: 1.25,
                                  color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Type: ${widget.courseItem.isEC ? 'EC' : 'CC'}",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        height: 1.25,
                                        color: Colors.white),
                              ),
                              Text(
                                "Credits: ${widget.courseItem.credits.toString()}",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        height: 1.25,
                                        color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            //padding: EdgeInsets.all(16.0),
            child: Text('Hello'),
          ),
      ],
    );
  }
}
