import 'package:flutter/material.dart';

class exitApp extends StatelessWidget {
  const exitApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.exit_to_app),
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Do you want to exit?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      // SystemChannels.platform
                      //     .invokeMethod('SystemNavigator.pop');
                    },
                    child: const Text('Yes'))
              ],
            );
          },
        );
      },
    );
  }
}
