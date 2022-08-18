import 'package:audioplayers/audioplayers.dart';

class SoundEffects {
  static AudioPlayer audioPlayer = AudioPlayer();

  static audio(String source) async {
    audioPlayer = AudioPlayer();
    audioPlayer.setPlayerMode(PlayerMode.lowLatency);
    audioPlayer.audioCache.loadedFiles;
    audioPlayer.play(AssetSource(source));
    audioPlayer.release();
  }
}
