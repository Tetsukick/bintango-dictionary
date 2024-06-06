import 'package:bintango_indonesian_dictionary/feature/home/model/part_of_speech.dart';
import 'package:bintango_indonesian_dictionary/feature/home/model/tango_entity.dart';
import 'package:bintango_indonesian_dictionary/feature/home/provider/translate_provider.dart';
import 'package:bintango_indonesian_dictionary/gen/assets.gen.dart';
import 'package:bintango_indonesian_dictionary/shared/constants/color_constants.dart';
import 'package:bintango_indonesian_dictionary/shared/util/animation.dart';
import 'package:bintango_indonesian_dictionary/shared/widget/skeleton.dart';
import 'package:bintango_indonesian_dictionary/shared/widget/text_wdiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WordDetailCard extends ConsumerWidget {
  const WordDetailCard({required this.entity, super.key});

  final _iconHeight = 20.0;
  final _iconWidth = 20.0;

  final TangoEntity? entity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(translateNotifierProvider);

    if (state.isLoadingWordList) {
      if (entity == null) {
        return shimmerWordCard();
      } else {
        return wordCard(entity!).shimmer;
      }
    } else {
      return wordCard(entity!).amShimmer;
    }
  }

  Widget shimmerWordCard() {
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: 150,
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
      ),
    );
  }

  Widget wordCard(TangoEntity entity) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: 150,
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
              _example(entity),
              const SizedBox(height: 8),
              _exampleJp(entity),
              const SizedBox(height: 8),
              _descriptionHeader(entity),
              const SizedBox(height: 8),
              _description(entity),
              const SizedBox(height: 8),
            ],
          ),
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

  Widget _example(TangoEntity entity) {
    return Row(
      children: [
        Assets.image.example64.image(height: _iconHeight, width: _iconWidth),
        const SizedBox(width: 12),
        Flexible(child: TextWidget.titleBlackLargeBold(entity.example!, maxLines: 5)),
      ],
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
