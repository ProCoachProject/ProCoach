import 'package:flutter/material.dart';
import 'package:pro_coach/widgets/custom_waiting_animation.dart';

import '../../../services/supabase_service.dart';
import '../../../widgets/custom_card.dart';

class CoachsPage extends StatefulWidget {
  const CoachsPage({Key? key}) : super(key: key);

  @override
  State<CoachsPage> createState() => _CoachsPageState();
}

class _CoachsPageState extends State<CoachsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SupabaseService.getCoachs(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.length == 0) {
            return Center(
              child: Text(
                'No Coach Available.',
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
                  name: snapshot.data[index]['name'],
                  imagePath: snapshot.data[index]['image'],
                  location: snapshot.data[index]['gym_url'],
                  coach: true,
                  title: 'Coach Details',
                  btnLabel: 'Subscribe',
                  price: snapshot.data[index]['price'],
                  bio: snapshot.data[index]['bio'],
                  id: snapshot.data[index]['cid'],
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
