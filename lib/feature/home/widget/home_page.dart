import 'dart:html';

import 'package:bintango_indonesian_dictionary/feature/home/model/side_menu.dart';
import 'package:bintango_indonesian_dictionary/feature/home/provider/translate_provider.dart';
import 'package:bintango_indonesian_dictionary/feature/home/widget/word_detail_card.dart';
import 'package:bintango_indonesian_dictionary/gen/assets.gen.dart';
import 'package:bintango_indonesian_dictionary/shared/constants/color_constants.dart';
import 'package:bintango_indonesian_dictionary/shared/route/app_router.dart';
import 'package:bintango_indonesian_dictionary/shared/util/analytics/analytics_parameters.dart';
import 'package:bintango_indonesian_dictionary/shared/util/analytics/firebase_analytics.dart';
import 'package:bintango_indonesian_dictionary/shared/util/open_url.dart';
import 'package:bintango_indonesian_dictionary/shared/widget/snackbar.dart';
import 'package:bintango_indonesian_dictionary/shared/widget/text_wdiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:bintango_indonesian_dictionary/feature/home/widget/explanation_detail_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends ConsumerState<HomePage> {

  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  final _iconHeight = 20.0;
  final _iconWidth = 20.0;

  @override
  void initState() {
    super.initState();
    FirebaseAnalyticsUtils.screenTrack(AnalyticsScreen.BThome);
    final loading = querySelector('.loading') as DivElement?;
    if (loading != null) loading.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      color: ColorConstants.bgPinkColor,
      title: 'Bintango Dictionary | AIでインドネシア語翻訳と同時に一括単語検索',
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
              ? 120 : 80,
          backgroundColor: ColorConstants.bgPinkColor,
          title: Row(
            children: [
              const SizedBox(width: 8,),
              InkWell(
                child: Row(
                  children: [
                    Assets.image.bintangoLogo256.image(height:
                    ResponsiveBreakpoints.of(context)
                        .largerThan(MOBILE) ? 80 : 48,),
                    const SizedBox(width: 16,),
                    Assets.image.bintangoTranslateLogo.image(height:
                    ResponsiveBreakpoints.of(context)
                        .largerThan(MOBILE) ? 80 : 48,),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          _translateArea(context, ref),
          _detailDescriptionArea(context, ref),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 2,
              width: double.infinity,
              color: ColorConstants.primaryRed900.withOpacity(0.2),
            ),
          ),
          _includedWordArea(context, ref),
        ],
      ),
    );
  }

  Widget _translateArea(BuildContext context, WidgetRef ref) {
    final state = ref.watch(translateNotifierProvider);
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Row(
            children: [
              const Spacer(),
              _inputOutputField(
                context,
                ref,
                isJapanese: state.isLanguageSourceJapanese,
                isInput: true,),
              SizedBox(width: ResponsiveBreakpoints.of(context)
                  .largerThan(MOBILE) ? 24 : 4,),
              _inputOutputField(
                context,
                ref,
                isJapanese: !state.isLanguageSourceJapanese,
                isInput: false,),
              const Spacer(),
            ],
          ),
          Align(
            child: _changeLangSourceButton(context, ref),
          ),
        ],
      ),
    );
  }

  Widget _changeLangSourceButton(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(translateNotifierProvider.notifier);
    final state = ref.watch(translateNotifierProvider);
    return ElevatedButton(
      onPressed: () async {
        notifier.changeLangSource();
        if (state.inputtedText.isNotEmpty) {
          await Future.delayed(const Duration(milliseconds: 500));
          _inputController.value = _inputController.value.copyWith(
            text: state.inputtedText,
            selection: TextSelection
                .collapsed(offset: state.inputtedText.length),
          );
          await notifier.translate();
          await notifier.searchIncludedWords();
        }
      },
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 16 : 8,),
        child: Assets.image.reverse128.image(width:
          ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 32 : 24,),
      ),
    );
  }

  Widget _inputOutputField(
      BuildContext context,
      WidgetRef ref,
      {
        required bool isJapanese,
        required bool isInput,
      }) {
    final notifier = ref.watch(translateNotifierProvider.notifier);
    final state = ref.watch(translateNotifierProvider);
    if (state.translateResponse != null) {
      _outputController.value = _outputController.value.copyWith(
        text: state.translateResponse!.text,
        selection: TextSelection
            .collapsed(offset: state.translateResponse!.text.length),
      );
    }
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: MediaQuery.of(context).size.width /
            (ResponsiveBreakpoints.of(context).largerThan(TABLET) ? 3 : 2.2),
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: _languageTitle(context, isJapanese: isJapanese),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: ColorConstants.strokeGrey,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: isInput ? TextField(
                maxLines: 6,
                maxLength: isInput ? 500 : null,
                controller: isInput ? _inputController : _outputController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  hintText: 'ここに翻訳したい文章を入力してください。',
                  alignLabelWithHint: true,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _inputController.clear,
                  ),
                ),
                onChanged: notifier.updateInputText,
              ) : SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    Visibility(
                      visible: state.translateResponse != null
                          && state.translateResponse!.text.isNotEmpty,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: () async {
                            FirebaseAnalyticsUtils.eventsTrack(HomeItem.copy);
                            await Clipboard.setData(ClipboardData(text:
                              state.translateResponse!.text,),);
                            snackbarSuccess('クリップボードにコピーしました。');
                          },
                          icon: const Icon(Icons.copy),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: TextWidget
                            .titleGraySmallBold(
                              state.isLoading ? 'loading...'
                                  : state.translateResponse?.text ?? 'テキストを入力すると翻訳結果がこちらに表示されます。',
                              maxLines: 100,
                              textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageTitle(BuildContext context, {required bool isJapanese}) {
    final imageHeight = ResponsiveBreakpoints.of(context)
        .largerThan(MOBILE) ? 28 : 20;
    return Row(
      children: [
        if (isJapanese) Assets.image.japan64.image(height: 28)
          else Assets.image.indonesia64.image(height: 28),
        const SizedBox(width: 8,),
        Flexible(
          child: TextWidget.titleGrayMediumBold(
            isJapanese ? '日本語' : 'インドネシア語',),
        ),
      ],
    );
  }

  Widget _detailDescriptionArea(BuildContext context, WidgetRef ref) {
    final state = ref.watch(translateNotifierProvider);
    if (state.getDetailExplanationResponse != null) {
      return ExplanationDetailCard(data: state.getDetailExplanationResponse!);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _includedWordArea(BuildContext context, WidgetRef ref) {
    final state = ref.watch(translateNotifierProvider);
    return MasonryGridView.count(
      crossAxisCount: _gridCount(context),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemCount: state.isLoadingWordList && state.includedWords.isEmpty
          ? 4 : state.includedWords.length,
      itemBuilder: (context, index) {
        return WordDetailCard(
            entity: state.includedWords.isEmpty
                ? null : state.includedWords[index],
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
}
