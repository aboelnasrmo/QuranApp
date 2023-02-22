import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../data/classes/position_data.dart';

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({
    super.key,
    required this.positionData,
    required AudioPlayer audioPlayer,
  }) : _audioPlayer = audioPlayer;

  final PositionData? positionData;
  final AudioPlayer _audioPlayer;

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      progress: positionData?.position ?? Duration.zero,
      buffered: positionData?.bufferPosition ?? Duration.zero,
      total: positionData?.duration ?? Duration.zero,
      onSeek: _audioPlayer.seek,
      progressBarColor: Colors.red,
      bufferedBarColor: Colors.grey,
      timeLabelTextStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      barHeight: 8,
      baseBarColor: Colors.grey,
      thumbColor: Colors.red,
    );
  }
}
