import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import '../tts.dart'; // TTS 클래스를 정의한 파일을 import하세요.
import '../StepData.dart';

import '../../providers/Scenario_Manager.dart';
import 'package:rive/rive.dart' hide Image;

AudioPlayer _audioPlayer = AudioPlayer();
TTS tts = TTS();

class Scenario_hurt_13_left extends StatefulWidget {
  const Scenario_hurt_13_left({super.key});

  @override
  State<Scenario_hurt_13_left> createState() =>
      _Scenario_hurt_13_leftState();
}

class _Scenario_hurt_13_leftState
    extends State<Scenario_hurt_13_left> {
  void initState() {
    super.initState();
    _playWelcomeTTS();
  }

  Future<void> _playWelcomeTTS() async {
    await _audioPlayer.play(AssetSource("effect_ascending.mp3"));

    await tts.TextToSpeech(
        "축하합니다. "
            "모든 이야기를 마치셨습니다. 이번 경험을 바탕으로 "
            "상처가 났을 떄 어떻게 행동해야 할지 "
            "잘 생각해보시기 바랍니다.",
        "ko-KR-Wavenet-D");
    await tts.player.onPlayerComplete.first;
    tts.dispose();

    Provider.of<Scenario_Manager>(context, listen: false).increment_flag();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        // Container의 borderRadius와 동일하게 설정
        child: RiveAnimation.asset(
          "assets/common/firework.riv",
          fit: BoxFit.contain,
        ));
  }
}

class Scenario_hurt_13_right extends StatefulWidget {
  const Scenario_hurt_13_right({super.key});

  @override
  State<Scenario_hurt_13_right> createState() =>
      _Scenario_hurt_13_rightState();
}

class _Scenario_hurt_13_rightState
    extends State<Scenario_hurt_13_right> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
            Provider.of<Scenario_Manager>(context, listen: false).flag == 1
                ? ElevatedButton(
              onPressed: () {
                Provider.of<Scenario_Manager>(context, listen: false)
                    .decrement_flag();
                Navigator.pop(context);
              },
              child: Text(
                "나가기",
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.center,

                //오디오 멈추는 작업 하기
              ),
            )
                : const Text("먼저 설명을 들어보세요!")));
  }
}