import 'package:flutter/material.dart';
import 'package:pro_coach/models/activity.dart';
import 'package:pro_coach/widgets/custom_background.dart';
import 'package:pro_coach/widgets/custom_button.dart';

import '../../services/dialog_service.dart';
import '../../services/supabase_service.dart';
import '../../widgets/custom_bio_textfield.dart';
import '../../widgets/custom_textField.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({Key? key}) : super(key: key);

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  String currentType = Activity.types[0];
  String currentImage = Activity.images[0];

  Future<void> add(context) async {
    try {
      await SupabaseService.addActivity(
          price: Activity.price,
          description: Activity.description,
          location: Activity.location,
          type: currentType,
          image: currentImage);
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Added Successfully, 24HR To check if it is acceptable',
                textAlign: TextAlign.center,
              ),
            );
          });
      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Failed To Insert Try Again Later',
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }

  show(context, title) {
    showAlertDialog(
      onPressed: () {
        add(context);
      },
      context: context,
      alertTitle: title,
    );
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
                        'Add New Activity:',
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
                      Center(
                        child: Image(
                          width: 300,
                          image: NetworkImage(currentImage),
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

                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.white,
                        child: DropdownButton<String>(
                            isExpanded: true,
                            value: currentType,
                            items: Activity.types
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                currentType = value!;
                                if (value == Activity.types[0]) {
                                  currentImage = Activity.images[0];
                                } else if (value == Activity.types[1]) {
                                  currentImage = Activity.images[1];
                                } else {
                                  currentImage = Activity.images[2];
                                }
                              });
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      CustomTextField(
                        label: 'Price \$',
                        whoWillChange: 'Price',
                        account: 'A',
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        label: 'Location URL',
                        whoWillChange: 'Location',
                        account: 'A',
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      CustomBioTextField(
                        label: 'Description',
                        whoWillChange: 'Description',
                        account: 'A',
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Center(
                        child: CustomButton(
                            child: Text(
                              'Add',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            width: 200,
                            height: 50,
                            onPress: () {
                              show(context, 'Adding New Activity');
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
