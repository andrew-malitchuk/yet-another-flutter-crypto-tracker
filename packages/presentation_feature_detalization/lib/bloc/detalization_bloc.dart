import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/components/widget/line_chart.dart';
import 'detalization_event.dart';
import 'detalization_state.dart';

class DetalizationBloc extends Bloc<DetalizationEvent, DetalizationState> {
  final CryptoRepository cryptoRepository;

  String coin = "";

  @override
  DetalizationState get initialState => DetalizationInitialState();

  DetalizationBloc({required this.cryptoRepository})
      : super(DetalizationInitialState()) {
    on<DetalizationLoadEvent>((event, emit) async {
      emit(DetalizationLoadingState());

      // TODO remove this delay, it's just for demo purposes
      await Future.delayed(Duration(seconds: 2));

      coin = event.coin.toLowerCase();

      final result = await cryptoRepository.getAsset(
        event.coin.toLowerCase(),
      );

      String endDate = _getPeriodStartIso8601(LineChartPeriod.m30);
      final history = await cryptoRepository.getAssetHistory(
        event.coin.toLowerCase(),
        _getPeriodString(LineChartPeriod.m30),
        _getCurrentDateIso8601(),
        endDate,
      );

      if (/*history.isSuccess() &&*/ result.isSuccess()) {
        emit(DetalizationLoadedState(
            result.getOrNull()?.data, /* history.getOrNull()?.data*/ null));
      } else {
        //
        final fromDbResult =
            await cryptoRepository.loadOfflineAsset(event.coin.toLowerCase());
        String endDate = _getPeriodStartIso8601(LineChartPeriod.m30);
        final historyDbResult = await cryptoRepository.getAssetHistory(
          event.coin.toLowerCase(),
          _getPeriodString(LineChartPeriod.m30),
          _getCurrentDateIso8601(),
          endDate,
        );

        emit(DetalizationLoadedState(
            fromDbResult.getOrNull(), historyDbResult.getOrNull()?.data));
        //
      }
    });
    on<DetalizationLoadHistoryEvent>((event, emit) async {
      String endDate = _getPeriodStartIso8601(event.period);

      final history = await cryptoRepository.getAssetHistory(
        coin,
        _getPeriodString(event.period),
        _getCurrentDateIso8601(),
        endDate,
      );

      history.fold((onSuccess) {
        emit(DetalizationLoadedState((state as DetalizationLoadedState).data,
            history.getOrNull()?.data));
      }, (onFailure) {
        emit(DetalizationErrorState());
      });
    });
  }

  String _getCurrentDateIso8601() {
    return DateTime.now().toUtc().millisecondsSinceEpoch.toString();
  }

  String _getPeriodStartIso8601(LineChartPeriod period) {
    final now = DateTime.now().toUtc();
    late DateTime start;
    switch (period) {
      case LineChartPeriod.m30:
        start = DateTime.utc(now.year, now.month, now.day);
        break;
      case LineChartPeriod.h1:
        start = now.subtract(Duration(days: now.weekday - 1));
        start = DateTime.utc(start.year, start.month, start.day);
        break;
      case LineChartPeriod.h12:
        start = DateTime.utc(now.year, now.month, 1);
        break;
      case LineChartPeriod.d1:
        start = DateTime.utc(now.year, 1, 1);
        break;
      default:
        start = DateTime.utc(now.year, now.month, now.day);
    }
    return start.millisecondsSinceEpoch.toString();
  }

  String _getPeriodString(LineChartPeriod period) {
    return period.name;
  }
}
