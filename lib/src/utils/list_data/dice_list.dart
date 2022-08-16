import 'package:ludo_heroes/src/domain/entities/dice_entity.dart';
import 'package:ludo_heroes/src/utils/asset_images.dart';
import 'dart:math';

class DiceList {
  static final List<DiceEntity> _list = [
    DiceEntity(value: 1, image: AssetImages.one),
    DiceEntity(value: 2, image: AssetImages.two),
    DiceEntity(value: 3, image: AssetImages.three),
    DiceEntity(value: 4, image: AssetImages.four),
    DiceEntity(value: 5, image: AssetImages.five),
    DiceEntity(value: 6, image: AssetImages.six),
  ];

  static String getImage(int value) {
    return _list.firstWhere((element) => element.value == value).image;
  }

  static int _random() {
    return 1 + Random().nextInt(7 - 1);
  }

  static DiceEntity rollDice() {
    int value = _random();
    value = 1;
    return _list.firstWhere((element) => element.value == value);
  }
}
