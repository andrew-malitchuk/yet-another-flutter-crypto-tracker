import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';
import 'package:presentation_core_ui/layout/safe_scaffold.dart';
import 'package:presentation_core_ui/layout/scrollable_column.dart';
import 'package:presentation_core_ui/widget/header/header_divider_controller.dart';
import 'package:presentation_core_ui/widget/header/simple_header.dart';
import 'package:presentation_core_ui/widget/state/empty_state.dart';
import 'package:presentation_core_ui/widget/state/error_state.dart';
import 'package:presentation_feature_detalization/bloc/detalization_bloc.dart';
import 'package:presentation_feature_detalization/bloc/detalization_event.dart';
import 'package:presentation_feature_detalization/bloc/detalization_state.dart';

import 'core/components/widget/line_chart.dart';
import 'core/components/widget/loading_widget.dart';
import 'core/components/widget/stats.dart';
import 'core/components/widget/status.dart';

class DetalizationView extends StatefulWidget {
  final String coin;

  const DetalizationView({super.key, required this.coin});

  @override
  State<DetalizationView> createState() => _DetalizationViewState();
}

class _DetalizationViewState extends State<DetalizationView> {
  final HeaderDividerController headerDividerController =
      HeaderDividerController();

  @override
  void initState() {
    super.initState();

    context
        .read<DetalizationBloc>()
        .add(DetalizationLoadEvent(coin: widget.coin));
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
        appBar: SimpleHeader(
          headerDividerController: headerDividerController,
          title: null,
          onPressed: () {
            context.pop();
          },
        ),
        body: _buildView(context));
  }

  Widget _buildView(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return
        BlocBuilder<DetalizationBloc, DetalizationState>(
      bloc: context.read<DetalizationBloc>(),
      builder: (context, state) {
        switch (state) {
          case DetalizationErrorState():
            return ErrorState(onClick: null);
          case DetalizationLoadedState():
            return _buildContent(context, state);
          case DetalizationEmptyState():
            return EmptyState();
          default:
            return LoadingWidget();
        }
      },
    );
  }

  Widget _buildContent(BuildContext context, DetalizationLoadedState state) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return ScrollableColumn(
      onOverScroll: (isOverScroll) {
        headerDividerController.setVisibility(isOverScroll);
      },
      children: [
        Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${state.data?.name}/${state.data?.symbol}",
                    style: textTheme.ctaHighlight01
                        .copyWith(color: colorScheme.neutralN900),
                  ),
                  Text(
                    "\$${state.data?.priceUsd.toStringAsFixed(2)}",
                    style: textTheme.titleHighlight01
                        .copyWith(color: colorScheme.neutralN900),
                  ),
                  SizedBox(height: 6),
                  SvgPicture.asset("assets/icon/icon-exchange-24.svg",
                      package: "presentation_core_ui", width: 16, height: 16),
                  SizedBox(height: 4),
                  Text(
                    "1.00 ${state.data?.symbol}",
                    style: textTheme.caption02
                        .copyWith(color: colorScheme.neutralN900),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(left: 64, right: 8),
                              child: Status(
                                text:
                                    "${state.data?.changePercent24Hr.toStringAsFixed(2)}%",
                              ))),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(right: 64, left: 8),
                              child: Status(
                                text:
                                    "\$ ${(state.data?.vwap24Hr ?? 0.0).toStringAsFixed(2)}",
                              ))),
                    ],
                  ),
                  SizedBox(height: 16),
                  if (state.history == null || state.history!.isEmpty)
                    const SizedBox.shrink()
                  else
                    LineChartPrice(
                        history: state.history,
                        onSelect: (period) {
                          context.read<DetalizationBloc>().add(
                              DetalizationLoadHistoryEvent(period: period));
                        }),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      context.tr("marketStats"),
                      style: textTheme.titleHighlight01
                          .copyWith(color: colorScheme.neutralN900),
                    ),
                  ),
                  SizedBox(height: 8),
                  if (state.data != null)
                    Stats(asset: state.data!)
                  else
                    const SizedBox.shrink(),
                ],
              ),
            )),
      ],
    );
  }
}
