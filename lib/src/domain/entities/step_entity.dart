import 'package:ludo_heroes/src/domain/entities/color_entity.dart';
import 'package:ludo_heroes/src/domain/entities/piece_entity.dart';

class StepEntity {
  int id;
  Warna warna;
  bool safeZone;
  List<PieceEntity> pieces;
  int nextRed;
  int nextBlue;
  int nextGreen;
  int nextYellow;

  StepEntity({
    required this.id,
    required this.warna,
    required this.safeZone,
    this.pieces = const [],
    required this.nextRed,
    required this.nextBlue,
    required this.nextGreen,
    required this.nextYellow,
  });
}
