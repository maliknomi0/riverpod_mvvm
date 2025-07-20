import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  final String? screenName;
  const NotFoundScreen({this.screenName, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '404\n${screenName ?? 'Screen'} Not Found',
        style: const TextStyle(fontSize: 24, color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );
  }
}
