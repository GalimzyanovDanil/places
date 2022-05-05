import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/onboarding/screen/onboarding_wm.dart';
import 'package:places/features/onboarding/widgets/onboarding_page.dart';
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
    final pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Visibility(
            // visible: ,
            child: SkipButton(),
          ),
        ],
      ),
      body: Center(
        child: DisableOverscroll(
          child: Stack(
            children: [
              PageView(
                onPageChanged: (value) {},
                controller: pageController,
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
              const Positioned(
                left: 100,
                bottom: 100,
                child: SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const Visibility(
        child: StartButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
    );
  }
}
