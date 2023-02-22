import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quranapp/data/classes/position_data.dart';
import 'package:quranapp/data/play_list/play_list.dart';
import 'package:quranapp/view/play_surah/widget/audio_progress_bar.dart';
import 'package:quranapp/view/play_surah/widget/media_meta_data.dart';
import 'package:rxdart/rxdart.dart';

import '../../controller/controls.dart';

class PlaySurah extends StatefulWidget {
  const PlaySurah({super.key});

  @override
  State<PlaySurah> createState() => _PlaySurahState();
}

class _PlaySurahState extends State<PlaySurah> with WidgetsBindingObserver {
  late AudioPlayer _audioPlayer;

  final _playList = PlayList.playList;
  Stream<PositionData> get _positionData =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferPosition, duration) =>
            PositionData(position, bufferPosition, duration ?? Duration.zero),
      );

  @override
  void initState() {
    _audioPlayer = AudioPlayer();

    _init();
    super.initState();
  }

  Future<void> _init() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(PlayList.playList);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _audioPlayer.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [Color(0xff144771), Color(0xff071A2C)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<SequenceState?>(
              stream: _audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state?.sequence.isEmpty ?? true) {
                  return const SizedBox();
                }
                final metaData = state!.currentSource!.tag as MediaItem;
                return MediaMetaData(
                    imageUrl: metaData.artUri.toString(),
                    title: metaData.title,
                    qaree: metaData.id);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<PositionData>(
              stream: _positionData,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return AudioProgressBar(
                    positionData: positionData, audioPlayer: _audioPlayer);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Controls(audioPlayer: _audioPlayer),
          ],
        ),
      ),
    );
  }
}
