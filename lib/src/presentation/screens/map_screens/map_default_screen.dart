import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ludo_heroes/src/domain/entities/color_entity.dart';
import 'package:ludo_heroes/src/domain/entities/piece_entity.dart';
import 'package:ludo_heroes/src/domain/entities/player_entity.dart';
import 'package:ludo_heroes/src/domain/entities/step_entity.dart';
import 'package:ludo_heroes/src/presentation/blocs/play_game_bloc/play_game_bloc.dart';
import 'package:ludo_heroes/src/presentation/screens/map_screens/widgets/base_widget.dart';
import 'package:ludo_heroes/src/presentation/screens/map_screens/listener.dart';
import 'package:ludo_heroes/src/presentation/screens/map_screens/widgets/finish_widget.dart';
import 'package:ludo_heroes/src/presentation/screens/map_screens/widgets/player_widget.dart';
import 'package:ludo_heroes/src/presentation/screens/map_screens/widgets/step_widget.dart';
import 'package:ludo_heroes/src/utils/asset_images.dart';
import 'package:ludo_heroes/src/utils/list_data/color_list.dart';
import 'package:ludo_heroes/src/utils/list_data/dice_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapDefaultScreen extends StatefulWidget {
  const MapDefaultScreen({Key? key}) : super(key: key);

  @override
  State<MapDefaultScreen> createState() => _MapDefaultScreenState();
}

class _MapDefaultScreenState extends State<MapDefaultScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: BlocConsumer<PlayGameBloc, PlayGameState>(
        listener: (context, state) {
          listener(context, state);
        },
        builder: (context, PlayGameState state) {
          return Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: state.props.listPlayer
                        .where((element) => element.id <= 2)
                        .map((item) => playerItem(context, item, state))
                        .toList(),
                  ),
                ),
                SizedBox(
                  width: width,
                  height: width,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                color: Colors.red,
                                padding: const EdgeInsets.all(25),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: state.props.listPiece
                                            .where((element) =>
                                                element.warna == Warna.red &&
                                                element.id <= 2)
                                            .toList()
                                            .map((item) =>
                                                baseItem(context, item, state))
                                            .toList(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: state.props.listPiece
                                            .where((element) =>
                                                element.warna == Warna.red &&
                                                element.id > 2)
                                            .toList()
                                            .map((item) =>
                                                baseItem(context, item, state))
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: state.props.listStep
                                            .where((element) =>
                                                element.id >= 7 &&
                                                element.id <= 12)
                                            .toList()
                                            .reversed
                                            .map(
                                              (item) => stepWidget(
                                                  context, item, state),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: state.props.listStep
                                            .where((element) =>
                                                element.id == 13 ||
                                                (element.id >= 201 &&
                                                    element.id <= 205))
                                            .toList()
                                            .map(
                                              (item) => stepWidget(
                                                  context, item, state),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: state.props.listStep
                                            .where((element) =>
                                                element.id >= 14 &&
                                                element.id <= 19)
                                            .toList()
                                            .map(
                                              (item) => stepWidget(
                                                  context, item, state),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                color: Colors.blue,
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: state.props.listPiece
                                            .where((element) =>
                                                element.warna == Warna.blue &&
                                                element.id <= 6)
                                            .toList()
                                            .map((item) =>
                                                baseItem(context, item, state))
                                            .toList(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: state.props.listPiece
                                            .where((element) =>
                                                element.warna == Warna.blue &&
                                                element.id > 6)
                                            .toList()
                                            .map((item) =>
                                                baseItem(context, item, state))
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: state.props.listStep
                                            .where((element) =>
                                                element.id >= 1 &&
                                                element.id <= 6)
                                            .toList()
                                            .map(
                                              (item) => stepWidget(
                                                  context, item, state),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: state.props.listStep
                                            .where((element) =>
                                                element.id == 52 ||
                                                (element.id > 100 &&
                                                    element.id <= 105))
                                            .toList()
                                            .map(
                                              (item) => stepWidget(
                                                  context, item, state),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: state.props.listStep
                                            .where((element) =>
                                                element.id >= 46 &&
                                                element.id <= 51)
                                            .toList()
                                            .reversed
                                            .map(
                                              (item) => stepWidget(
                                                  context, item, state),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: double.maxFinite,
                                  height: double.maxFinite,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(AssetImages.finish),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: finishItem(context, state),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: state.props.listStep
                                            .where((element) =>
                                                element.id >= 20 &&
                                                element.id <= 25)
                                            .toList()
                                            .map(
                                              (item) => stepWidget(
                                                  context, item, state),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: state.props.listStep
                                            .where((element) =>
                                                element.id == 26 ||
                                                (element.id >= 401 &&
                                                    element.id <= 405))
                                            .toList()
                                            .reversed
                                            .map(
                                              (item) => stepWidget(
                                                  context, item, state),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: state.props.listStep
                                            .where((element) =>
                                                element.id >= 27 &&
                                                element.id <= 32)
                                            .toList()
                                            .reversed
                                            .map(
                                              (item) => stepWidget(
                                                  context, item, state),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  color: Colors.green,
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: state.props.listPiece
                                              .where((element) =>
                                                  element.warna ==
                                                      Warna.green &&
                                                  element.id <= 10)
                                              .toList()
                                              .map((item) => baseItem(
                                                  context, item, state))
                                              .toList(),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: state.props.listPiece
                                              .where((element) =>
                                                  element.warna ==
                                                      Warna.green &&
                                                  element.id > 10)
                                              .toList()
                                              .map((item) => baseItem(
                                                  context, item, state))
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: state.props.listStep
                                              .where((element) =>
                                                  element.id >= 40 &&
                                                  element.id <= 45)
                                              .toList()
                                              .reversed
                                              .map(
                                                (item) => stepWidget(
                                                    context, item, state),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: state.props.listStep
                                              .where((element) =>
                                                  element.id == 39 ||
                                                  (element.id >= 301 &&
                                                      element.id <= 305))
                                              .toList()
                                              .reversed
                                              .map(
                                                (item) => stepWidget(
                                                    context, item, state),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: state.props.listStep
                                              .where((element) =>
                                                  element.id >= 33 &&
                                                  element.id <= 38)
                                              .toList()
                                              .map(
                                                (item) => stepWidget(
                                                    context, item, state),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  color: Colors.yellow,
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: state.props.listPiece
                                              .where((element) =>
                                                  element.warna ==
                                                      Warna.yellow &&
                                                  element.id <= 14)
                                              .toList()
                                              .map((item) => baseItem(
                                                  context, item, state))
                                              .toList(),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: state.props.listPiece
                                              .where((element) =>
                                                  element.warna ==
                                                      Warna.yellow &&
                                                  element.id > 14)
                                              .toList()
                                              .map((item) => baseItem(
                                                  context, item, state))
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: state.props.listPlayer
                        .where((element) => element.id > 2)
                        .map((item) => playerItem(context, item, state))
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
