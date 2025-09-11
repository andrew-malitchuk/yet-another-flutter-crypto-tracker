
import 'package:common_logger/logger.dart';
import 'package:domain_repository/entity/crypto_asset_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:presentation_feature_detalization/core/navigation/detalization_navigation.dart';
import 'package:presentation_feature_user_profile/core/navigation/user_profile_navigation.dart';

import '../dialog/add_dialog.dart';
import 'bloc/portfolio_bloc.dart';
import 'bloc/portfolio_event.dart';
import 'bloc/portfolio_state.dart';

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

    context.read<PortfolioBloc>().add(PortfolioLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return _buildView(context);
  }

  Widget _buildView(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocBuilder<PortfolioBloc, PortfolioState>(
      bloc: context.read<PortfolioBloc>(),
      builder: (context, state) {
        switch (state) {
          case PortfolioInitialState():
            return SafeScaffold(
                appBar: PortfolioHeader(
                    welcome: context.tr("portfolioWelcome"),
                    username: '',
                    onProfilePressed: () {
                      UserProfileRoute().push(context);
                    },
                    headerDividerController: headerDividerController),
                body: LoadingState());
          case PortfolioLoadingState():
            return SafeScaffold(
                appBar: PortfolioHeader(
                    welcome: context.tr("portfolioWelcome"),
                    username: '',
                    onProfilePressed: () {
                      UserProfileRoute().push(context);
                    },
                    headerDividerController: headerDividerController),
                body: LoadingState());
          case PortfolioErrorState():
            return ErrorState(onClick: null);
          case PortfolioLoadedState():
            return _buildContent(context, state);
          default:
            return SafeScaffold(
                appBar: PortfolioHeader(
                    welcome: context.tr("portfolioWelcome"),
                    username: '',
                    onProfilePressed: () {
                      UserProfileRoute().push(context);
                    },
                    headerDividerController: headerDividerController),
                body: EmptyState());
        }
      },
    );
  }

  Widget _buildContent(BuildContext context, PortfolioLoadedState data) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SafeScaffold(
        appBar: PortfolioHeader(
            welcome: context.tr("portfolioWelcome"),
            username: data.username,
            onProfilePressed: () {
              UserProfileRoute().push(context);
            },
            headerDividerController: headerDividerController),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: data.data.length + 2, // 2 static + N dynamic
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: AccountCard(
                          balance: data.sum,
                          address: "address",
                          onClick: () {}));
                } else if (index == 1) {
                  return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                  final dynamicItem = data.data[index - 2]; // offset by 2
                  // return DynamicItemWidget(item: dynamicItem);
                  return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: _buildSlidebleItem(context, dynamicItem));
                }
              },
            )));
  }

  Widget _buildSlidebleItem(BuildContext context, CryptoAssetEntity asset) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Slidable(
        // Specify a key if the Slidable is dismissible.
        key: ValueKey(asset.symbol),

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
                    name: context.tr("portfolioEdit"),
                    icon: "assets/icon/icon-edit-24.svg",
                    foregroundColor: colorScheme.neutralN900,
                    onClick: () {
                      showAddDialog(context, asset, (CryptoAssetEntity asset) {
                        context
                            .read<PortfolioBloc>()
                            .add(PortfolioEditAssetEvent(asset));
                      });
                    })),
            Padding(
                padding: EdgeInsets.only(left: 4),
                child: ActionItem(
                    name: context.tr("portfolioDelete"),
                    icon: "assets/icon/icon-delete-24.svg",
                    foregroundColor: colorScheme.errorN900,
                    onClick: () {
                      // Handle delete action
                      context
                          .read<PortfolioBloc>()
                          .add(PortfolioDeleteAssetEvent(asset.symbol));
                    })),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: AssetItem(
              name: asset.name,
              asset: asset.symbol,
              price: (asset.priceUsd * (asset.amount ?? 1.0)),
              changePercent24Hr: asset.changePercent24Hr,
              onClick: () => DetalizationRoute(coin: asset.name).push(context),
            )));
  }
}
