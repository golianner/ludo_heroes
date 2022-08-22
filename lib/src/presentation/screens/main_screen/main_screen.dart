import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_heroes/src/presentation/blocs/play_game_bloc/play_game_bloc.dart';
import 'package:ludo_heroes/src/presentation/parameters/play_game_parameter.dart';
import 'package:ludo_heroes/src/utils/const/routes_const.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _choosePlayer(ChoosePlayer choosePlayer) {
    BlocProvider.of<PlayGameBloc>(context).add(
      ChoosePlayerCount(choosePlayer: choosePlayer),
    );
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesConst.mapDefaultScreen, (route) => false);
  }

  Widget _button(String title, Color color, ChoosePlayer choosePlayer) {
    return InkWell(
      onTap: () {
        _choosePlayer(choosePlayer);
      },
      child: Container(
        color: color,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(10),
        width: double.maxFinite,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ludo Heroes'),
            const SizedBox(height: 10),
            _button('4 Players', Colors.red, ChoosePlayer.four),
            const SizedBox(height: 10),
            _button('2 Players', Colors.blue, ChoosePlayer.two),
          ],
        ),
      ),
    );
  }
}
