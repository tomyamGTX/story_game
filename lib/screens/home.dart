import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/loading.provider.dart';
import '../widgets/dialog.text.dart';
import '../widgets/exit_app.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AssetsAudioPlayer _assetsAudioPlayer;
  bool play = true;
  bool loading = true;

  var submitTextStyle = GoogleFonts.nunito(
      fontSize: 28,
      letterSpacing: 5,
      color: Colors.white,
      fontWeight: FontWeight.w300);

  @override
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    _assetsAudioPlayer.open(
      Audio.network(
          "https://firebasestorage.googleapis.com/v0/b/emailandphoneauth-6ab6d.appspot.com/o/music%2FSpy%20x%20Family%20Opening%20Full%20Song%20_%20Mixed%20Nuts%20-%20Official%20HIGE%20DANdism.mp3?alt=media&token=4022718a-7e1d-452a-ab6e-f46c2cd8b495"),
      autoStart: false,
      showNotification: true,
    );
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        loading = !loading;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _assetsAudioPlayer.stop();
    _assetsAudioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadProvider>(builder: (context, load, _) {
      if (load.finish) {
        return Scaffold(
            backgroundColor: Colors.blueGrey,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(width: 20.0, height: 100.0),
                        Text(
                          'THANKS FOR',
                          style: GoogleFonts.amarante(fontSize: 43),
                        ),
                        const SizedBox(width: 20.0, height: 100.0),
                        DefaultTextStyle(
                          style: GoogleFonts.amarante(fontSize: 40),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              RotateAnimatedText('PLAYING'),
                              RotateAnimatedText('READING'),
                              RotateAnimatedText('WATCHING'),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedButton(
                    height: 70,
                    width: 300,
                    text: 'READ AGAIN',
                    isReverse: true,
                    selectedTextColor: Colors.black,
                    transitionType: TransitionType.LEFT_TO_RIGHT,
                    textStyle: submitTextStyle,
                    backgroundColor: Colors.black,
                    borderColor: Colors.white,
                    borderRadius: 24,
                    borderWidth: 2,
                    onPress: () {
                      load.reset();
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        load.reset();
                        Navigator.pop(context);
                      },
                      child: Text(
                        'CLOSE',
                        style: submitTextStyle,
                      ))
                ],
              ),
            ));
      }
      return Scaffold(
        body: Stack(
          children: [
            Image.asset(
              load.data[load.index]['image'],
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(play ? Icons.volume_mute : Icons.volume_up),
                  onPressed: () async {
                    setState(() {});
                    play = !play;
                    _assetsAudioPlayer.playOrPause();
                  },
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
                child: exitApp(),
              ),
            ),
            Visibility(
              visible: load.visible,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int num = 0;
                        num < load.data[load.index]['option'].length;
                        num++)
                      InkWell(
                        onTap: () => setState(() {
                          // i++;
                          Provider.of<LoadProvider>(context, listen: false)
                              .changeVal();
                        }),
                        child: Card(
                          color: Colors.amber,
                          shape: const StadiumBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              load.data[load.index]['option'][num],
                              style: GoogleFonts.abel(fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const Align(alignment: Alignment.bottomCenter, child: DialogText()),
          ],
        ),
      );
    });
  }
}
