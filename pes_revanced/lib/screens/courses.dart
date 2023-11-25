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

class CourseCard extends StatelessWidget {
  // final NewsItemModel newsItem;
  final CoursesModel courseItem;
  const CourseCard({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => EventDetailScreen(newsItem: newsItem),
      //     ),
      //   );
      // },
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
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRi1xPp49YR8jawQYeWUmDLXzXbwFQb2OUZO4injt7gqA&s',
          ),
          Flexible(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                // height: MediaQuery.of(context).size.height * 0.4,
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.grey,
                ),
                child: Text(
                  courseItem.code,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.25,
                      color: Colors.black),
                ),
              ),
              Text(
                courseItem.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.25,
                    color: Colors.white),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Type: ${courseItem.isEC ? 'EC' : 'CC'}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                        color: Colors.white),
                  ),
                  Text(
                    "Credits: ${courseItem.credits.toString()}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                        color: Colors.white),
                  ),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }
}
