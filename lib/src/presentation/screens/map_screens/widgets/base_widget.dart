import 'package:flutter/material.dart';
import 'package:ludo_heroes/src/domain/entities/color_entity.dart';
import 'package:ludo_heroes/src/domain/entities/piece_entity.dart';
import 'package:ludo_heroes/src/domain/entities/player_entity.dart';
import 'package:ludo_heroes/src/domain/entities/turn_entity.dart';
import 'package:ludo_heroes/src/presentation/blocs/play_game_bloc/play_game_bloc.dart';
import 'package:ludo_heroes/src/utils/list_data/color_list.dart';
import 'package:ludo_heroes/src/utils/parameter_value.dart';
import 'package:simple_animations/simple_animations.dart';

Widget baseItem(BuildContext context, PieceEntity item, PlayGameState state) {
  return Expanded(
    child: InkWell(
      onTap: () {
        if (validate(state, item.warna)) {
          addEvent(context, OutFromBase(id: item.id));
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        color: Colors.white,
        padding: const EdgeInsets.all(3),
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: [
            Container(),
            _animate(context, item, state) ?? Container(),
          ],
        ),
      ),
    ),
  );
}

bool validate(PlayGameState state, Warna warna) {
  return currentWarna(state) == warna &&
          currentValue(state) == 6 &&
          currentTurn(state) == Turn.selectPawn
      ? true
      : false;
}

Widget? _animate(BuildContext context, PieceEntity item, PlayGameState state) {
  if (validate(state, item.warna) &&
      state.props.listPlayer
          .firstWhere((element) => element.warna == item.warna)
          .basePieces
          .toList()
          .isNotEmpty) {
    return MirrorAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 5),
      builder: (context, value, child) =>
          _baseContent(context, item, state, value),
    );
  } else {
    return _baseContent(context, item, state, 0);
  }
}

_baseContent(BuildContext context, PieceEntity item, PlayGameState state,
    double padding) {
  List<PieceEntity> pieces = state.props.listPlayer
      .firstWhere((element) => element.warna == item.warna)
      .basePieces
      .toList();
  if (pieces.isNotEmpty) {
    if (pieces.where((element) => element.id == item.id).toList().isNotEmpty) {
      return Container(
        padding: EdgeInsets.all(padding),
        child: Image.asset(
          ColorList.getImage(pieces[0].warna),
          scale: 5,
          fit: BoxFit.contain,
        ),
      );
    } else {
      return Container();
    }
  } else {
    Container();
  }
}
