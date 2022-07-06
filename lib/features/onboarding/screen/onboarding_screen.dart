import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/onboarding/screen/onboarding_wm.dart';
import 'package:places/features/onboarding/strings/onboarding_strings.dart';
import 'package:places/features/onboarding/widgets/onboarding_page.dart';
import 'package:places/features/onboarding/widgets/page_indicator.dart';
import 'package:places/features/onboarding/widgets/skip_button.dart';
import 'package:places/features/onboarding/widgets/start_button.dart';
import 'package:surf_util/surf_util.dart';

/// Main widget for Onboarding module
class OnboardingScreen extends ElementaryWidget<IOnboardingWidgetModel> {
  const OnboardingScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultOnboardingWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IOnboardingWidgetModel wm) {
    const iconPaths = [
      AppAssets.iconOnboard1,
      AppAssets.iconOnboard2,
      AppAssets.iconOnboard3,
    ];
    const titles = [
      OnboardingStrings.title1,
      OnboardingStrings.title2,
      OnboardingStrings.title3,
    ];
    const texts = [
      OnboardingStrings.text1,
      OnboardingStrings.text2,
      OnboardingStrings.text3,
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          StateNotifierBuilder<bool>(
            listenableState: wm.isLastPage,
            builder: (_, isLastPage) => AnimatedOpacity(
              key: const ValueKey('SkipButton'),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              opacity: isLastPage ?? false ? 0.0 : 1.0,
              child: SkipButton(
                onPressed: wm.onSkipButton,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: DisableOverscroll(
          child: Stack(
            children: [
              PageView.builder(
                onPageChanged: wm.onPageChanged,
                controller: wm.pageController,
                itemBuilder: (_, index) => OnboardingPage(
                  iconPath: iconPaths[index],
                  tittle: titles[index],
                  text: texts[index],
                ),
                itemCount: wm.pageCount,
              ),
              StateNotifierBuilder<int>(
                listenableState: wm.currentPage,
                builder: (context, value) => PageIndicator(
                  currentPage: value ?? 0,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StateNotifierBuilder<bool>(
        listenableState: wm.isLastPage,
        builder: (_, isLastPage) {
          return AnimatedSlide(
            key: const ValueKey('StartButton'),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
            offset: isLastPage ?? false ? Offset.zero : const Offset(0, 2),
            child: StartButton(
              onPressed: wm.onStartButton,
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }
}
