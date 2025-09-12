import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:go_router/go_router.dart";
import "package:presentation_core_styling/color/custom_color_theme.dart";
import "package:presentation_core_styling/typography/custom_text_theme.dart";

import "core/navigation/home_navigation.dart";

class HomeView extends StatefulWidget {
  final Widget child;

  const HomeView({super.key, required this.child});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final bool _showAskPersonalDataDialog = true;

  @override
  void initState() {
    super.initState();
    if (_showAskPersonalDataDialog) {
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   showAskPersonalDataDialog(context);
      //   setState(() {
      //     _showAskPersonalDataDialog = false;
      //   });
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
        body: widget.child,
        bottomNavigationBar: _buildNavigationBar(_currentIndex));
  }

  // todo wtf
  int get _currentIndex {
    final location = GoRouterState.of(context).uri.toString();
    return switch (location) {
      var l when l.contains("/portfolio") => 2,
      var l when l.contains("/market") => 0,
      _ => 1,
    };
  }

  Widget _buildNavigationBar(int currentIndex) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BottomNavigationBar(
      unselectedLabelStyle:
          textTheme.ctaMedium02.copyWith(color: colorScheme.neutralN900),
      selectedLabelStyle:
          textTheme.ctaMedium02.copyWith(color: colorScheme.primaryN900),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            const MarketRoute().go(context);
            break;
          case 1:
            const AddNewCoinRoute().go(context);
            break;
          case 2:
            const PortfolioRoute().go(context);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(
            "assets/icon/icon-list-active-24.svg",
            package: "presentation_core_ui",
            width: 24,
            height: 24,
            colorFilter:
                ColorFilter.mode(colorScheme.primaryN900, BlendMode.srcIn),
          ),
          icon: SvgPicture.asset(
            "assets/icon/icon-list-24.svg",
            package: "presentation_core_ui",
            width: 24,
            height: 24,
            colorFilter:
                ColorFilter.mode(colorScheme.neutralN900, BlendMode.srcIn),
          ),
          label: context.tr("tabMarket"),
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(
            "assets/icon/icon-add-active-24.svg",
            package: "presentation_core_ui",
            width: 24,
            height: 24,
          ),
          icon: SvgPicture.asset(
            "assets/icon/icon-add-24.svg",
            package: "presentation_core_ui",
            width: 24,
            height: 24,
            colorFilter:
            ColorFilter.mode(colorScheme.neutralN900, BlendMode.srcIn),
          ),
          label: context.tr("tabAdd"),
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(
            "assets/icon/icon-wallet-active-24.svg",
            package: "presentation_core_ui",
            width: 24,
            height: 24,
            colorFilter:
                ColorFilter.mode(colorScheme.primaryN900, BlendMode.srcIn),
          ),
          icon: SvgPicture.asset(
            "assets/icon/icon-wallet-24.svg",
            package: "presentation_core_ui",
            width: 24,
            height: 24,
            colorFilter:
                ColorFilter.mode(colorScheme.neutralN900, BlendMode.srcIn),
          ),
          label: context.tr("tabPortfolio"),
        ),
      ],
    );
  }
}
