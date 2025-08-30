import 'package:equatable/equatable.dart';

import '../core/components/widget/line_chart.dart';

sealed class DetalizationEvent extends Equatable {}

class DetalizationLoadEvent extends DetalizationEvent {
  String coin;

  DetalizationLoadEvent({required this.coin});

  @override
  List<Object?> get props => [coin];
}

class DetalizationLoadHistoryEvent extends DetalizationEvent {
  LineChartPeriod period;

  DetalizationLoadHistoryEvent({
    required this.period,
  });

  @override
  List<Object?> get props => [period];
}
