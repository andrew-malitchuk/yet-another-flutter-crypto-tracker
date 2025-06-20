import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';

/// A widget that displays a splash loading animation with rotating icons and a title.
///
/// __References:__
///
/// - [Figma](https://www.figma.com/design/KTysYAkUWAyTTryh4IWzjU/Android-School-App-UI?node-id=35-8362&t=1zhRazG0UwwrXlUU-4)
class LoadingWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadingWidgetState();
}

// TODO wtf
class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  // TODO wtf
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  @override
  void initState() {
    super.initState();

    // Create AnimationControllers for continuous rotation
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 1_000), // Time for one rotation
      vsync: this,
    );

    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 1_000),
      vsync: this,
    );

    _controller3 = AnimationController(
      duration: const Duration(milliseconds: 1_000),
      vsync: this,
    );

    _startRepeatingController(_controller1);
    _startRepeatingController(_controller2);
    foo(_controller3);
  }

  void _startRepeatingController(AnimationController controller) {
    Future.delayed(const Duration(seconds: 1), () {
      controller.forward().then((_) {
        // Wait for 2 seconds before starting the next rotation
        Future.delayed(const Duration(seconds: 1), () {
          controller.repeat(); // Reverse the rotation
          // After reverse completes, start the next rotation forward again
          _startRepeatingController(controller);
        });
      });
    });
  }

  void foo(AnimationController controller) {
    Future.delayed(const Duration(seconds: 2), () {
      controller.forward().then((_) {
        // Wait for 2 seconds before starting the next rotation
        Future.delayed(const Duration(seconds: 1), () {
          controller.repeat(); // Reverse the rotation
          // After reverse completes, start the next rotation forward again
          _startRepeatingController(controller);
        });
      });
    });
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is removed from the widget tree
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Stack(
        children: [
          RotationTransition(
            turns: _controller1,
            child: SvgPicture.asset(
              width: 37,
              height: 32,
              'assets/icon/icon-splash-loading-1.svg',
              package: 'presentation_core_ui',
            ),
          ),
          AnimatedBuilder(
              animation: _controller3,
              builder: (context, child) {
                // Translate along Y axis in a sine wave pattern
                final double translateY = 5 *
                    (1 - (2 * (_controller3.value - 0.5)).abs()); // up and down
                return Transform.translate(
                  offset: Offset(0, translateY),
                  child: RotationTransition(
                    turns: _controller2,
                    child: SvgPicture.asset(
                      width: 37,
                      height: 32,
                      'assets/icon/icon-splash-loading-2.svg',
                      package: 'presentation_core_ui',
                    ),
                  ),
                );
              }),
        ],
      ),
    ]);
  }
}
