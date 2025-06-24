import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_core_ui/widget/loader/splash_loading_widget.dart';
import 'package:presentation_feature_main/core/navigation/home_navigation.dart';
import 'package:presentation_feature_welcome/core/navigation/welcome_navigation.dart';

import 'bloc/splash_cubit.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

// TODO: wtf
class _SplashViewState extends State<SplashView> {
  late final SplashCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = SplashCubit(context.read());
    _cubit.initializeApp();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          switch (state.status) {
            case SplashStatus.goToUserDetails:
              WelcomeRoute().push(context);
            case SplashStatus.goToMarket:
              MarketRoute().go(context);
            default:
              break;
          }
        },
        child: Scaffold(
          body: Center(
            child: BlocBuilder<SplashCubit, SplashState>(
              builder: (context, state) {
                return SplashLoadingWidget();
              },
            ),
          ),
        ),
      ),
    );
  }
}
