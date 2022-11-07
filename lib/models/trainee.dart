import 'dart:io';

class Trainee {
  static String name = '';
  static String email = '';
  static String pass = '';
  static String confPass = '';
  static String city = '';
  static String phone = '';
  static String dob = '';
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
    }
  }

  static void changeDob(year, month, day) {
    dob = '$year-$month-$day';
  }
}
