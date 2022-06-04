import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navigateAndFinish(context, page) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => page), (route) => false);
}

void navigateTo(context, page) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => page), (route) => true);
}

String intToString(int index) {
  String synonmInText = '';
  switch (index) {
    case 0:
      synonmInText = 'First';
      break;
    case 1:
      synonmInText = 'Second';
      break;
    case 2:
      synonmInText = 'Third';
      break;
    case 3:
      synonmInText = 'Fourth';
      break;
    case 4:
      synonmInText = 'Fifth';
      break;
    case 5:
      synonmInText = 'Sixth';
      break;
  }
  return synonmInText;
}

String firstLetter(String name) {
  String firstLetter = name.characters.first.toUpperCase();
  return firstLetter;
}
