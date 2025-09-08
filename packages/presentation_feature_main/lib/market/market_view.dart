
import 'package:common_logger/logger.dart';
import 'package:domain_repository/entity/crypto_asset_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_core_ui/layout/safe_scaffold.dart';
import 'package:presentation_core_ui/miscellaneous/util/custom_debounce.dart';
import 'package:presentation_core_ui/widget/header/header_divider_controller.dart';
import 'package:presentation_core_ui/widget/header/search_header.dart';
import 'package:presentation_core_ui/widget/item/asset_item.dart';
import 'package:presentation_core_ui/widget/item/loading_item.dart';
import 'package:presentation_core_ui/widget/state/empty_state.dart';
import 'package:presentation_core_ui/widget/state/error_state.dart';
import 'package:presentation_core_ui/widget/state/loading_state.dart';
import 'package:presentation_feature_detalization/core/navigation/detalization_navigation.dart';
import 'package:presentation_feature_main/market/bloc/market_bloc.dart';
import 'package:presentation_feature_main/market/bloc/market_state.dart';

import '../dialog/sort_dialog.dart';
import 'bloc/market_event.dart';

class MarketView extends StatefulWidget {
  const MarketView({super.key});

  @override
  State<MarketView> createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> with Logger {
  final CustomDebounce debounce =
      CustomDebounce(delay: const Duration(seconds: 2));
  final ScrollController _scrollController = ScrollController();
  final HeaderDividerController _headerDividerController =
      HeaderDividerController();

  @override
  void initState() {
    super.initState();

    context.read<MarketBloc>().add(MarketLoadEvent());

    _scrollController.addListener(() {
      _headerDividerController.setVisibility(_scrollController.offset > 0.0);

      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData(context);
      }
    });
  }

  void _getMoreData(BuildContext context) {
    context.read<MarketBloc>().add(MarketLoadMoreEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
        appBar: SearchHeader(
          hint: context.tr("generalSearch"),
          headerDividerController: _headerDividerController,
          onChanged: _onChange,
          onSortClick: _onSortClick,
        ),
        body: _buildView(context));
  }

  Widget _buildView(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return // TODO wtf
        BlocBuilder<MarketBloc, MarketState>(
      bloc: context.read<MarketBloc>(),
      builder: (context, state) {
        switch (state) {
          case MarketInitialState():
            return LoadingState();
          case MarketLoadingState():
            return LoadingState();
          case MarketErrorState():
            return ErrorState(onClick: null);
          case MarketLoadedState():
            return _buildContent(context, state.data);
          case MarketEmptyState():
            return EmptyState();
        }
      },
    );
  }

  Widget _buildContent(BuildContext context, List<CryptoAssetEntity> data) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: data.length,
      itemBuilder: (context, i) {
        if (i == data.length - 1) {
          return LoadingItem();
        }

        final asset = data[i];
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: AssetItem(
            name: asset.name,
            asset: asset.symbol,
            price: asset.priceUsd,
            changePercent24Hr: asset.changePercent24Hr,
            onClick: () => DetalizationRoute(coin: asset.name).push(context),
          ),
        );
      },
    );
  }

  void _onChange(String value) {
    debounce(
      () async {
        debug("Search value: $value");
        context.read<MarketBloc>().add(MarketSearchEvent(value));
      },
    );
  }

  void _onSortClick() {
    showSortDialog(context, (selectedItems, selectedItem) {});
  }
}
