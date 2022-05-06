import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/onboarding/screen/onboarding_wm.dart';
import 'package:places/features/onboarding/widgets/onboarding_page.dart';
import 'package:places/features/onboarding/widgets/page_selector.dart';
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
    return Scaffold(
      appBar: AppBar(
        actions: [
          StateNotifierBuilder<int>(
            listenableState: wm.currentPageState,
            builder: (_, index) => Visibility(
              visible: index != 2,
              child: SkipButton(onPressed: wm.onSkipButton),
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
                    tittle: 'Добро пожаловать в Путеводитель',
                    text: 'Ищи новые локации и сохраняй самые любимые.',
                  ),
                  OnboardingPage(
                    iconPath: AppAssets.iconOnboard2,
                    tittle: 'Построй маршрут и отправляйся в путь',
                    text: 'Достигай цели максимально быстро и комфортно.',
                  ),
                  OnboardingPage(
                    iconPath: AppAssets.iconOnboard3,
                    tittle: 'Добавляй места, которые нашёл сам',
                    text: 'Делись самыми интересными и помоги нам стать лучше!',
                  ),
                ],
              ),
              Positioned.fill(
                bottom: 80,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: PageSelector(
                    tabController: wm.tabController,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StateNotifierBuilder<int>(
        listenableState: wm.currentPageState,
        builder: (_, index) => Visibility(
          visible: index == 2,
          child: StartButton(onPressed: wm.onStartButton),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }
}
