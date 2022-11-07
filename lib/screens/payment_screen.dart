import 'package:flutter/material.dart';
import 'package:pro_coach/services/supabase_service.dart';
import 'package:pro_coach/widgets/custom_button.dart';

import '../widgets/custom_background.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({required this.coach, required this.id});

  final bool coach;
  final id;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isCheckedMada = true;
  bool isCheckedApple = false;

  Future<void> pay() async {
    try {
      if (widget.coach) {
        await SupabaseService.subscribe(coach: widget.coach, cid: widget.id);
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Paid Successfully',
                  textAlign: TextAlign.center,
                ),
              );
            });
      } else {
        await SupabaseService.subscribe(coach: widget.coach, aid: widget.id);
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Paid Successfully',
                  textAlign: TextAlign.center,
                ),
              );
            });
      }
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Failed To Subscribe',
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Color(0xffDFF6FF);
      }
      return Color(0xffDFF6FF);
    }

    return Scaffold(
      backgroundColor: Color(0xffDFF6FF),
      body: SafeArea(
        child: Stack(
          children: [
            //backGround Design
            CustomBackground(),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Your Payment Method: ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff06283D),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.all(Colors.black),
                      value: isCheckedMada,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedMada = value!;
                          if (value) {
                            isCheckedApple = !value;
                          }
                        });
                      },
                    ),
                    Image(
                      height: 50,
                      image: NetworkImage(
                          'https://cdn.discordapp.com/attachments/933739738823815199/1038457591656882256/image.png'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.all(Colors.black),
                      value: isCheckedApple,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckedApple = value!;
                          if (value) {
                            isCheckedMada = !value;
                          }
                        });
                      },
                    ),
                    Image(
                      height: 50,
                      image: NetworkImage(
                          'https://cdn.discordapp.com/attachments/933739738823815199/1038457921777971220/image.png'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 120,
                ),
                Center(
                  child: CustomButton(
                      child: Text(
                        'Pay',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      width: 200,
                      height: 60,
                      onPress: pay),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
