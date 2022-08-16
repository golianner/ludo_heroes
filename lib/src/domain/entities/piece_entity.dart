import 'package:ludo_heroes/src/domain/entities/color_entity.dart';

class PieceEntity {
  int id;
  Warna warna;
  int currentStep;

  PieceEntity({
    required this.id,
    required this.warna,
    required this.currentStep,
  });
}
