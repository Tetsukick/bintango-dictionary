import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';
import 'dart:ui' as ui;

import 'package:bintango_indonesian_dictionary/feature/home/model/side_menu.dart';
import 'package:bintango_indonesian_dictionary/feature/home/provider/translate_provider.dart';
import 'package:bintango_indonesian_dictionary/feature/home/widget/explanation_detail_card.dart';
import 'package:bintango_indonesian_dictionary/feature/home/widget/word_detail_card.dart';
import 'package:bintango_indonesian_dictionary/feature/home/widget/word_detail_card_wide.dart';
import 'package:bintango_indonesian_dictionary/gen/assets.gen.dart';
import 'package:bintango_indonesian_dictionary/shared/constants/color_constants.dart';
import 'package:bintango_indonesian_dictionary/shared/route/app_router.dart';
import 'package:bintango_indonesian_dictionary/shared/util/analytics/analytics_parameters.dart';
import 'package:bintango_indonesian_dictionary/shared/util/analytics/firebase_analytics.dart';
import 'package:bintango_indonesian_dictionary/shared/util/open_url.dart';
import 'package:bintango_indonesian_dictionary/shared/widget/text_wdiget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:responsive_framework/responsive_framework.dart';

class DictionaryDetailPage extends ConsumerStatefulWidget {
  DictionaryDetailPage({required this. searchWord, super.key});

  String searchWord;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _DictionaryDetailPageState();
  }
}

class _DictionaryDetailPageState extends ConsumerState<DictionaryDetailPage> {

  final TextEditingController _inputController = TextEditingController();
  final double _iconHeight = 28;
  final double _iconWidth = 28;

