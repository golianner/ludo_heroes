import 'package:flutter/material.dart';
import 'package:ludo_heroes/src/domain/entities/color_entity.dart';
import 'package:ludo_heroes/src/domain/entities/piece_entity.dart';
import 'package:ludo_heroes/src/domain/entities/player_entity.dart';
import 'package:ludo_heroes/src/domain/entities/turn_entity.dart';
import 'package:ludo_heroes/src/presentation/blocs/play_game_bloc/play_game_bloc.dart';
import 'package:ludo_heroes/src/utils/list_data/color_list.dart';
import 'package:ludo_heroes/src/utils/parameter_value.dart';

Widget baseItem(BuildContext context, PieceEntity item, PlayGameState state) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(5),
      color: ColorList.getColor(item.warna),
      padding: const EdgeInsets.all(5),
      child: _baseContent(context, item, state),
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

_baseContent(BuildContext context, PieceEntity item, PlayGameState state) {
  List<PieceEntity> pieces = state.props.listPlayer
      .firstWhere((element) => element.warna == item.warna)
      .basePieces
      .toList();
  if (pieces.isNotEmpty) {
    if (pieces.where((element) => element.id == item.id).toList().isNotEmpty) {
      return InkWell(
        onTap: () {
          if (validate(state, item.warna)) {
            addEvent(context, OutFromBase(id: item.id));
          }
        },
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
