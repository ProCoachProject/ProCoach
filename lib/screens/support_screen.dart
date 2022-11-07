import 'package:flutter/material.dart';
import 'package:pro_coach/widgets/custom_bio_textfield.dart';
import 'package:pro_coach/widgets/custom_button.dart';

import '../../widgets/custom_background.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  Future<void> send() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Thank You For Contacting Us',
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDFF6FF),
      body: Stack(
        children: [
          CustomBackground(),
          SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Image(
                          image: NetworkImage(
                              'https://cdn.discordapp.com/attachments/933739738823815199/1038441484665495552/image.png'),
                          height: 230,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '+966555555555',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff06283D),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomBioTextField(
                          label: 'Message',
                          whoWillChange: 'Name',
                          account: 'T'),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                          child: Text(
                            'Send',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          width: 200,
                          height: 50,
                          onPress: send),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
