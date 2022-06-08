import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:vi_word/utils/enums.dart';

class AudioService {
  void playSound(Sound sound) {
    late final String fileDir;

    switch (sound) {
      case Sound.tapped:
        fileDir = 'assets/sounds/tap.mp3';
        break;
      case Sound.flipCards:
        fileDir = 'assets/sounds/flip_cards.mp3';
        break;
      default:
    }

    AssetsAudioPlayer.playAndForget(Audio(fileDir));
  }
}
