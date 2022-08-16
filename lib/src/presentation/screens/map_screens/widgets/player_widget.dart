import 'package:flutter/material.dart';
import 'package:ludo_heroes/src/domain/entities/player_entity.dart';
import 'package:ludo_heroes/src/domain/entities/turn_entity.dart';
import 'package:ludo_heroes/src/presentation/blocs/play_game_bloc/play_game_bloc.dart';
import 'package:ludo_heroes/src/utils/asset_gifs.dart';
import 'package:ludo_heroes/src/utils/list_data/color_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_heroes/src/utils/list_data/dice_list.dart';
import 'package:ludo_heroes/src/utils/parameter_value.dart';
import 'package:ludo_heroes/src/utils/list_data/turn_list.dart';

Widget playerItem(
    BuildContext context, PlayerEntity item, PlayGameState state) {
  return Expanded(
    child: Column(
      children: [
        if (item.id > 2) _turnItem(item, state),
        Expanded(
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(10),
            color: ColorList.getColor(item.warna),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      color: Colors.white,
                      child: Image.asset(
                        ColorList.getImage(item.warna),
                        scale: 3,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(20),
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            if (state.props.currentTurn.warna == item.warna &&
                                state.props.currentTurn.turn == Turn.standBy) {
                              BlocProvider.of<PlayGameBloc>(context)
                                  .add(BeginRollEvent());
                            }
                          },
                          child: Image.asset(_image(item, state)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (item.id < 3) _turnItem(item, state),
      ],
    ),
  );
}

String _image(PlayerEntity item, PlayGameState state) {
  if (state.props.currentTurn.warna == item.warna) {
    return state.props.currentTurn.turn == Turn.beginRoll
        ? AssetGifs.rollDice
        : DiceList.getImage(item.value);
  } else {
    return DiceList.getImage(item.value);
  }
}

_turnItem(PlayerEntity item, PlayGameState state) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: ColorList.getColor(item.warna), width: 5),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            currentWarna(state) == item.warna ? 'Your Turn' : '',
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Text(
            currentWarna(state) == item.warna
                ? TurnList.turnName(currentTurn(state))
                : '',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
