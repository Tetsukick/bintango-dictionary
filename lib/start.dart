import 'dart:async';
import 'dart:developer';
import 'dart:html' as html;

import 'package:bintango_indonesian_dictionary/app/app.dart';
import 'package:bintango_indonesian_dictionary/firebase_options.dart';
import 'package:bintango_indonesian_dictionary/shared/util/logger.dart';
import 'package:bintango_indonesian_dictionary/shared/util/platform_type.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> start() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final platformType = detectPlatformType();
  usePathUrlStrategy();

  if (kIsWeb) {
    MetaSEO().config();
  }

  var cookies = html.window.document.cookie;

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en')],
    path: 'assets/lang',
    fallbackLocale: const Locale('en'),
    child: ProviderScope(overrides: [
      platformTypeProvider.overrideWithValue(platformType),
    ], observers: [
      Logger(),
    ], child: const App(),),
  ),);
}
