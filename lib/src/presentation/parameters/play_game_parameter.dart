import 'package:ludo_heroes/src/domain/entities/color_entity.dart';
import 'package:ludo_heroes/src/domain/entities/piece_entity.dart';
import 'package:ludo_heroes/src/domain/entities/player_entity.dart';
import 'package:ludo_heroes/src/domain/entities/step_entity.dart';
import 'package:ludo_heroes/src/domain/entities/turn_entity.dart';
import 'package:ludo_heroes/src/utils/list_data/piece_list.dart';
import 'package:ludo_heroes/src/utils/list_data/player_list.dart';
import 'package:ludo_heroes/src/utils/list_data/step_list.dart';

enum ChoosePlayer { four, two }

class PlayGameParameter {
  List<PlayerEntity> listPlayer = [];
  List<StepEntity> listStep = [];
  List<PieceEntity> listPiece = [];
  List<Warna> finishedPlayer = [];
  late CurrentTurn currentTurn;

  PlayGameParameter({ChoosePlayer choosePlayer = ChoosePlayer.four}) {
    if (choosePlayer == ChoosePlayer.four) {
      _fourPlayer();
    } else {
      _twoPlayer();
    }
  }

  void _initial() {
    listPlayer = PlayerList.getData();
    listStep = StepList.getData();
    listPiece = PieceList.getData();
    currentTurn = CurrentTurn(
      warna: Warna.red,
      turn: Turn.standBy,
    );
  }

  void _fourPlayer() {
    _initial();
    for (int i = 0; i < listPlayer.length; i++) {
      listPlayer[i].basePieces.addAll(listPiece
          .where((element) => element.warna == listPlayer[i].warna)
          .toList());
    }
  }

  void _twoPlayer() {
    _initial();
    List<Warna> notPlayer = [Warna.blue, Warna.green];
    finishedPlayer.addAll(notPlayer);
    print(finishedPlayer);
    for (int i = 0; i < listPlayer.length; i++) {
      if (listPlayer[i].warna != notPlayer[0] &&
          listPlayer[i].warna != notPlayer[1]) {
        listPlayer[i].basePieces.addAll(listPiece
            .where((element) => element.warna == listPlayer[i].warna)
            .toList());
      }
    }
  }
}
