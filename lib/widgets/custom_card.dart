import 'package:flutter/material.dart';
import 'package:pro_coach/screens/details_page_component.dart';

import '../screens/activity_details_page_component.dart';
import '../screens/chat.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    this.id = '',
    required this.title,
    required this.imagePath,
    required this.name,
    this.price = '0',
    this.bio = '',
    this.cardButtonLabel = 'Details',
    this.btnLabel = 'Subscribe',
    this.coach = false,
    this.isChat = false,
    this.activityDetails = false,
    this.location = 'https://maps.google.com/?q=37.4219983,-122.084',
  });

  final String id;
  final String name;
  final String imagePath;
  final String title;
  final String price;
  final String bio;
  final String btnLabel;
  final String cardButtonLabel;
  final String location;

  //activity or coach
  final bool coach;
  final bool isChat;
  final bool activityDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            if (activityDetails) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActivityDetailsPageComponent(
                    coach: coach,
                    title: title,
                    name: name,
                    btnLabel: btnLabel,
                    imagePath: imagePath,
                    price: price,
                    description: bio,
                    location: location,
                    id: id,
                  ),
                ),
              );
              return;
            }
            if (isChat) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TraineeChat(
                    title: title,
                    id: id,
                  ),
                ),
              );
            } else if (coach) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPageComponent(
                    coach: coach,
                    title: title,
                    name: name,
                    btnLabel: btnLabel,
                    imagePath: imagePath,
                    price: price,
                    description: bio,
                    location: location,
                    id: id,
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPageComponent(
                    coach: coach,
                    title: title,
                    name: name,
                    btnLabel: btnLabel,
                    imagePath: imagePath,
                    price: price,
                    description: bio,
                    location: location,
                    id: id,
                  ),
                ),
              );
            }
          },
          splashColor: Color(0xff06283D).withOpacity(0.5),
          highlightColor: Colors.transparent,
          child: Container(
            height: 90,
            width: 500,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: Image(
                              image: NetworkImage(imagePath),
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null)
                                  return child;
                                else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xff06283D),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      VerticalDivider(
                        width: 10,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                        color: Color(0xff06283D),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          width: 200,
                          child: Text(name),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xff06283D),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    cardButtonLabel,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
