import 'package:flutter/material.dart';
import 'package:ludo_heroes/src/domain/entities/piece_entity.dart';
import 'package:ludo_heroes/src/domain/entities/step_entity.dart';
import 'package:ludo_heroes/src/domain/entities/turn_entity.dart';
import 'package:ludo_heroes/src/presentation/blocs/play_game_bloc/play_game_bloc.dart';
import 'package:ludo_heroes/src/utils/list_data/color_list.dart';
import 'package:ludo_heroes/src/utils/parameter_value.dart';

Widget stepWidget(BuildContext context, StepEntity item, PlayGameState state) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: ColorList.getColor(item.warna),
        border: Border.all(color: Colors.black),
      ),
      child: _stepContent(context, item, state),
    ),
  );
}

Widget _stepContent(
    BuildContext context, StepEntity item, PlayGameState state) {
  if (item.pieces.isNotEmpty) {
    return InkWell(
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
