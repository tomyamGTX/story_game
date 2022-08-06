import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_gifs/loading_gifs.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Flexible(
            child: FadeInImage.assetNetwork(
                placeholder: cupertinoActivityIndicator,
                image:
                    "https://64.media.tumblr.com/3fd429c72150af7920248ac6f44f1dc4/5a24f23b04fd2387-13/s500x750/afb395deec8f816c68db76024e1656964339ac73.gifv"),
          ),
          Text(
            'Loading...',
            style: GoogleFonts.adamina(),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
