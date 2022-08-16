import 'package:ludo_heroes/src/domain/entities/color_entity.dart';
import 'package:ludo_heroes/src/domain/entities/piece_entity.dart';
import 'package:ludo_heroes/src/domain/entities/player_entity.dart';
import 'package:ludo_heroes/src/domain/entities/step_entity.dart';
import 'package:ludo_heroes/src/domain/entities/turn_entity.dart';
import 'package:ludo_heroes/src/utils/list_data/piece_list.dart';
import 'package:ludo_heroes/src/utils/list_data/player_list.dart';
import 'package:ludo_heroes/src/utils/list_data/step_list.dart';

class PlayGameParameter {
  List<PlayerEntity> listPlayer = [];
  List<StepEntity> listStep = [];
  List<PieceEntity> listPiece = [];
  List<Warna> finishedPlayer = [];
  CurrentTurn currentTurn = CurrentTurn(
    warna: Warna.red,
    turn: Turn.standBy,
  );

  PlayGameParameter() {
    listPlayer = PlayerList.getData();
    listStep = StepList.getData();
    listPiece = PieceList.getData();
    currentTurn = CurrentTurn(
      warna: Warna.red,
      turn: Turn.standBy,
    );
    for (int i = 0; i < listPlayer.length; i++) {
      listPlayer[i].basePieces.addAll(listPiece
          .where((element) => element.warna == listPlayer[i].warna)
          .toList());
    }
  }
}
