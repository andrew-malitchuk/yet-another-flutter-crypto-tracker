import 'package:equatable/equatable.dart';

sealed class MarketEvent extends Equatable {}

class MarketLoadEvent extends MarketEvent {
  @override
  List<Object?> get props => [];
}

class MarketSearchEvent extends MarketEvent {
  final String query;

  MarketSearchEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class MarketLoadMoreEvent extends MarketEvent {
  @override
  List<Object?> get props => [];
}
