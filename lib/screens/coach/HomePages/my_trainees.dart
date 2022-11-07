import 'package:flutter/material.dart';
import 'package:pro_coach/widgets/custom_waiting_animation.dart';

import '../../../services/supabase_service.dart';
import '../../../widgets/custom_card.dart';

class MyTraineesPage extends StatefulWidget {
  const MyTraineesPage({Key? key}) : super(key: key);

  @override
  State<MyTraineesPage> createState() => _MyTraineesPageState();
}

class _MyTraineesPageState extends State<MyTraineesPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SupabaseService.getMyTrainees(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemBuilder: (BuildContext context, int index) {
              return CustomCard(
                name: snapshot.data[index]['Trainee']['name'],
                imagePath: snapshot.data[index]['Trainee']['image'],
                isChat: true,
                title: '${snapshot.data[index]['Trainee']['name']} Chat',
                btnLabel: 'Start Chat',
                cardButtonLabel: 'Chat',
                id: snapshot.data[index]['Trainee']['tid'],
              );
            },
          );
        } else {
          return CustomWaitingAnimation();
        }
      },
    );
  }
}
