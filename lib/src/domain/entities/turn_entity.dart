import 'package:ludo_heroes/src/domain/entities/color_entity.dart';

class CurrentTurn {
  Warna warna;
  Turn turn;

  CurrentTurn({
    required this.warna,
    required this.turn,
  });
}

class PlayerTurn {
  Warna current;
  Warna nextTurn;

  PlayerTurn({
    required this.current,
    required this.nextTurn,
  });
}

class TurnEntity {
  Turn turn;
  Turn nextTurn;

  TurnEntity({
    required this.turn,
    required this.nextTurn,
  });
}

class TurnName {
  Turn turn;
  String name;

  TurnName({
    required this.turn,
    required this.name,
  });
}

enum Turn { standBy, beginRoll, selectPawn, pawnMove }
