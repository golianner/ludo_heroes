part of 'play_game_bloc.dart';

@immutable
abstract class PlayGameEvent {}

class ChoosePlayerCount extends PlayGameEvent {
  final ChoosePlayer choosePlayer;
  ChoosePlayerCount({required this.choosePlayer});
}

class BeginRollEvent extends PlayGameEvent {}

class RollDiceEvent extends PlayGameEvent {}

class SkipPlayerTurn extends PlayGameEvent {}

class OutFromBase extends PlayGameEvent {
  final int id;
  OutFromBase({required this.id});
}

class MovePiece extends PlayGameEvent {
  final int id;
  final int value;
  MovePiece({required this.id, required this.value});
}
