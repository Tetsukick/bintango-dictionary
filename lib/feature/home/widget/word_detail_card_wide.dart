import 'package:bintango_indonesian_dictionary/feature/home/model/part_of_speech.dart';
import 'package:bintango_indonesian_dictionary/feature/home/model/tango_entity.dart';
import 'package:bintango_indonesian_dictionary/feature/home/provider/translate_provider.dart';
import 'package:bintango_indonesian_dictionary/gen/assets.gen.dart';
import 'package:bintango_indonesian_dictionary/shared/constants/color_constants.dart';
import 'package:bintango_indonesian_dictionary/shared/util/animation.dart';
import 'package:bintango_indonesian_dictionary/shared/util/open_url.dart';
import 'package:bintango_indonesian_dictionary/shared/widget/skeleton.dart';
import 'package:bintango_indonesian_dictionary/shared/widget/text_wdiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:lottie/lottie.dart';

class WordDetailCardWide extends ConsumerWidget {
  const WordDetailCardWide({required this.entity, super.key});

  final _iconHeight = 20.0;
  final _iconWidth = 20.0;

  final TangoEntity? entity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(translateNotifierProvider);

    if (state.isLoading) {
      if (entity == null) {
        return shimmerWordCard(context);
      } else {
        return wordCard(context, entity!).shimmer;
      }
    } else {
      if (entity == null) {
        if (state.inputtedText != null && state.inputtedText.isNotEmpty) {
          return Column(
            children: [
              Lottie.asset(
                'assets/lottie/no_data.json',
                height: 300,
              ),
              TextWidget.titleGraySmallBold(
                '申し訳ありません。。。\n『${state.inputtedText}』は、BINTANGOに登録されていないデータです。\n今後登録データを更新していく予定です。',
                maxLines: 10,
              ),
              const SizedBox(height: 8,),
              _searchInKBBI(state.inputtedText),
            ],
          );
        }
        return const SizedBox.shrink();
      }
      return wordCard(context, entity!).amShimmer;
    }
  }

  Widget shimmerWordCard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.image.houganshi.provider(),
            fit: BoxFit.cover,
            opacity: 0.5
          ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RoundedSkeleton(
              width: 72,
              height: 24,
              color: ColorConstants.primaryRed900,
            ).shimmer,
            const SizedBox(height: 8),
            const Skeleton(width: 88, height: 32,).shimmer,
            const SizedBox(height: 4),
            _separater().shimmer,
            const Skeleton(width: 96, height: 28,).shimmer,
            const SizedBox(height: 8),
            const Skeleton(width: 88, height: 28,).shimmer,
            const SizedBox(height: 8),
            _separater().shimmer,
            const SizedBox(height: 8),
            const Skeleton(width: 128, height: 28,).shimmer,
            const SizedBox(height: 8),
            const Skeleton(width: 128, height: 28,).shimmer,
            const SizedBox(height: 8),
            _separater().shimmer,
            const SizedBox(height: 8),
            const Skeleton(width: 128, height: 18,).shimmer,
            const SizedBox(height: 4),
            const Skeleton(width: 106, height: 18,).shimmer,
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget wordCard(BuildContext context, TangoEntity entity) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.image.houganshi.provider(),
            fit: BoxFit.cover,
          ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _partOfSpeech(entity),
            const SizedBox(height: 8),
            _indonesian(entity),
            const SizedBox(height: 4),
            _separater(),
            _japanese(entity),
            const SizedBox(height: 8),
            _english(entity),
            const SizedBox(height: 8),
            _exampleHeader(),
            const SizedBox(height: 8),
            _example(context, entity),
            const SizedBox(height: 8),
            _exampleJp(entity),
            const SizedBox(height: 8),
            _descriptionHeader(entity),
            const SizedBox(height: 8),
            _description(entity),
            const SizedBox(height: 8),
            _searchInKBBI(entity.indonesian),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _partOfSpeech(TangoEntity entity) {
    return Visibility(
      visible: entity.partOfSpeech != null,
      child: Row(
        children: [
          TextWidget.titleWhiteSmallBoldWithBackGround(PartOfSpeechExt.intToPartOfSpeech(value: entity.partOfSpeech ?? 1).title),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _indonesian(TangoEntity entity) {
    return Row(
      children: [
        Assets.image.indonesia64.image(height: _iconHeight, width: _iconWidth),
        const SizedBox(width: 12),
        Flexible(child:
        TextWidget.titleBlackLargestBold(entity.indonesian, maxLines: 2),),
      ],
    );
  }

  Widget _japanese(TangoEntity entity) {
    return Row(
      children: [
        Assets.image.japanFuji64.image(height: _iconHeight, width: _iconWidth),
        const SizedBox(width: 12),
        Flexible(child:
        TextWidget.titleGrayLargeBold(entity.japanese, maxLines: 2,),),
      ],
    );
  }

  Widget _english(TangoEntity entity) {
    return Row(
      children: [
        Assets.image.english64.image(height: _iconHeight, width: _iconWidth),
        const SizedBox(width: 12),
        Flexible(child: TextWidget.titleGrayLargeBold(entity.english, maxLines: 2)),
      ],
    );
  }

  Widget _exampleHeader() {
    return Row(
      children: [
        TextWidget.titleRedMedium('例文'),
        const SizedBox(width: 12),
        Flexible(child: _separater()),
      ],
    );
  }

  Widget _descriptionHeader(TangoEntity entity) {
    return Visibility(
      visible: entity.description != null && entity.description != '',
      child: Row(
        children: [
          TextWidget.titleRedMedium('豆知識'),
          const SizedBox(width: 12),
          Flexible(child: _separater()),
        ],
      ),
    );
  }

  Widget _example(BuildContext context, TangoEntity entity) {
    final EdgeInsetsGeometry padding = EdgeInsets.only(left: 4, right: 4, bottom: 6);

    return SelectionArea(
      child: Row(
        children: [
          Assets.image.example64.image(height: _iconHeight, width: _iconWidth),
          const SizedBox(width: 12),
          Flexible(
            child: TextHighlight(
              text: entity.example!,
              words: {
                entity.indonesian: HighlightedWord(
                  textStyle: TextWidget.titleBlackLargeBoldStyle,
                  decoration: const BoxDecoration(
                    color: Colors.yellowAccent,
                  ),
                  padding: padding
                ),
              },
              maxLines: 10,
              textStyle: TextWidget.titleBlackLargeBoldStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _exampleJp(TangoEntity entity) {
    return Row(
      children: [
        Assets.image.japan64.image(height: _iconHeight, width: _iconWidth),
        const SizedBox(width: 12),
        Flexible(child: TextWidget.titleGrayMediumBold(entity.exampleJp!, maxLines: 5)),
      ],
    );
  }

  Widget _description(TangoEntity entity) {
    return Visibility(
      visible: entity.description != null && entity.description != '',
      child: Row(
        children: [
          Assets.image.infoNotes.image(height: _iconHeight, width: _iconWidth),
          const SizedBox(width: 12),
          Flexible(child: TextWidget.titleGraySmallBold(entity.description ?? '', maxLines: 10)),
        ],
      ),
    );
  }

  Widget _searchInKBBI(String searchWord) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blueAccent,
      ),
      onPressed: () {
        launch('https://kbbi.kemdikbud.go.id/entri/$searchWord');
      },
      child: TextWidget.titleBlueSmallNotSelectable('KBBIで『$searchWord』を調べる。(外部リンクへ遷移します。)'),
    );
  }

  Widget _separater() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: 1,
        width: double.infinity,
        color: ColorConstants.bgGrey.withOpacity(0.3),
      ),
    );
  }
}
