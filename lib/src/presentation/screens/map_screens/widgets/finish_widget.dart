import 'package:flutter/cupertino.dart';
import 'package:ludo_heroes/src/domain/entities/player_entity.dart';
import 'package:ludo_heroes/src/presentation/blocs/play_game_bloc/play_game_bloc.dart';
import 'package:ludo_heroes/src/utils/list_data/color_list.dart';

Widget finishItem(BuildContext context, PlayGameState state) {
  return Stack(
    children: state.props.listPlayer
        .map(
          (e) => Container(
            padding: const EdgeInsets.all(3),
            alignment: e.finishAlign,
            child: finishContent(context, state, e),
          ),
        )
        .toList(),
  );
}

Widget finishContent(
    BuildContext context, PlayGameState state, PlayerEntity entity) {
  return Stack(
    children: entity.finishedPieces
        .map(
          (e) => Image.asset(
            ColorList.getImage(e.warna),
            scale: 10,
            fit: BoxFit.contain,
          ),
        )
        .toList(),
  );
}
