import 'package:flutter/material.dart';
import 'package:pes_revanced/components/image_container.dart';
import 'package:url_launcher/url_launcher.dart';
// import '/models/news_item_model.dart';
// import '/screens/event_detail_screen.dart';

class NotificationModel {
  final String branch;
  final int sem;
  final String message;
  final String headline;
  final String link;

  NotificationModel({
    required this.branch,
    required this.sem,
    required this.message,
    required this.headline,
    this.link = "",
  });
}

class NotificationCard extends StatelessWidget {
  // final NewsItemModel newsItem;
  final NotificationModel notifItem;
  const NotificationCard({super.key, required this.notifItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () async {
        try {
          if (notifItem.link.isEmpty) {
            throw ErrorDescription("Bad URL");
          }
          final uri = Uri.parse(notifItem.link);
          await launchUrl(uri);
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "$e",
                textAlign: TextAlign.center,
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.deepOrange,
              elevation: 10,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(24),
              ),
            ));
          }
        }
      },
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  notifItem.headline,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              //offset: Offset(0, 3), // Changes the position of the shadow
            ),
          ],
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
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.15,
              imageUrl:
                  "https://i.pinimg.com/736x/1f/aa/9c/1faa9cd83704870669717e8b98c31102.jpg",
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
                        notifItem.branch,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                            color: Colors.black),
                      ),
                    ),
                    Text(
                      notifItem.headline,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              height: 1.25,
                              color: Colors.white),
                    ),
                    Text(
                      notifItem.message,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                          color: Colors.green),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
