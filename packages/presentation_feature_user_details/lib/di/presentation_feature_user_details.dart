import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:presentation_feature_main/add_new_coin/bloc/add_new_coin_bloc.dart';
import 'package:presentation_feature_main/market/bloc/market_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/user_details_bloc.dart';

List<Provider> presentationFeatureUserDetails = [
  Provider<UserDetailsBloc>(
    create: (context) => UserDetailsBloc(
      cryptoRepository: context.read<CryptoRepository>(),
    ),
  ),

];
