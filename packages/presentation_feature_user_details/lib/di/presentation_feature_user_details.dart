import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:provider/provider.dart';

import '../bloc/user_details_bloc.dart';

List<Provider> presentationFeatureUserDetails = [
  Provider<UserDetailsBloc>(
    create: (context) => UserDetailsBloc(
      cryptoRepository: context.read<CryptoRepository>(),
    ),
  ),

];
