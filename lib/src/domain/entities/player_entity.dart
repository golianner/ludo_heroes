import 'package:flutter/cupertino.dart';
import 'package:ludo_heroes/src/domain/entities/color_entity.dart';
import 'package:ludo_heroes/src/domain/entities/piece_entity.dart';

class PlayerEntity {
  int id;
  Warna warna;
  List<PieceEntity> basePieces;
  List<PieceEntity> stepPieces;
  List<PieceEntity> finishedPieces;
  int firstStep;
  int lastStep;
  int value;
  Alignment finishAlign;

  PlayerEntity({
    required this.id,
    required this.warna,
    this.basePieces = const [],
    this.stepPieces = const [],
    this.finishedPieces = const [],
    required this.firstStep,
    required this.lastStep,
    this.value = 1,
    required this.finishAlign,
  });
}
