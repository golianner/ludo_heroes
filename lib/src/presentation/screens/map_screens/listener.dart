import 'package:flutter/material.dart';
import 'package:ludo_heroes/src/domain/entities/piece_entity.dart';
import 'package:ludo_heroes/src/presentation/blocs/play_game_bloc/play_game_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_heroes/src/utils/const/assets_sounds.dart';
import 'package:ludo_heroes/src/utils/audio_player.dart';
import 'package:ludo_heroes/src/utils/parameter_value.dart';

void listener(BuildContext context, PlayGameState state) {
  if (state is BeginRollState) {
    Future.delayed(const Duration(milliseconds: 800), () {
      addEvent(context, RollDiceEvent());
    });
  }

  if (state is RollDiceState) {
    if (player(state).stepPieces.isEmpty && currentValue(state) != 6) {
      // Next Player Turn
      addEvent(context, SkipPlayerTurn());
    } else {
      // Get count of piece in the base
      int baseCount = state.props.listPlayer
          .firstWhere((element) => element.warna == currentWarna(state))
          .basePieces
          .length;
      // If dice value is not 6 or value is 6 but the base is empty
      if (currentValue(state) < 6 || (currentValue(state) == 6 && baseCount == 0)) {
        // Get list piece that can be moved
        List<PieceEntity> pieces = player(state)
            .stepPieces
            .where((element) => checkAvailable(
                finish(state), element.currentStep, currentValue(state)))
            .toList();
        // Check if any list that can be moved
        if (pieces.isEmpty) {
          // Next Player Turn
          addEvent(context, SkipPlayerTurn());
        } else {
          if (pieces.length == 1) {
            // Only had one piece that can be moved
            Future.delayed(const Duration(milliseconds: 450), () {
              addEvent(
                context,
                MovePiece(
                  id: pieces[0].id,
                  value: currentValue(state),
                ),
              );
            });
          }
        }
      }
    }
  }

  if (state is MovePawnState) {
    Future.delayed(const Duration(milliseconds: 450), () {
      addEvent(context, MovePiece(id: state.id, value: state.value));
    });
  }
}
