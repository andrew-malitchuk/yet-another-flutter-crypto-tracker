import 'package:flutter/material.dart';

class ScrollableColumn extends StatefulWidget {
  final ValueChanged<bool> onOverScroll;

  final List<Widget> children;

  const ScrollableColumn({
    super.key,
    required this.onOverScroll,
    required this.children,
  });

  @override
  State<StatefulWidget> createState() => _ScrollableColumnState();
}

class _ScrollableColumnState extends State<ScrollableColumn> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      widget.onOverScroll(_scrollController.offset != 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: widget.children,
      ),
    );
  }
}
