import 'package:flutter/material.dart';
import 'package:pro_coach/widgets/custom_waiting_animation.dart';

import '../../../services/supabase_service.dart';
import '../../../widgets/custom_card.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SupabaseService.getActivities(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.length == 0) {
            return Center(
              child: Text(
                'No Activity Available.',
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
                  btnLabel: 'Subscribe',
                  price: snapshot.data[index]['price'],
                  bio: snapshot.data[index]['description'],
                  id: snapshot.data[index]['aid'],
                );
              },
            );
          }
        } else {
          return CustomWaitingAnimation();
        }
      },
    );
  }
}
