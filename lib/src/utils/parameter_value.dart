import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_heroes/src/domain/entities/color_entity.dart';
import 'package:ludo_heroes/src/domain/entities/piece_entity.dart';
import 'package:ludo_heroes/src/domain/entities/player_entity.dart';
import 'package:ludo_heroes/src/domain/entities/turn_entity.dart';
import 'package:ludo_heroes/src/presentation/blocs/play_game_bloc/play_game_bloc.dart';

PlayerEntity player(PlayGameState state) {
  return state.props.listPlayer
      .firstWhere((element) => element.warna == currentWarna(state));
}

Warna currentWarna(PlayGameState state) {
  return state.props.currentTurn.warna;
}

Turn currentTurn(PlayGameState state) {
  return state.props.currentTurn.turn;
}

void addEvent(BuildContext context, PlayGameEvent event) {
  BlocProvider.of<PlayGameBloc>(context).add(event);
}

int currentValue(PlayGameState state) {
  return state.props.listPlayer
      .firstWhere((element) => element.warna == currentWarna(state))
      .value;
}

List<PieceEntity> pieces(PlayGameState state) {
  return state.props.listPlayer
      .firstWhere((element) => element.warna == currentWarna(state))
      .basePieces
      .toList();
}

bool checkAvailable(int finish, int currentStep, int value) {
  bool result = true;
  if (currentStep + value > finish) {
    result = false;
  }
  return result;
}

int finish(PlayGameState state) {
  return state.props.listPlayer
          .firstWhere((element) => element.warna == currentWarna(state))
          .lastStep +
      1;
}

int finishByWarna(PlayGameState state, Warna warna) {
  return state.props.listPlayer
          .firstWhere((element) => element.warna == warna)
          .lastStep +
      1;
}
