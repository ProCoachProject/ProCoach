import 'package:flutter/material.dart';
import 'package:pro_coach/widgets/custom_waiting_animation.dart';

import '../../../services/supabase_service.dart';
import '../../about_us_screen.dart';
import '../../my_account_screen.dart';
import '../../support_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SupabaseService.getCurrentUserInformation('Trainee'),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(snapshot.data[0]['image']),
                radius: 80,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                snapshot.data[0]['name'],
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff06283D),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                indent: 40,
                endIndent: 40,
                thickness: 3,
              ),
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyAccountScreen(
                          name: snapshot.data[0]['name'],
                          city: snapshot.data[0]['city'],
                          phone: snapshot.data[0]['phone_number'],
                        ),
                      ),
                    );
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.grey.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Icon(
                        Icons.account_box,
                        size: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'My Account',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff06283D),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                indent: 40,
                endIndent: 40,
                thickness: 3,
              ),
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SupportScreen()),
                    );
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.grey.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Icon(
                        Icons.contact_support,
                        size: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Support',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff06283D),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                indent: 40,
                endIndent: 40,
                thickness: 3,
              ),
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUsScreen()),
                    );
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.grey.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Icon(
                        Icons.quora_outlined,
                        size: 40,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'About Us',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff06283D),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                indent: 40,
                endIndent: 40,
                thickness: 3,
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
