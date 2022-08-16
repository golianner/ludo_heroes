import 'package:ludo_heroes/src/domain/entities/color_entity.dart';
import 'package:ludo_heroes/src/domain/entities/piece_entity.dart';

class PieceList {
  static final List<PieceEntity> _list = [
    PieceEntity(
      id: 1,
      warna: Warna.red,
      currentStep: 0,
    ),
    PieceEntity(
      id: 2,
      warna: Warna.red,
      currentStep: 0,
    ),
    PieceEntity(
      id: 3,
      warna: Warna.red,
      currentStep: 0,
    ),
    PieceEntity(
      id: 4,
      warna: Warna.red,
      currentStep: 0,
    ),
    PieceEntity(
      id: 5,
      warna: Warna.blue,
      currentStep: 0,
    ),
    PieceEntity(
      id: 6,
      warna: Warna.blue,
      currentStep: 0,
    ),
    PieceEntity(
      id: 7,
      warna: Warna.blue,
      currentStep: 0,
    ),
    PieceEntity(
      id: 8,
      warna: Warna.blue,
      currentStep: 0,
    ),
    PieceEntity(
      id: 9,
      warna: Warna.green,
      currentStep: 0,
    ),
    PieceEntity(
      id: 10,
      warna: Warna.green,
      currentStep: 0,
    ),
    PieceEntity(
      id: 11,
      warna: Warna.green,
      currentStep: 0,
    ),
    PieceEntity(
      id: 12,
      warna: Warna.green,
      currentStep: 0,
    ),
    PieceEntity(
      id: 13,
      warna: Warna.yellow,
      currentStep: 0,
    ),
    PieceEntity(
      id: 14,
      warna: Warna.yellow,
      currentStep: 0,
    ),
    PieceEntity(
      id: 15,
      warna: Warna.yellow,
      currentStep: 0,
    ),
    PieceEntity(
      id: 16,
      warna: Warna.yellow,
      currentStep: 0,
    ),
  ];

  static List<PieceEntity> getData() {
    return _list;
  }
}
