import 'package:flutter/material.dart';
import 'package:ludo_heroes/src/presentation/blocs/play_game_bloc/play_game_bloc.dart';
import 'package:ludo_heroes/src/presentation/routes.dart';
import 'package:ludo_heroes/src/presentation/screens/map_screens/map_default_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ludo_heroes/src/utils/const/routes_const.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PlayGameBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesConst.splashScreen,
        onGenerateRoute: Routes().onGenerateRoute,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
      ),
    );
  }
}
