import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_demo/widgets/fullscreen_widget.dart';

import '../utils/formatter.dart';

class BottomVideoControls extends StatelessWidget {
  final VideoPlayerController controller;
  final void Function()? onVolumeBtnTap;
  final bool hasMuted;
  const BottomVideoControls(
      {super.key,
      required this.controller,
      this.onVolumeBtnTap,
      required this.hasMuted});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        VideoProgressIndicator(controller, allowScrubbing: true),
        Row(
          children: [
            ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, child) {
                return Text(
                  " ${formatDuration(controller.value.position)} / ${formatDuration(controller.value.duration)}",
                  style: const TextStyle(color: Colors.white),
                );
              },
            ),
            const SizedBox(width: 10),
            InkWell(
                onTap: onVolumeBtnTap,
                child: Icon(
                  hasMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                  size: 20,
                )),
            const Spacer(),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return VideoPlayerFullscreenWidget(
                          controller: controller);
                    },
                  ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Icon(
                    Icons.fullscreen,
                    size: 20,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
