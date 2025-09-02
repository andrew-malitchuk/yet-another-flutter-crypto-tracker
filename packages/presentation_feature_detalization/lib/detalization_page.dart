import 'package:flutter/material.dart';

import 'detalization_view.dart';

class DetalizationPage extends StatelessWidget {
  final String coin;

  const DetalizationPage({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    return DetalizationView( coin: coin,);
  }
}
