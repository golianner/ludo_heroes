import 'package:ludo_heroes/src/domain/entities/color_entity.dart';
import 'package:ludo_heroes/src/domain/entities/turn_entity.dart';

class TurnList {
  static final List<TurnEntity> _turnList = [
    TurnEntity(
      turn: Turn.standBy,
      nextTurn: Turn.beginRoll,
    ),
    TurnEntity(
      turn: Turn.beginRoll,
      nextTurn: Turn.selectPawn,
    ),
    TurnEntity(
      turn: Turn.selectPawn,
      nextTurn: Turn.pawnMove,
    ),
    TurnEntity(
      turn: Turn.pawnMove,
      nextTurn: Turn.standBy,
    ),
  ];

  static final List<PlayerTurn> _playerTurnList = [
    PlayerTurn(
      current: Warna.red,
      nextTurn: Warna.blue,
    ),
    PlayerTurn(
      current: Warna.blue,
      nextTurn: Warna.yellow,
    ),
    PlayerTurn(
      current: Warna.yellow,
      nextTurn: Warna.green,
    ),
    PlayerTurn(
      current: Warna.green,
      nextTurn: Warna.red,
    ),
  ];

  static final List<TurnName> _turnNameList = [
    TurnName(
      turn: Turn.standBy,
      name: 'Stand By',
    ),
    TurnName(
      turn: Turn.beginRoll,
      name: 'Roll Dice',
    ),
    TurnName(
      turn: Turn.selectPawn,
      name: 'Select Pawn',
    ),
    TurnName(
      turn: Turn.pawnMove,
      name: 'Pawn Moved',
    ),
  ];

  static String turnName(Turn turn) {
    return _turnNameList.firstWhere((element) => element.turn == turn).name;
  }

  static Turn nextTurn(Turn turn) {
    return _turnList.firstWhere((element) => element.turn == turn).nextTurn;
  }

  static Warna nextWarna(Warna warna) {
    return _playerTurnList
        .firstWhere((element) => element.current == warna)
        .nextTurn;
  }

  static Warna nextPlayerTurn(Warna warna) {
    return _playerTurnList
        .firstWhere((element) => element.current == warna)
        .nextTurn;
  }
}
