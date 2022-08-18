import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:ludo_heroes/src/domain/entities/color_entity.dart';
import 'package:ludo_heroes/src/domain/entities/dice_entity.dart';
import 'package:ludo_heroes/src/domain/entities/piece_entity.dart';
import 'package:ludo_heroes/src/domain/entities/player_entity.dart';
import 'package:ludo_heroes/src/domain/entities/step_entity.dart';
import 'package:ludo_heroes/src/domain/entities/turn_entity.dart';
import 'package:ludo_heroes/src/presentation/parameters/play_game_parameter.dart';
import 'package:ludo_heroes/src/utils/assets_sounds.dart';
import 'package:ludo_heroes/src/utils/audio_player.dart';
import 'package:ludo_heroes/src/utils/list_data/dice_list.dart';
import 'package:ludo_heroes/src/utils/parameter_value.dart';
import 'package:ludo_heroes/src/utils/list_data/piece_list.dart';
import 'package:ludo_heroes/src/utils/list_data/player_list.dart';
import 'package:ludo_heroes/src/utils/list_data/step_list.dart';
import 'package:ludo_heroes/src/utils/list_data/turn_list.dart';
import 'package:meta/meta.dart';

part 'play_game_event.dart';
part 'play_game_state.dart';

class PlayGameBloc extends Bloc<PlayGameEvent, PlayGameState> {
  PlayGameBloc() : super(PlayGameInitial()) {
    on<PlayGameEvent>((event, emit) {
      // Begin Roll
      if (event is BeginRollEvent) {
        SoundEffects.audio(AssetSounds.dice);
        nextTurn();
        emit(BeginRollState());
      }

      // Roll a dice
      if (event is RollDiceEvent) {
        DiceEntity diceEntity = DiceList.rollDice();
        state.props.listPlayer
            .firstWhere((element) => element.warna == currentWarna())
            .value = diceEntity.value;
        nextTurn();
        emit(RollDiceState());
      }

      // If Player not have any pieces outside base and dice value after roll is not 6
      if (event is SkipPlayerTurn) {
        state.props.currentTurn =
            CurrentTurn(warna: nextWarna(), turn: Turn.standBy);
        emit(PlayGameInitial());
      }

      // First step out from base (dice value always 6 if this event is triggered)
      if (event is OutFromBase) {
        SoundEffects.audio(AssetSounds.step);
        removeFromBase(event.id);
        addToFirstStep(event.id);
        state.props.currentTurn.turn = Turn.standBy;
        emit(PlayGameInitial());
      }

      // Moving a piece
      if (event is MovePiece) {
        SoundEffects.audio(AssetSounds.step);
        state.props.currentTurn.turn = Turn.pawnMove;
        int left = event.value - 1;
        PieceEntity entity = piece(event.id);
        // Remove piece from last step
        state.props.listStep
            .firstWhere((element) => element.id == entity.currentStep)
            .pieces
            .removeWhere((element) => element.id == entity.id);
        // Status finish
        bool finish = false;
        // Move a step
        if (entity.warna == Warna.red) {
          if (step(entity.currentStep).nextRed == 0) {
            finish = true;
            entity.currentStep = 0;
          } else {
            entity.currentStep = step(entity.currentStep).nextRed;
          }
        }
        if (entity.warna == Warna.blue) {
          if (step(entity.currentStep).nextBlue == 0) {
            finish = true;
            entity.currentStep = 0;
          } else {
            entity.currentStep = step(entity.currentStep).nextBlue;
          }
        }
        if (entity.warna == Warna.yellow) {
          if (step(entity.currentStep).nextYellow == 0) {
            finish = true;
            entity.currentStep = 0;
          } else {
            entity.currentStep = step(entity.currentStep).nextYellow;
          }
        }
        if (entity.warna == Warna.green) {
          if (step(entity.currentStep).nextGreen == 0) {
            finish = true;
            entity.currentStep = 0;
          } else {
            entity.currentStep = step(entity.currentStep).nextGreen;
          }
        }
        // Check if piece reach finish
        if (finish) {
          // remove piece from player step pieces
          state.props.listPlayer
              .firstWhere((element) => element.warna == currentWarna())
              .stepPieces
              .removeWhere((element) => element.id == entity.id);
          // add piece to player finished pieces
          state.props.listPlayer
              .firstWhere((element) => element.warna == currentWarna())
              .finishedPieces
              .add(entity);
        } else {
          // Move normal
          // Add piece to new step
          state.props.listStep
              .firstWhere((element) => element.id == entity.currentStep)
              .pieces
              .add(entity);
          // Update new piece currentstep in list player
          state.props.listPlayer
              .firstWhere((element) => element.warna == currentWarna())
              .stepPieces
              .firstWhere((element) => element.id == entity.id)
              .currentStep = entity.currentStep;
        }
        // Check if dice value 0 or not
        if (left == 0) {
          // Player Win
          bool finishAll = false;
          // Status kill
          bool killing = false;
          if (!finish) {
            // Current step info
            StepEntity step = state.props.listStep
                .firstWhere((element) => element.id == entity.currentStep);
            // Check if step is not a safezone
            if (!step.safeZone) {
              // Begin kills
              for (int i = 0; i < step.pieces.length; i++) {
                // Kill other color piece if exist
                if (step.pieces[i].warna != currentWarna()) {
                  // Change piece currentstep to 0
                  PieceEntity piece = step.pieces[i];
                  piece.currentStep = 0;
                  // Remove killed piece from step
                  state.props.listStep
                      .firstWhere((element) => element.id == step.id)
                      .pieces
                      .removeWhere((element) => element.id == piece.id);
                  // Remove killed piece from player step pieces
                  state.props.listPlayer
                      .firstWhere((element) => element.warna == piece.warna)
                      .stepPieces
                      .removeWhere((element) => element.id == piece.id);
                  // Add killed piece to base
                  state.props.listPlayer
                      .firstWhere((element) => element.warna == piece.warna)
                      .basePieces
                      .add(piece);
                  killing = true;
                  SoundEffects.audio(AssetSounds.death);
                }
              }
            }
          } else {
            int length = state.props.listPlayer
                .firstWhere((element) => element.warna == currentWarna())
                .finishedPieces
                .length;
            if (length == 4) {
              finishAll = true;
            }
          }

          // Check if dice value is 6 or killing status is true to get one free roll
          if (finishAll) {
            nextPlayerTurn();
            nextTurn();
          } else if (currentValue() == 6 || killing || finish) {
            state.props.currentTurn.turn = Turn.standBy;
          } else {
            nextPlayerTurn();
            nextTurn();
          }
          emit(PlayGameInitial());
        } else {
          emit(MovePawnState(id: event.id, value: left));
        }
      }
      // End moving piece
    });
  }

