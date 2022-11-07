import 'package:flutter/material.dart';
import 'package:pro_coach/widgets/custom_waiting_animation.dart';

import '../../../services/supabase_service.dart';
import '../../../widgets/custom_card.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SupabaseService.getMyCoachsAndActivities(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'My Coachs',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff06283D),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: snapshot.data[0].length == 0
                            ? Center(
                                child: Text(
                                  'No Coach Registered.',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff06283D),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: snapshot.data[0].length,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                itemBuilder: (BuildContext context, int index) {
                                  return CustomCard(
                                    name: snapshot.data[0][index]['Coach']
                                        ['name'],
                                    imagePath: snapshot.data[0][index]['Coach']
                                        ['image'],
                                    isChat: true,
                                    title:
                                        '${snapshot.data[0][index]['Coach']['name']} Chat',
                                    cardButtonLabel: 'Chat',
                                    id: snapshot.data[0][index]['Coach']['cid'],
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'My Activities',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff06283D),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: snapshot.data[1].length == 0
                            ? Center(
                                child: Text(
                                  'No Activity Registered.',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff06283D),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: snapshot.data[1].length,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                itemBuilder: (BuildContext context, int index) {
                                  return CustomCard(
                                    name: snapshot.data[1][index]['Activity']
                                        ['type'],
                                    imagePath: snapshot.data[1][index]
                                        ['Activity']['image'],
                                    location: snapshot.data[1][index]
                                        ['Activity']['location'],
                                    coach: false,
                                    title: 'Activity Details',
                                    btnLabel: 'Remove',
                                    price: snapshot.data[1][index]['Activity']
                                        ['price'],
                                    bio: snapshot.data[1][index]['Activity']
                                        ['description'],
                                    id: snapshot.data[1][index]['Activity']
                                        ['aid'],
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return CustomWaitingAnimation();
        }
      },
    );
  }
}
