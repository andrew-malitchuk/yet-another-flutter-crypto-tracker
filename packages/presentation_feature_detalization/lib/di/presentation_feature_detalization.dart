import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:provider/provider.dart';

import '../bloc/detalization_bloc.dart';

List<Provider> presentationFeatureDetalization= [
  Provider<DetalizationBloc>(
    create: (context) => DetalizationBloc(
      cryptoRepository: context.read<CryptoRepository>(),
    ),
  ),
];
