import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Story Game'),
      ),
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()));
            },
            child: Row(
              children: [
                Spacer(),
                CircleAvatar(
                  radius: 120,
                  backgroundColor: Theme.of(context).primaryColorLight,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/images/home.jpg",
                            ))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Theme.of(context).primaryColorDark),
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'SPY X FAMILY',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.abel(fontSize: 40),
                      ),
                      Text(
                        'By Hakimi',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.abel(fontSize: 30),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          );
        },
        itemCount: 2,
        pagination: const SwiperPagination(),
        control: const SwiperControl(size: 80),
      ),
    );
  }
}
