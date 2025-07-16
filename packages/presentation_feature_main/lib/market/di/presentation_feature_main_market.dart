import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:presentation_feature_main/add_new_coin/bloc/add_new_coin_bloc.dart';
import 'package:presentation_feature_main/market/bloc/market_bloc.dart';
import 'package:provider/provider.dart';

List<Provider> presentationFeatureMainMarket = [
  Provider<MarketBloc>(
    create: (context) => MarketBloc(
      cryptoRepository: context.read<CryptoRepository>(),
    ),
  ),
  Provider<AddNewCoinBloc>(
    create: (context) => AddNewCoinBloc(
      cryptoRepository: context.read<CryptoRepository>(),
    ),
  ),
];
