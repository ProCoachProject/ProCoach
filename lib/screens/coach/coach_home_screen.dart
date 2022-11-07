import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro_coach/screens/coach/HomePages/my_activities.dart';
import 'package:pro_coach/screens/coach/HomePages/my_trainees.dart';
import 'package:pro_coach/screens/coach/HomePages/profile_page.dart';
import 'package:pro_coach/widgets/custom_signout_button.dart';

import '../../widgets/custom_background.dart';

class CoachHomeScreen extends StatefulWidget {
  const CoachHomeScreen({Key? key}) : super(key: key);

  @override
  State<CoachHomeScreen> createState() => _CoachHomeScreenState();
}

class _CoachHomeScreenState extends State<CoachHomeScreen> {
  int pageIndex = 0;
  final pageController = PageController(initialPage: 0);
  final List<String> pageName = [
    'My Trainees',
    'My Activities',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDFF6FF),
      appBar: AppBar(
        leading: CustomSignOutButton(),
        centerTitle: true,
        backgroundColor: Color(0xff06283D).withOpacity(0.9),
        title: Text(pageName[pageIndex]),
      ),
      body: Stack(
        children: [
          //backGround Design
          CustomBackground(),

          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() => pageIndex = index);
            },
            children: [
              MyTraineesPage(),
              MyActivitiesPage(),
              ProfilePage(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xff06283D).withOpacity(0.15),
        buttonBackgroundColor: Color(0xff06283D),
        color: Color(0xff06283D).withOpacity(0.9),
        index: pageIndex,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Transform.translate(
            offset: Offset(-4.1, 0),
            child: Icon(FontAwesomeIcons.personBiking,
                size: 30, color: Colors.white),
          ),
          Icon(
            FontAwesomeIcons.solidCircleUser,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() => pageController.jumpToPage(index));
        },
      ),
    );
  }
}
