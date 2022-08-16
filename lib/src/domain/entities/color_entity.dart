import 'package:flutter/material.dart';

class ColorEntity {
  final Warna warna;
  final Color colorData;
  String image;

  ColorEntity({
    required this.warna,
    required this.colorData,
    this.image = "",
  });
}

enum Warna { red, blue, green, yellow, white, amber }
