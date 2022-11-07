class Activity {
  static String price = '';
  static String type = '';
  static String location = '';
  static String description = '';

  static final List<String> types = <String>[
    'Hiking',
    'Racing',
    'Cycling',
  ];
  static final List<String> images = <String>[
    'https://img.freepik.com/free-vector/cartoon-people-hiking-together_23-2149012383.jpg?w=2000',
    'https://cdn.discordapp.com/attachments/933739738823815199/1037385707397853184/winner-finish-flat-composition-w.png',
    'https://cdn.discordapp.com/attachments/933739738823815199/1037386089595416626/images.jpg',
  ];

  static void changer(newValue, String whichOne) {
    if (whichOne == 'Location') {
      location = newValue;
    } else if (whichOne == 'Type') {
      type = newValue;
    } else if (whichOne == 'Description') {
      description = newValue;
    } else if (whichOne == 'Price') {
      price = newValue;
    }
  }
}
