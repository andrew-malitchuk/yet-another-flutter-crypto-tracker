import 'package:domain_repository/repository/crypto_repository.dart';
import 'package:presentation_feature_user_profile/bloc/user_profile_bloc.dart';
import 'package:provider/provider.dart';

List<Provider> presentationFeatureUserProfile = [
  Provider<UserProfileBloc>(
    create: (context) => UserProfileBloc(
      cryptoRepository: context.read<CryptoRepository>(),
    ),
  ),
];
