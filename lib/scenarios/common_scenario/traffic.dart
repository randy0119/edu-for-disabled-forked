import 'package:flutter/material.dart';
import 'package:flutterpractice/scenarios/tts.dart';
import 'package:provider/provider.dart';
import '../../providers/Scenario_Manager.dart';

import 'package:rive/rive.dart' hide Image;

final tts = TTS();

class Traffic_left extends StatefulWidget {
  const Traffic_left({super.key});

  @override
  State<Traffic_left> createState() => _Traffic_leftState();
}

class _Traffic_leftState extends State<Traffic_left> {
  @override
  void initState() {
    super.initState();
    _playWelcomeTTS();
  }

  Future<void> _playWelcomeTTS() async {
    await tts.TextToSpeech("오른쪽 화면에 나와 있는 문을 터치해서 열고 들어가보세요"
        "!", "ko-KR-Wavenet-D");
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      // Container의 borderRadius와 동일하게 설정
      child: const Image(
        image: AssetImage("assets/common/elevator.png"),
        fit: BoxFit.cover, // 이미지가 Container에 꽉 차도록 설정
      ),
    );
  }
}

class Traffic_right extends StatefulWidget {
  const Traffic_right({super.key});

  @override
  State<Traffic_right> createState() => _Traffic_rightState();
}

class _Traffic_rightState extends State<Traffic_right> {
  SMITrigger? _touch;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
      onStateChange: _onStateChange,
    );

    if (controller != null) {
      artboard.addController(controller);
      _touch = controller.findInput<SMITrigger>('touch') as SMITrigger?;
    }
  }

  void _hitBump() {

    _touch?.fire();

    print("Touch TRIGGERED!");
  }

  void _onStateChange(String stateMachineName, String stateName) {
    if (stateName == 'exit') {
      Provider.of<Scenario_Manager>(context, listen: false).updateIndex();
      print("EXIT");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: [
          GestureDetector(
            onTap: _hitBump,
            child: RiveAnimation.asset(
              "assets/elevator_door.riv",
              fit: BoxFit.contain,
              onInit: _onRiveInit,
            ),
          ),
          ElevatedButton(
              onPressed: (){
                Provider.of<Scenario_Manager>(context,listen: false).updateIndex();
              },
              child: Text("강제 화면 넘기기")
          )
        ]),
      ),
    );
  }
}
