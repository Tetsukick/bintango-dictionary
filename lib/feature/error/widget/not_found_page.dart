import 'package:bintango_indonesian_dictionary/feature/home/model/side_menu.dart';
import 'package:bintango_indonesian_dictionary/gen/assets.gen.dart';
import 'package:bintango_indonesian_dictionary/shared/constants/color_constants.dart';
import 'package:bintango_indonesian_dictionary/shared/route/app_router.dart';
import 'package:bintango_indonesian_dictionary/shared/util/open_url.dart';
import 'package:bintango_indonesian_dictionary/shared/widget/text_wdiget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_framework/responsive_framework.dart';

class NotFoundPage extends ConsumerWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ColorConstants.bgPinkColor,
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
      body: Center(
        child: Column(
          children: [
            Lottie.asset(
              'assets/lottie/not_found_404.json',
              height: MediaQuery.of(context).size.height / 2,
            ),
            TextWidget.titleBlackLargestBoldNotSelectable('Page Not Found'),
            const SizedBox(height: 8,),
            _button(
                onPressed: () {
                  ref.read(routerProvider).go(AppRoute.path);
                },
                img: Assets.image.home128,
                title: 'トップに戻る',
            ),
          ],
        ),
      ),
    );
  }

  Widget _button({
    required VoidCallback? onPressed,
    required AssetGenImage img,
    required String title,}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorConstants.primaryRed900,
        backgroundColor: Colors.white,
        shape: const StadiumBorder(),
      ),
      child: SizedBox(
        height: 50,
        width: 112,
        child: Row(
          children: [
            img.image(height: 20, width: 20),
            const SizedBox(width: 8),
            Expanded(child: TextWidget.titleRedMediumNotSelectable(title)),
          ],
        ),
      ),
    );
  }
}
