import 'package:flutter/cupertino.dart';
import 'package:ludo_heroes/src/domain/entities/color_entity.dart';
import 'package:ludo_heroes/src/domain/entities/player_entity.dart';

class PlayerList {
  static final List<PlayerEntity> _list = [
    PlayerEntity(
      id: 1,
      warna: Warna.red,
      basePieces: [],
      stepPieces: [],
      finishedPieces: [],
      firstStep: 2,
      lastStep: 105,
      finishAlign: Alignment.centerLeft,
    ),
    PlayerEntity(
      id: 2,
      warna: Warna.blue,
      basePieces: [],
      stepPieces: [],
      finishedPieces: [],
      firstStep: 15,
      lastStep: 205,
      finishAlign: Alignment.topCenter,
    ),
    PlayerEntity(
      id: 3,
      warna: Warna.green,
      basePieces: [],
      stepPieces: [],
      finishedPieces: [],
      firstStep: 41,
      lastStep: 305,
      finishAlign: Alignment.centerRight,
    ),
    PlayerEntity(
      id: 4,
      warna: Warna.yellow,
      basePieces: [],
      stepPieces: [],
      finishedPieces: [],
      firstStep: 28,
      lastStep: 405,
      finishAlign: Alignment.bottomCenter,
    ),
  ];

  static List<PlayerEntity> getData() {
    return _list;
  }
}