  // Get a step from id
  StepEntity step(int id) {
    return state.props.listStep.firstWhere((element) => element.id == id);
  }

  // Get a pawn that will be moved
  PieceEntity piece(int id) {
    return state.props.listPiece.firstWhere((element) => element.id == id);
  }

  // Remove a pawn from base
  void removeFromBase(int id) {
    state.props.listPlayer
        .firstWhere((element) => element.warna == currentWarna())
        .basePieces
        .removeWhere((element) => element.id == id);
  }

  // Add a pawn to color first step
  void addToFirstStep(int id) {
    PieceEntity pieceEntity =
        state.props.listPiece.firstWhere((element) => element.id == id);
    int firstStep = state.props.listPlayer
        .firstWhere((element) => element.warna == currentWarna())
        .firstStep;
    pieceEntity.currentStep = firstStep;
    state.props.listPlayer
        .firstWhere((element) => element.warna == currentWarna())
        .stepPieces
        .add(pieceEntity);
    state.props.listPiece.firstWhere((element) => element.id == id) ==
        pieceEntity;
    addToStep(pieceEntity);
  }

  // Add a pawn to a step
  void addToStep(PieceEntity pieceEntity) {
    state.props.listStep
        .firstWhere((element) => element.id == pieceEntity.currentStep)
        .pieces
        .add(pieceEntity);
  }

  // Get next color player
  Warna nextWarna() {
    return TurnList.nextWarna(currentWarna());
  }

  // Current dice value
  int currentValue() {
    return state.props.listPlayer
        .firstWhere((element) => element.warna == currentWarna())
        .value;
  }

  // Get current color turn
  Warna currentWarna() {
    return state.props.currentTurn.warna;
  }

  // Next turn
  void nextTurn() {
    state.props.currentTurn.turn =
        TurnList.nextTurn(state.props.currentTurn.turn);
  }

  // Next player turn
  void nextPlayerTurn() {
    bool valid = false;
    for (int i = 0; i < state.props.listPlayer.length; i++) {
      Warna warna = TurnList.nextPlayerTurn(state.props.currentTurn.warna);
      if (state.props.finishedPlayer
          .where((element) => element == warna)
          .isEmpty) {
        valid = true;
        state.props.currentTurn.warna =
            TurnList.nextPlayerTurn(state.props.currentTurn.warna);
        break;
      }
    }
    if (!valid) {
      print('Game Finished');
    }
  }
}
