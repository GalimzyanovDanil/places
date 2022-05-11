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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            StateNotifierBuilder<bool>(
              listenableState: wm.isLastPage,
              builder: (_, isLastPage) => SkipButton(
                onPressed: wm.onSkipButton,
                visible: !(isLastPage ?? false),
              ),
            ),
          ],
        ),
        body: Center(
          child: DisableOverscroll(
            child: Stack(
              children: [
                PageView(
                  onPageChanged: wm.onPageChanged,
                  controller: wm.pageController,
                  children: const <Widget>[
                    OnboardingPage(
                      iconPath: AppAssets.iconOnboard1,
                      tittle: OnboardingStrings.title1,
                      text: OnboardingStrings.text1,
                    ),
                    OnboardingPage(
                      iconPath: AppAssets.iconOnboard2,
                      tittle: OnboardingStrings.title2,
                      text: OnboardingStrings.text2,
                    ),
                    OnboardingPage(
                      iconPath: AppAssets.iconOnboard3,
                      tittle: OnboardingStrings.title3,
                      text: OnboardingStrings.text3,
                    ),
                  ],
                ),
                PageIndicator(
                  tabController: wm.tabController,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: StateNotifierBuilder<bool>(
          listenableState: wm.isLastPage,
          builder: (_, isLastPage) => StartButton(
            onPressed: wm.onStartButton,
            visible: isLastPage ?? false,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
