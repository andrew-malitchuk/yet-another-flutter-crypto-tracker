import 'package:flutter_dotenv/flutter_dotenv.dart';

void setupEnv() async{
  await dotenv.load(fileName: 'assets/secrets/secrets.env');
}