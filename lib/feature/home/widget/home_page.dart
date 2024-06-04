import 'dart:html';

import 'package:bintango_indonesian_dictionary/feature/home/model/side_menu.dart';
import 'package:bintango_indonesian_dictionary/feature/home/provider/translate_provider.dart';
import 'package:bintango_indonesian_dictionary/feature/home/widget/explanation_detail_card.dart';
import 'package:bintango_indonesian_dictionary/feature/home/widget/word_detail_card_wide.dart';
import 'package:bintango_indonesian_dictionary/gen/assets.gen.dart';
import 'package:bintango_indonesian_dictionary/shared/constants/color_constants.dart';
import 'package:bintango_indonesian_dictionary/shared/route/app_router.dart';
import 'package:bintango_indonesian_dictionary/shared/util/analytics/analytics_parameters.dart';
import 'package:bintango_indonesian_dictionary/shared/util/analytics/firebase_analytics.dart';
import 'package:bintango_indonesian_dictionary/shared/util/open_url.dart';
import 'package:bintango_indonesian_dictionary/shared/widget/text_wdiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends ConsumerState<HomePage> {

  final TextEditingController _inputController = TextEditingController();
  final _iconHeight = 28.0;
  final _iconWidth = 28.0;

  @override
  void initState() {
    super.initState();
    FirebaseAnalyticsUtils.screenTrack(AnalyticsScreen.BDhome);
    final loading = querySelector('.loading') as DivElement?;
    if (loading != null) loading.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      color: ColorConstants.bgPinkColor,
      title: 'BINTANGO DICTIONARY | 全単語例文付きのオンラインインドネシア語辞書',
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
          ],
        ),
      ),
    );
  }

  Widget _searchBoxArea(BuildContext context, WidgetRef ref) {
    final state = ref.watch(translateNotifierProvider);
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width /
          (ResponsiveBreakpoints.of(context).largerThan(TABLET) ? 2 :
          ResponsiveBreakpoints.of(context).largerThan(MOBILE) ? 1.3 : 1.1),
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
    final notifier = ref.watch(translateNotifierProvider.notifier);
    final state = ref.watch(translateNotifierProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(ResponsiveBreakpoints.of(context).largerThan(TABLET) ? 16 : 8),
          child: _searchBoxTitle(context),
        ),
        Padding(
          padding: EdgeInsets.all(ResponsiveBreakpoints.of(context).largerThan(TABLET) ? 16 : 8),
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
                    suffixIcon: ResponsiveBreakpoints.of(context).largerThan(MOBILE) ?
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _inputController.clear,
                      )
                      : IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: search,
                    ),
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

  Widget _searchBoxTitle(BuildContext context,) {
    return TextWidget.titleRedLargestBold(
      '調べたいインドネシア語を入力♪',);
  }
  
  void search() {
    final state = ref.watch(translateNotifierProvider);
    FirebaseAnalyticsUtils.eventsTrack(HomeItem.search);
    ref.read(routerProvider).go(
      DictionaryDetailRoute.path
          .replaceFirst(':searchWord', state.inputtedText),);
  }
}
