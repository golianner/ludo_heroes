import 'package:flutter/material.dart';
import 'package:ludo_heroes/src/domain/entities/piece_entity.dart';
import 'package:ludo_heroes/src/domain/entities/step_entity.dart';
import 'package:ludo_heroes/src/domain/entities/turn_entity.dart';
import 'package:ludo_heroes/src/presentation/blocs/play_game_bloc/play_game_bloc.dart';
import 'package:ludo_heroes/src/utils/list_data/color_list.dart';
import 'package:ludo_heroes/src/utils/parameter_value.dart';
import 'package:simple_animations/simple_animations.dart';

Widget stepWidget(BuildContext context, StepEntity item, PlayGameState state) {
  return Expanded(
    child: InkWell(
      onTap: () {
        int count = item.pieces.length;
        if (count > 0) {
          if (item.pieces.length > 1) {
            // Show Dialog for choose a pawn
            showDialogPick(context, state, item);
          } else {
            // Directly move a pawn
            if (currentTurn(state) == Turn.selectPawn &&
                currentWarna(state) == item.pieces[0].warna &&
                checkAvailable(finish(state), item.pieces[0].currentStep,
                    currentValue(state))) {
              addEvent(context,
                  MovePiece(id: item.pieces[0].id, value: currentValue(state)));
            }
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: ColorList.getColor(item.warna),
          border: Border.all(color: Colors.black),
        ),
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: [
            Container(),
            _animate(context, item, state),
          ],
        ),
      ),
    ),
  );
}

_animate(BuildContext context, StepEntity item, PlayGameState state) {
  if (havePawn(item, state)) {
    return MirrorAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 5),
      builder: (context, value, child) =>
          _stepContent(context, item, state, value),
    );
  } else {
    return _stepContent(context, item, state, 0);
  }
}

bool havePawn(StepEntity entity, PlayGameState state) {
  bool result = false;
  if (entity.pieces
          .where((element) => element.warna == currentWarna(state))
          .isNotEmpty &&
      currentTurn(state) == Turn.selectPawn) {
    result = true;
  }
  return result;
}

_stepContent(BuildContext context, StepEntity item, PlayGameState state,
    double padding) {
  if (item.pieces.isNotEmpty) {
    return Container(
      padding: EdgeInsets.all(padding),
      child: Stack(
        fit: StackFit.expand,
        children: item.pieces
            .map(
              (e) => Image.asset(
                ColorList.getImage(e.warna),
                scale: 5,
                fit: BoxFit.contain,
              ),
            )
            .toList(),
      ),
    );
  } else {
    return Container();
  }
}

showDialogPick(BuildContext context, PlayGameState state, StepEntity item) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      content: Container(
        color: Colors.white,
        child: Wrap(
          children: item.pieces
              .map(
                (e) => InkWell(
                  onTap: () {
                    if (currentTurn(state) == Turn.selectPawn &&
                        currentWarna(state) == e.warna &&
                        checkAvailable(finish(state),
                            item.pieces[0].currentStep, currentValue(state))) {
                      Navigator.pop(context);
                      addEvent(context,
                          MovePiece(id: e.id, value: currentValue(state)));
                    }
                  },
                  child: Image.asset(
                    ColorList.getImage(e.warna),
                    scale: 5,
                    fit: BoxFit.contain,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}
