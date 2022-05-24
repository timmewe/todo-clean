import 'package:flutter/material.dart';

class LoadingDisplay extends StatelessWidget {
  const LoadingDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
