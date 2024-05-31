import 'dart:html';

import 'package:bintango_indonesian_dictionary/feature/home/model/side_menu.dart';
import 'package:bintango_indonesian_dictionary/feature/home/provider/translate_provider.dart';
import 'package:bintango_indonesian_dictionary/feature/home/widget/word_detail_card.dart';
import 'package:bintango_indonesian_dictionary/feature/home/widget/word_detail_card_wide.dart';
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
      title: 'Bintango Dictionary | インドネシア語と日本語の辞書 和尼辞書&尼和辞書',
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
                    Assets.image.bintangoDictionaryLogo.svg(height:
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
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            _searchBoxArea(context, ref),
            const SizedBox(height: 12,),
            _searchedWord(context, ref),
          ],
        ),
      ),
    );
  }

  Widget _searchBoxArea(BuildContext context, WidgetRef ref) {
    final state = ref.watch(translateNotifierProvider);
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.image.searchboxBackground.provider(),
          fit: BoxFit.fill,
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
    final notifier = ref.watch(translateNotifierProvider.notifier);
    final state = ref.watch(translateNotifierProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: _searchBoxTitle(context),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            maxLength: 50,
            controller: _inputController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              filled: true,
              hintText: 'ここに調べたい単語やフレーズを入力してください。',
              alignLabelWithHint: true,
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _inputController.clear,
              ),
            ),
            onChanged: notifier.updateInputText,
          ),
        ),
      ],
    );
  }

  Widget _searchBoxTitle(BuildContext context,) {
    final imageHeight = ResponsiveBreakpoints.of(context)
        .largerThan(MOBILE) ? 28 : 20;
    return Flexible(
      child: TextWidget.titleRedLargestBold(
        'インドネシア語でも日本語でも入力できます♪',),
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

  Widget _searchedWord(BuildContext context, WidgetRef ref) {
    final state = ref.watch(translateNotifierProvider);
    return WordDetailCardWide(entity: state.searchedWord);
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
