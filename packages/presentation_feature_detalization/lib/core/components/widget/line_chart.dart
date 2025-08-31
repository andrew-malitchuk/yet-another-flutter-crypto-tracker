import 'package:domain_repository/entity/history_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:presentation_core_styling/color/custom_color_theme.dart';
import 'package:presentation_core_styling/typography/custom_text_theme.dart';

class LineChartPrice extends StatefulWidget {
  const LineChartPrice({super.key, this.history, this.onSelect});

  final void Function(LineChartPeriod)? onSelect;
  final List<HistoryEntity>? history;

  @override
  State<LineChartPrice> createState() => _LineChartPriceState();
}

class _LineChartPriceState extends State<LineChartPrice> {
  List<(String, double)>? _bitcoinPriceHistory;

  @override
  void initState() {
    super.initState();

    _bitcoinPriceHistory = widget.history
        ?.map((it) => (it.date, double.tryParse(it.priceUsd) ?? 0))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.neutralN0,
          border: Border.all(color: colorScheme.neutralN300, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              AspectRatio(
                aspectRatio: 1,
                child: LineChart(
                  LineChartData(
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      drawHorizontalLine: true,
                      getDrawingHorizontalLine: (_) => FlLine(
                        color: colorScheme.neutralN300,
                        strokeWidth: 1,
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: false,
                        spots: [

                        ],
                        dotData: const FlDotData(show: false),
                        color: colorScheme.primaryN900,
                        barWidth: 1,
                        shadow: Shadow(
                          color: colorScheme.primaryN900,
                          blurRadius: 2,
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          color:
                              colorScheme.primaryN900.withValues(alpha: 0.05),
                        ),
                      ),
                    ],
                    lineTouchData: LineTouchData(
                      touchSpotThreshold: 5,
                      getTouchLineStart: (_, __) => -double.infinity,
                      getTouchLineEnd: (_, __) => double.infinity,
                      getTouchedSpotIndicator:
                          (LineChartBarData barData, List<int> spotIndexes) {
                        return spotIndexes.map((spotIndex) {
                          return TouchedSpotIndicatorData(
                            FlLine(
                              color: colorScheme.neutralN300,
                              strokeWidth: 1.5,
                              dashArray: [8, 2],
                            ),
                            FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: colorScheme.primaryN900,
                                  strokeWidth: 0,
                                  strokeColor: colorScheme.primaryN900,
                                );
                              },
                            ),
                          );
                        }).toList();
                      },
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                          return touchedBarSpots.map((barSpot) {
                            final price = barSpot.y;
                            final date =
                                _bitcoinPriceHistory![barSpot.x.toInt()].$1;
                            return LineTooltipItem(
                              '',
                              const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: date,
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: '\n$price',
                                  style: TextStyle(
                                    color: colorScheme.primaryN900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            );
                          }).toList();
                        },
                        getTooltipColor: (LineBarSpot barSpot) => Colors.black,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                        drawBelowEverything: false,
                        sideTitles: SideTitles(
                          showTitles: false,
                          maxIncluded: false,
                          minIncluded: false,
                        ),
                      ),
                      topTitles: const AxisTitles(
                        drawBelowEverything: false,
                        sideTitles: SideTitles(
                          showTitles: false,
                          maxIncluded: false,
                          minIncluded: false,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        drawBelowEverything: false,
                        sideTitles: SideTitles(
                          showTitles: false,
                          maxIncluded: false,
                          minIncluded: false,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 38,
                          maxIncluded: false,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            final date =
                                _bitcoinPriceHistory![value.toInt()].$1;
                            return SideTitleWidget(
                              meta: meta,
                              child: Text(date,
                                  style: textTheme.caption01.copyWith(
                                      color: colorScheme.neutralN600,
                                      fontSize: 12)),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  duration: Duration.zero,
                ),
              ),
              MultiSelectContainer(
                maxSelectableCount: 1,
                singleSelectedItem: true,
                wrapSettings: WrapSettings(
                  runAlignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 0,
                  runSpacing: 8,
                  alignment: WrapAlignment.start,
                ),
                alignments: MultiSelectAlignments(
                    crossAxisAlignment: CrossAxisAlignment.start),
                items: <MultiSelectCard<String>>[
                  _getMultiSelectCard(context, 'm30', "30 m"),
                  _getMultiSelectCard(context, 'h1', '1 h'),
                  _getMultiSelectCard(context, 'h12', '12 h'),
                  _getMultiSelectCard(context, 'd1', '24 h'),
                ],
                onChange: (List<String> selectedItems, String selectedItem) {
                  switch (selectedItem) {
                    case 'm30':
                      widget.onSelect?.call(LineChartPeriod.m30);
                      break;
                    case 'h1':
                      widget.onSelect?.call(LineChartPeriod.h1);
                      break;
                    case 'h12':
                      widget.onSelect?.call(LineChartPeriod.h12);
                      break;
                    case 'd1':
                      widget.onSelect?.call(LineChartPeriod.d1);
                      break;
                  }
                },
              ),
            ])));
  }

  _getMultiSelectCard(BuildContext context, String value, String label) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return MultiSelectCard(
      value: value,
      label: label,
      textStyles: MultiSelectItemTextStyles(
        selectedTextStyle:
            textTheme.captionMedium01.copyWith(color: colorScheme.neutralN0),
        textStyle:
            textTheme.captionMedium01.copyWith(color: colorScheme.neutralN600),
      ),
      decorations: MultiSelectItemDecorations(
        selectedDecoration: BoxDecoration(
          color: colorScheme.primaryN900,
          borderRadius: BorderRadius.circular(4),
        ),
        decoration: BoxDecoration(
          color: colorScheme.neutralN0,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

enum LineChartPeriod {
  m30,
  h1,
  h12,
  d1,
}
