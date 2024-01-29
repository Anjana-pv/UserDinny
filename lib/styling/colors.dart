import 'package:flutter/material.dart';

hexStringcolor(String hexColor){
  hexColor=hexColor.toUpperCase().replaceAll('a', '');
  if(hexColor.length==6){
    hexColor="FF$hexColor";
  }
  return Color(int.parse(hexColor,radix: 16));
}