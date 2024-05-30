import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bintango_indonesian_dictionary/gen/assets.gen.dart';
import 'package:bintango_indonesian_dictionary/start.dart';

Future<void> main() async {
  await dotenv.load(fileName: Assets.env.envStaging);

  await start();
}