  final _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    FirebaseAnalyticsUtils.screenTrack(AnalyticsScreen.BDdictionaryDetail);
    final loading = html.querySelector('.loading') as html.DivElement?;
    if (loading != null) loading.remove();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.watch(translateNotifierProvider.notifier)
          .searchWithWord(widget.searchWord);
      final state = ref.watch(translateNotifierProvider);
      await updateMetaInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      color: ColorConstants.bgPinkColor,
      title: '『${widget.searchWord}』の意味をインドネシア語辞書で検索 | BINTANGO DICTIONARY',
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: ColorConstants.bgPinkColor,
          title: Row(
            children: [
              const SizedBox(width: 8,),
              InkWell(
                child: Row(
                  children: [
                    Assets.image.bintangoLogo256.image(height: 48,),
                    const SizedBox(width: 16,),
                    Assets.image.bintangoDictionaryLogo.image(height: 48,),
                  ],
                ),
                onTap: () {
                  ref.read(routerProvider).go(AppRoute.path);
                },
              ),
            ],
          ),
          actions: ResponsiveBreakpoints.of(context).largerThan(MOBILE) ?
          [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: ColorConstants.fontGrey,
                ),
                onPressed: () {
                  launch(SideMenu.bintango.url);
                },
                child: TextWidget
                    .titleGraySmallBoldNotSelectable(SideMenu.bintango.title),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: ColorConstants.fontGrey,
                ),
                onPressed: () {
                  launch(SideMenu.developerInfo.url);
                },
                child: TextWidget.titleGraySmallBoldNotSelectable(
                    SideMenu.developerInfo.title,),
              ),
            ),
            const SizedBox(width: 4,),
          ]
          : [
            PopupMenuButton<SideMenu>(
              onSelected: (SideMenu item) {
                launch(item.url);
              },
              itemBuilder: (BuildContext context) => SideMenu.values.map((e) {
                return PopupMenuItem<SideMenu>(
                  value: e,
                  child: Text(e.title),
                );
              }).toList(),
            ),
          ],
        ),
        backgroundColor: ColorConstants.bgPinkColor,
        body: _widgetContent(context, ref),
      ),
    );
  }

  Widget _widgetContent(BuildContext context, WidgetRef ref) {
    final state = ref.watch(translateNotifierProvider);
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            _searchBoxArea(context, ref),
            const SizedBox(height: 12,),
            _searchedWord(context, ref),
            const SizedBox(height: 12,),
            Visibility(
              visible: state.relatedWords.isNotEmpty || state.isLoadingWordList,
              child: _relatedWordsHeader(),),
            const SizedBox(height: 12,),
            _relatedWordArea(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _searchBoxArea(BuildContext context, WidgetRef ref) {
    final state = ref.watch(translateNotifierProvider);
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width /
          (ResponsiveBreakpoints.of(context).largerThan(TABLET) ? 2 :
          ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 1.2 : 1.08),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.image.searchboxBackground.provider(),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: _inputField(context, ref),
      ),
    );
  }

  Widget _inputField(
      BuildContext context,
      WidgetRef ref,
      ) {
    final state = ref.watch(translateNotifierProvider);
    final notifier = ref.watch(translateNotifierProvider.notifier);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width /
                    (ResponsiveBreakpoints.of(context).largerThan(TABLET) ? 2 :
                    ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 1.3 : 1.08)) -
                    (ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 124 : 40),
                child: TextField(
                  maxLength: 50,
                  controller: _inputController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    hintText: '調べたい単語を入力してください。',
                    alignLabelWithHint: true,
                    suffixIcon: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
                      ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _inputController.clear,
                      )
                      : IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: search,
                      ),
                    counterText: '',
                  ),
                  onChanged: notifier.updateInputText,
                  onEditingComplete: search,
                ),
              ),
              if (ResponsiveBreakpoints.of(context).largerThan(MOBILE))
                ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ColorConstants.primaryRed900,
                  shape: const CircleBorder(),
                ),
                onPressed: search,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Assets.image.search128.image(
                    height: _iconHeight,
                    width: _iconWidth,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> search() async {
    FirebaseAnalyticsUtils.eventsTrack(DictionaryDetailItem.search);
    final notifier = ref.watch(translateNotifierProvider.notifier);
    final state = ref.watch(translateNotifierProvider);
    await notifier.searchWord();
    setState(() => widget.searchWord = state.inputtedText);
    html.window.history.pushState(
      {}, '', DictionaryDetailRoute.path
        .replaceFirst(':searchWord', state.inputtedText),);
    updateMetaInfo();
  }

  Future<void> updateMetaInfo() async {
    final state = ref.watch(translateNotifierProvider);
    final meta = MetaSEO();
    final description = '『${widget.searchWord}』は、日本語で、『${state.searchedWord?.japanese ?? ''}』を意味します。英語では、『${state.searchedWord?.english ?? ''}』を意味します。';
    final title = '『${widget.searchWord}』の意味をインドネシア語辞書で検索 | BINTANGO DICTIONARY';
    meta.ogTitle(ogTitle: title);
    meta.description(description: description);
    meta.keywords(keywords: 'インドネシア語, インドネシア語辞書, インドネシア語学習, インドネシア語勉強, ${widget.searchWord}, ${state.searchedWord?.japanese}, ${state.searchedWord?.japanese}');

    if (state.searchedWord != null) {
      final imageUrl = await exportToImageAndUploadFireStorage();
      if (imageUrl != null) {
        meta
          ..twitterCard(twitterCard: TwitterCard.summaryLargeImage)
          ..ogImage(ogImage: imageUrl)
          ..twitterImage(twitterImage: imageUrl)
          ..twitterTitle(twitterTitle: title)
          ..twitterDescription(twitterDescription: description);
      }
    }
  }

  Widget _detailDescriptionArea(BuildContext context, WidgetRef ref) {
    final state = ref.watch(translateNotifierProvider);
    if (state.getDetailExplanationResponse != null) {
      return ExplanationDetailCard(data: state.getDetailExplanationResponse!);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _searchedWord(BuildContext context, WidgetRef ref) {
    final state = ref.watch(translateNotifierProvider);
    return RepaintBoundary(
      key: _globalKey,
      child: WordDetailCardWide(entity: state.searchedWord),
    );
  }

  Widget _relatedWordArea(BuildContext context, WidgetRef ref) {
    final state = ref.watch(translateNotifierProvider);
    return MasonryGridView.count(
      crossAxisCount: _gridCount(context),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemCount: state.isLoadingWordList && state.relatedWords.isEmpty
          ? 4 : state.relatedWords.length,
      itemBuilder: (context, index) {
        return WordDetailCard(
            entity: state.relatedWords.isEmpty
                ? null : state.relatedWords[index],
        );
      },
    );
  }

  int _gridCount(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).largerThan(TABLET)) {
      return 4;
    } else if (ResponsiveBreakpoints.of(context).largerThan(MOBILE)) {
      return 2;
    } else {
      return 1;
    }
  }

  Widget _relatedWordsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          TextWidget.titleGrayMedium('関連単語'),
          Flexible(child: _separater()),
        ],
      ),
    );
  }

  Widget _separater() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 1,
        width: double.infinity,
        color: ColorConstants.bgGreySeparater,
      ),
    );
  }

  Future<String?> exportToImageAndUploadFireStorage() async {
    final state = ref.watch(translateNotifierProvider);
    if (state.searchedWord != null) {
      final storageRef = FirebaseStorage.instance.ref();
      final imagePath = 'dictionary_twitter_image/${state.searchedWord!.indonesian!}.png';
      final dictionaryDetailCardImage = storageRef.child(imagePath);

      String? downloadImageUrl;
      try {
        downloadImageUrl = await dictionaryDetailCardImage.getDownloadURL();
        downloadImageUrl = 'https://storage.cloud.google.com/indonesian-flash-card.appspot.com/$imagePath';
      } catch (e) {
        await Future.delayed(const Duration(seconds: 3));
        final boundary =
        _globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
        final image = await boundary.toImage(
          pixelRatio: 2,
        );
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData != null) {
          final imageUint8list = byteData.buffer.asUint8List();
          final compressedImageUint8List = await FlutterImageCompress
              .compressWithList(
                imageUint8list,
                quality: 80,
              );
          final base64img = base64Encode(compressedImageUint8List);
          final uploadTask = await dictionaryDetailCardImage
              .putString(base64img, format: PutStringFormat.base64);

          downloadImageUrl = await uploadTask.ref.getDownloadURL();
          downloadImageUrl = 'https://storage.cloud.google.com/indonesian-flash-card.appspot.com/$imagePath';
        }
      }
      return downloadImageUrl;
    } else {
      return null;
    }
  }
}
