import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class LiquidDownload extends StatefulWidget {
  const LiquidDownload({Key? key}) : super(key: key);

  @override
  _LiquidDownloadState createState() => _LiquidDownloadState();
}

class _LiquidDownloadState extends State<LiquidDownload> {
  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;

  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<bool>? _start;
  SMIInput<double>? _progress;

  @override
  void initState() {
    super.initState();
    rootBundle.load('assets/new_file_.riv').then(
      (data) async {
        final file = RiveFile.import(data);

        final artboard = file.mainArtboard;
        var controller =
            StateMachineController.fromArtboard(artboard, 'Download');
        if (controller != null) {
          artboard.addController(controller);
          _start = controller.findInput('Download');
          _progress = controller.findInput('Progress');
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Liquid Download'),
      ),
      body: Center(
        child: _riveArtboard == null
            ? const SizedBox()
            : GestureDetector(
                onTapDown: (_) => _start?.value = true,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Press to activate, slide for progress...',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Slider(
                      value: _progress!.value,
                      min: 0,
                      max: 100,
                      label: _progress!.value.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _progress!.value = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Rive(
                        artboard: _riveArtboard!,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
