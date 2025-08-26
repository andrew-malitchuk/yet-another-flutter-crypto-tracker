import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:provider/provider.dart';

import '../bloc/account_settings_bloc.dart';

List<Provider> presentationFeatureAccountSettings = [
  Provider<AccountSettingsBloc>(
    create: (context) => AccountSettingsBloc(
      cryptoRepository: context.read<CryptoRepository>(),
    ),
  ),
];
