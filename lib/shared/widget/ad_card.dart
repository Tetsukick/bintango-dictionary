import 'package:bintango_indonesian_dictionary/gen/assets.gen.dart';
import 'package:bintango_indonesian_dictionary/shared/util/animation.dart';
import 'package:bintango_indonesian_dictionary/shared/util/open_url.dart';
import 'package:bintango_indonesian_dictionary/shared/widget/text_wdiget.dart';
import 'package:flutter/material.dart';

class AdCard extends StatelessWidget {
  const AdCard({
    required this.title,
    required this.url,
    required this.image, super.key,});

  final String title;
  final String url;
  final AssetGenImage image;

  @override
  Widget build(BuildContext context) {
    return adCardContents();
  }

  Widget adCardContents() {
    return InkWell(
      onTap: () {
        launch(url);
      },
      child: Card(
        color: Colors.white,
        child: SizedBox(
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                image.image(height: 150, fit: BoxFit.contain),
                const SizedBox(height: 8),
                TextWidget.titleGrayMediumSmallBoldNotSelectable(
                    title, maxLines: 3,),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
