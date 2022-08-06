import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:dating_game/providers/loading.provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'loading.dart';

class DialogText extends StatefulWidget {
  const DialogText({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogText> createState() => _DialogTextState();
}

class _DialogTextState extends State<DialogText> {
  late bool loading;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadProvider>(builder: (context, load, _) {
      load.delay();
      return load.loading
          ? const Loading()
          : BlurryContainer(
              blur: 5,
              width: MediaQuery.of(context).size.width * 0.6,
              height: 80,
              elevation: 1,
              color: Colors.transparent,
              padding: const EdgeInsets.all(8),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Center(
                child: ListTile(
                  title: Text(
                    load.data[load.index]['person'],
                    style: GoogleFonts.adamina(
                        fontSize: 24,
                        color: Theme.of(context).primaryColorLight),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: DefaultTextStyle(
                      style: const TextStyle(),
                      child: AnimatedTextKit(
                        repeatForever: false,
                        totalRepeatCount: 1,
                        animatedTexts: [
                          for (int i = 0;
                              i < load.data[load.index]['dialog'].length;
                              i++)
                            TypewriterAnimatedText(
                                load.data[load.index]['dialog'][i].toString(),
                                textStyle: GoogleFonts.adamina(fontSize: 20),
                                speed: const Duration(milliseconds: 100)),
                        ],
                        onTap: () {
                          setState(() {
                            loading = !loading;
                            Future.delayed(const Duration(seconds: 3), () {
                              setState(() {});
                              loading = !loading;
                            });
                          });
                        },
                        onFinished: () {
                          load.visibile();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
    });
  }
}
