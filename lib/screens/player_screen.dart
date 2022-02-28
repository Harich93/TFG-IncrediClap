import 'package:flutter/material.dart';

class PlayerScreen extends StatelessWidget {

static const String routeName = 'Player';

  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('PlayerScreen'),
      ),
    );
  }

}