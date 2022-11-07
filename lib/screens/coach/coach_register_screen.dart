import 'package:flutter/material.dart';
import 'package:pro_coach/models/coach.dart';
import 'package:pro_coach/screens/coach/coach_waiting_screen.dart';
import 'package:pro_coach/services/supabase_service.dart';
import 'package:pro_coach/widgets/custom_background.dart';
import 'package:pro_coach/widgets/custom_button.dart';
import 'package:pro_coach/widgets/custom_certificate_picker.dart';
import 'package:pro_coach/widgets/custom_location_picker.dart';

import '../../widgets/custom_bio_textfield.dart';
import '../../widgets/custom_image_picker.dart';
import '../../widgets/custom_textField.dart';

class CoachRegisterScreen extends StatefulWidget {
  const CoachRegisterScreen({Key? key}) : super(key: key);

  @override
  State<CoachRegisterScreen> createState() => _CoachRegisterScreenState();
}

class _CoachRegisterScreenState extends State<CoachRegisterScreen> {
  Future<void> register(context) async {
    if (Coach.pass != Coach.confPass || Coach.pass == '') {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Passwords Not Matching',
                textAlign: TextAlign.center,
              ),
            );
          });
      return;
    }
    if (Coach.certificateImage.path == '') {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'You Need To Add Your Certificate',
                textAlign: TextAlign.center,
              ),
            );
          });
      return;
    }
    try {
      await SupabaseService.registerWithEmail(
          email: Coach.email, password: Coach.pass);
      await SupabaseService.addCoachInfo(
        cid: SupabaseService.supabaseClient.auth.currentUser?.id,
        name: Coach.name,
        city: Coach.city,
        bio: Coach.bio,
        phone: Coach.phone,
        price: Coach.price,
        gymUrl: Coach.gymUrl,
        certificateImage: Coach.certificateImage,
        certificateImageName: Coach.certificateImageName,
        imageFile: Coach.imageFile,
        imageFileName: Coach.imageFileName,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CoachWaitingScreen()),
      );
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Please Check If Your Information Is Correct',
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDFF6FF),
      body: Stack(
        children: [
          CustomBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Register :',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff06283D),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //Text Field
                      Center(child: CustomImagePicker()),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        label: 'Name',
                        whoWillChange: 'Name',
                        account: 'C',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        label: 'Email',
                        whoWillChange: 'Email',
                        account: 'C',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        label: 'Password',
                        whoWillChange: 'Password',
                        account: 'C',
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        label: 'Confirm Password',
                        whoWillChange: 'ConfPassword',
                        account: 'C',
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        label: 'City',
                        whoWillChange: 'City',
                        account: 'C',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        label: 'Phone Number',
                        whoWillChange: 'Phone',
                        account: 'C',
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        label: 'Price \$',
                        whoWillChange: 'Price',
                        account: 'C',
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomBioTextField(
                        label: 'Bio',
                        whoWillChange: 'Bio',
                        account: 'C',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomCertificatePicker(),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: CustomLocationPicker(),
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      Center(
                        child: CustomButton(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            width: 200,
                            height: 50,
                            onPress: () {
                              register(context);
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
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
