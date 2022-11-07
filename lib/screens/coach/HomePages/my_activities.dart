import 'package:flutter/material.dart';
import 'package:pro_coach/screens/coach/add_activity_screen.dart';
import 'package:pro_coach/widgets/custom_waiting_animation.dart';

import '../../../services/supabase_service.dart';
import '../../../widgets/custom_card.dart';

class MyActivitiesPage extends StatefulWidget {
  const MyActivitiesPage({Key? key}) : super(key: key);

  @override
  State<MyActivitiesPage> createState() => _MyActivitiesPageState();
}

class _MyActivitiesPageState extends State<MyActivitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: FutureBuilder(
            future: SupabaseService.getMyActivities(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.length == 0) {
                  return Center(
                    child: Text(
                      'No Accepted Activities.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff06283D),
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemBuilder: (BuildContext context, int index) {
                      return CustomCard(
                        name: snapshot.data[index]['type'],
                        imagePath: snapshot.data[index]['image'],
                        location: snapshot.data[index]['location'],
                        coach: false,
                        title: 'Activity Details',
                        btnLabel: 'Delete',
                        price: snapshot.data[index]['price'],
                        bio: snapshot.data[index]['description'],
                        id: snapshot.data[index]['aid'],
                        activityDetails: true,
                      );
                    },
                  );
                }
              } else {
                return CustomWaitingAnimation();
              }
            },
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: EdgeInsets.only(right: 5),
          child: Material(
            color: Color(0xff06283D),
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddActivityScreen()),
                );
              },
              child: Container(
                height: 50,
                width: 200,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add New Activity',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
