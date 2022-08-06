import 'package:flutter/material.dart';

class LoadProvider extends ChangeNotifier {
  bool loading = true;
  bool visible = false;
  int index = 0;
  List data = [
    {
      "option": ["Ok", "Do you have family?"],
      "dialog": [
        'Hi. My name is Anya Forger...',
        'I love peanut...',
        'Waku-waku...'
      ],
      "image": 'assets/images/home.jpg',
      "person": "Anya"
    },
    {
      "option": ["Amazing", "Who is next to you?"],
      "dialog": [
        'My father\'s name is Loid Forger...',
        'He very cool...',
        'Like a spy...'
      ],
      "image": 'assets/images/home2.jpg',
      "person": "Anya Forger"
    },
    {
      "option": ["Sugoi!!"],
      "dialog": [
        'My Mother\'s name is Yor Forger...',
        'She can\'t do anything...',
        'But she is so strong...'
      ],
      "image": 'assets/images/home3.jpg',
      "person": "Anya Forger"
    }
  ];

  bool finish = false;

  changeVal() {
    loading = true;
    if (index + 1 < data.length) {
      index++;
    } else {
      finish = true;
    }
    visibile();
    notifyListeners();
    delay();
  }

  void delay() {
    Future.delayed(const Duration(seconds: 3), () {
      loading = false;
      notifyListeners();
    });
  }

  void visibile() {
    visible = !visible;
    notifyListeners();
  }

  void reset() {
    index = 0;
    finish = false;
    notifyListeners();
  }
}
