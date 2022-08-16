part of 'play_game_bloc.dart';

PlayGameParameter parameter = PlayGameParameter();

@immutable
abstract class PlayGameState {
  PlayGameParameter get props => parameter;
}

class PlayGameInitial extends PlayGameState {}

class BeginRollState extends PlayGameState {}

class RollDiceState extends PlayGameState {}

class MovePawnState extends PlayGameState {
  final int id;
  final int value;
  MovePawnState({required this.id, required this.value});
}
