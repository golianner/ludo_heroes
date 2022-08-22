import 'package:flutter/material.dart';
import 'package:ludo_heroes/src/domain/entities/color_entity.dart';
import 'package:ludo_heroes/src/utils/const/asset_images.dart';

class ColorList {
  static final List<ColorEntity> _list = [
    ColorEntity(
      warna: Warna.red,
      colorData: Colors.red,
      image: AssetImages.red,
    ),
    ColorEntity(
      warna: Warna.blue,
      colorData: Colors.blue,
      image: AssetImages.blue,
    ),
    ColorEntity(
      warna: Warna.green,
      colorData: Colors.green,
      image: AssetImages.green,
    ),
    ColorEntity(
      warna: Warna.yellow,
      colorData: Colors.yellow,
      image: AssetImages.yellow,
    ),
    ColorEntity(
      warna: Warna.white,
      colorData: Colors.white,
    ),
    ColorEntity(
      warna: Warna.amber,
      colorData: Colors.amber,
    ),
  ];

  static Color getColor(Warna warna) {
    return _list.firstWhere((element) => element.warna == warna).colorData;
  }

  static String getImage(Warna warna) {
    return _list.firstWhere((element) => element.warna == warna).image;
  }
}
