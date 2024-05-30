import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

Future<void> launch(String url, {bool isNewTab = true}) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  } else {
    log('Failed to launch url. $url');
  }
}