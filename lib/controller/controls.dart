import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Controls extends StatelessWidget {
  const Controls({super.key, required this.audioPlayer});
  final AudioPlayer audioPlayer;

  void showSliderDialog({
    required BuildContext context,
    required String title,
    required int divisions,
    required double min,
    required double max,
    String valueSuffix = '',
    // TODO: Replace these two by ValueStream.
    required double value,
    required Stream<double> stream,
    required ValueChanged<double> onChanged,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey,
        title: Text(title, textAlign: TextAlign.center),
        content: StreamBuilder<double>(
          stream: stream,
          builder: (context, snapshot) => SizedBox(
            height: 90.0,
            child: Column(
              children: [
                Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                    style: const TextStyle(
                        fontFamily: 'Fixed',
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0)),
                Slider(
                  activeColor: Colors.red,
                  thumbColor: Colors.grey,
                  divisions: divisions,
                  min: min,
                  max: max,
                  value: snapshot.data ?? value,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: audioPlayer.seekToPrevious,
                color: Colors.white,
                iconSize: 60,
                icon: const Icon(Icons.skip_previous_rounded),
              ),
              StreamBuilder<PlayerState>(
                stream: audioPlayer.playerStateStream,
                builder: (context, snapshot) {
                  final playState = snapshot.data;
                  final processingState = playState?.processingState;
                  final playing = playState?.playing;
                  // if not playing
                  if (processingState == ProcessingState.loading ||
                      processingState == ProcessingState.buffering) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 64.0,
                      height: 64.0,
                      child: const CircularProgressIndicator(),
                    );
                  } else if (!(playing ?? false)) {
                    return IconButton(
                      onPressed: audioPlayer.play,
                      color: Colors.white,
                      iconSize: 80,
                      icon: const Icon(Icons.play_arrow_rounded),
                    );
                  }
                  // if it's playing
                  else if (processingState != ProcessingState.completed) {
                    return IconButton(
                      onPressed: audioPlayer.pause,
                      color: Colors.white,
                      iconSize: 80,
                      icon: const Icon(Icons.pause_rounded),
                    );
                  }
                  return const Icon(
                    Icons.play_arrow_rounded,
                    size: 80,
                    color: Colors.white,
                  );
                },
              ),
              IconButton(
                onPressed: audioPlayer.seekToNext,
                color: Colors.white,
                iconSize: 60,
                icon: const Icon(Icons.skip_next_rounded),
              ),

              //speed
            ],
          ),
          StreamBuilder<double>(
            stream: audioPlayer.speedStream,
            builder: (context, snapshot) => IconButton(
              icon: Text(
                "${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () {
                showSliderDialog(
                  context: context,
                  title: "Adjust speed",
                  divisions: 10,
                  min: 0.5,
                  max: 1.5,
                  value: audioPlayer.speed,
                  stream: audioPlayer.speedStream,
                  onChanged: audioPlayer.setSpeed,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
