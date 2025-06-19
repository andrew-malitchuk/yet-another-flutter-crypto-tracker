import 'package:flutter/material.dart';

import '../loader/loading_widget.dart';
import '../loader/splash_loading_widget.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(padding: EdgeInsets.all(8), child: LoadingWidget()));
  }
}
