import 'package:bintango_indonesian_dictionary/feature/home/model/translate_response.dart';
import 'package:bintango_indonesian_dictionary/shared/constants/color_constants.dart';
import 'package:bintango_indonesian_dictionary/shared/widget/text_wdiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ExplanationDetailCard extends StatelessWidget {
  const ExplanationDetailCard({required this.data, super.key});

  final _iconHeight = 20.0;
  final _iconWidth = 20.0;

  final TranslateResponse data;

  @override
  Widget build(BuildContext context) {
    final inputOutputCardWidth = MediaQuery.of(context).size.width /
        (ResponsiveBreakpoints.of(context).largerThan(TABLET) ? 3 : 2.2);
    return Card(
      child: SizedBox(
        width: (inputOutputCardWidth * 2)
            + (ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 24 : 4),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _descriptionHeader(data),
              const SizedBox(height: 8),
              _description(data),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _descriptionHeader(TranslateResponse entity) {
    return Visibility(
      visible: entity.text != '',
      child: Row(
        children: [
          TextWidget.titleRedMedium('文章の解説'),
          const SizedBox(width: 12),
          Flexible(child: _separater()),
        ],
      ),
    );
  }

  Widget _description(TranslateResponse entity) {
    return Visibility(
      visible: entity.text != '',
      child: Markdown(
        selectable: true,
        data: entity.text,
        shrinkWrap: true,
      ),
    );
  }

  Widget _separater() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: 1,
        width: double.infinity,
        color: ColorConstants.bgGreySeparater,
      ),
    );
  }
}
