import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quranapp/core/constant/my_text.dart';

class PlayList {
  static final playList = ConcatenatingAudioSource(
    children: [
      AudioSource.uri(
        Uri.parse('https://server6.mp3quran.net/s_bud/001.mp3'),
        tag: MediaItem(
          id: '1',
          artUri: Uri.parse(MyText.qareeImg),
          title: 'الفاتحة',
        ),
      ),
      AudioSource.uri(
        Uri.parse('https://server6.mp3quran.net/s_bud/002.mp3'),
        tag: MediaItem(
          id: '2',
          artUri: Uri.parse(MyText.qareeImg),
          title: 'البقرة',
        ),
      ),
      AudioSource.uri(
        Uri.parse('https://server6.mp3quran.net/s_bud/003.mp3'),
        tag: MediaItem(
          id: '3',
          artUri: Uri.parse(MyText.qareeImg),
          title: 'آل عمران',
        ),
      ),
      AudioSource.uri(
        Uri.parse('https://server6.mp3quran.net/s_bud/004.mp3'),
        tag: MediaItem(
          id: '4',
          artUri: Uri.parse(MyText.qareeImg),
          title: 'النساء',
        ),
      ),
    ],
  );
}
