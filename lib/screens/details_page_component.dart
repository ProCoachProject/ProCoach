import 'package:flutter/material.dart';
import 'package:pro_coach/screens/payment_screen.dart';
import 'package:pro_coach/services/supabase_service.dart';
import 'package:pro_coach/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/dialog_service.dart';
import '../widgets/custom_background.dart';

class DetailsPageComponent extends StatefulWidget {
  DetailsPageComponent({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.description,
    required this.btnLabel,
    required this.coach,
    required this.location,
  });

  final String id;
  final String title;
  final String imagePath;
  final String name;
  final String price;
  final String description;
  final String btnLabel;
  final String location;

  //activity or coach
  final bool coach;

  @override
  State<DetailsPageComponent> createState() => _DetailsPageComponentState();
}

class _DetailsPageComponentState extends State<DetailsPageComponent> {
  launchURL() async {
    try {
      if (await canLaunch(widget.location)) {
        await launch(
          widget.location,
        );
      } else {
        throw 'Could not launch ${widget.location}';
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Cannot Open Location',
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }

  Future<void> pressed() async {
    try {
      if (widget.btnLabel == 'Subscribe') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentScreen(
                    coach: widget.coach,
                    id: widget.id,
                  )),
        );
      } else if (widget.btnLabel == 'Delete') {
        await SupabaseService.deleteActivity(aid: widget.id);
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Removed Successfully',
                  textAlign: TextAlign.center,
                ),
              );
            });
        Navigator.pop(context);
        Navigator.pop(context);
      } else if (widget.btnLabel == 'Remove') {
        await SupabaseService.removeActivity(aid: widget.id);
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Removed Successfully',
                  textAlign: TextAlign.center,
                ),
              );
            });
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Failed',
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }

  show(context, title) {
    showAlertDialog(
      onPressed: () {
        pressed();
      },
      context: context,
      alertTitle: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDFF6FF),
      appBar: AppBar(
        leading: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_rounded),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff06283D).withOpacity(0.9),
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          //backGround Design
          CustomBackground(),

          //body
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: NetworkImage(widget.imagePath),
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null)
                              return child;
                            else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xff06283D),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        widget.coach
                            ? '${widget.name} - ${widget.price}\$/Month'
                            : '${widget.name} - ${widget.price}\$/Activity',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff06283D),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.coach ? '  Bio' : '  Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff06283D),
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Container(
                        height: 200,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                widget.description,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff06283D),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Flexible(
                              child: CustomButton(
                                width: 200,
                                height: 50,
                                onPress: () {
                                  launchURL();
                                },
                                child: Text(
                                  'Go To Location',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          height: 50,
                        ),
                      ),
                      CustomButton(
                        width: 200,
                        height: 50,
                        onPress: () {
                          show(context, 'Confirm');
                        },
                        child: Text(
                          widget.btnLabel,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
