import 'dart:io';

class Coach {
  static String name = '';
  static String email = '';
  static String pass = '';
  static String confPass = '';
  static String city = '';
  static String bio = '';
  static String phone = '';
  static String price = '';
  static String gymUrl = '';
  static File certificateImage = File('');
  static String certificateImageName = '';
  static File imageFile = File('');
  static String imageFileName = '';

  static void changer(newValue, String whichOne) {
    if (whichOne == 'Name') {
      name = newValue;
    } else if (whichOne == 'Email') {
      email = newValue;
    } else if (whichOne == 'Password') {
      pass = newValue;
    } else if (whichOne == 'ConfPassword') {
      confPass = newValue;
    } else if (whichOne == 'City') {
      city = newValue;
    } else if (whichOne == 'Phone') {
      phone = newValue;
    } else if (whichOne == 'GymUrl') {
      gymUrl = newValue;
    } else if (whichOne == 'Bio') {
      bio = newValue;
    } else if (whichOne == 'Price') {
      price = newValue;
    }
  }
}
