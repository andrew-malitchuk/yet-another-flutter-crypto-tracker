import 'dart:math';

import 'package:common_logger/logger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_core_ui/layout/safe_scaffold.dart';
import 'package:presentation_core_ui/widget/button/miscellaneous/sort_button.dart';
import 'package:presentation_core_ui/widget/card/account_card.dart';
import 'package:presentation_core_ui/widget/header/header_divider_controller.dart';
import 'package:presentation_core_ui/widget/header/portfolio_header.dart';
import 'package:presentation_core_ui/widget/item/action_item.dart';
import 'package:presentation_core_ui/widget/item/asset_item.dart';
import 'package:presentation_core_ui/widget/state/empty_state.dart';
import 'package:presentation_core_ui/widget/state/error_state.dart';
import 'package:presentation_core_ui/widget/state/loading_state.dart';
import 'package:presentation_feature_user_profile/core/navigation/user_profile_navigation.dart';
import 'package:presentation_feature_user_profile/user_profile_view.dart';

class PortfolioView extends StatefulWidget {
  const PortfolioView({super.key});

  @override
  State<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> with Logger {
  final HeaderDividerController headerDividerController =
      HeaderDividerController();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      headerDividerController.setVisibility(_scrollController.offset > 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
        appBar: PortfolioHeader(
            welcome: 'Welcome',
            username: 'User',
            onProfilePressed: () {
              UserProfileRoute().push(context);
            },
            headerDividerController: headerDividerController),
        body: _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return LoadingState();

    List<String> dynamicItems =
        List.generate(100, (index) => "Dynamic Item $index");

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: 2 + dynamicItems.length, // 2 static + N dynamic
          itemBuilder: (context, index) {
            if (index == 0) {
              return AccountCard(
                  balance: "123", address: "address", onClick: () {});
            } else if (index == 1) {
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(context.tr("portfolioYourAssets"),
                            style: textTheme.subtitleHighlight01
                                .copyWith(color: colorScheme.neutralN900)),
                        Spacer(),
                        SortButton(
                            sortByProperty: 'price',
                            isAscending: true,
                            onClick: () {
                              // Handle sort selection
                            })
                      ]));
            } else {
              final dynamicItem = dynamicItems[index - 2]; // offset by 2
              // return DynamicItemWidget(item: dynamicItem);
              return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: _buildSlidebleItem(context));
            }
          },
        ));
  }

  Widget _buildSlidebleItem(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [],
        ),

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            Padding(
                padding: EdgeInsets.only(left: 4),
                child: ActionItem(
                    name: "name",
                    icon: "assets/icon/icon-edit-24.svg",
                    foregroundColor: colorScheme.neutralN900,
                    onClick: () {})),
            Padding(
                padding: EdgeInsets.only(left: 4),
                child: ActionItem(
                    name: "name",
                    icon: "assets/icon/icon-delete-24.svg",
                    foregroundColor: colorScheme.errorN900,
                    onClick: () {})),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: AssetItem(
            name: "name", asset: "asset", price: 1.1, onClick: () {}));
  }
}
