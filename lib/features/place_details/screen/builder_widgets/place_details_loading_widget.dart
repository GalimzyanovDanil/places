import 'package:flutter/material.dart';
import 'package:places/features/common/widgets/skeleton.dart';

class PlaceDetailsLoadingWidget extends StatelessWidget {
  final bool isLoading;
  final Widget backButton;

  final double height;

  const PlaceDetailsLoadingWidget({
    required this.isLoading,
    required this.backButton,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height,
        leading: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(height: 56, child: backButton),
        ),
        flexibleSpace: const Skeleton(
          width: double.infinity,
          height: double.infinity,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Skeleton(
              width: (screenSize.width / 4) * 3,
              height: textTheme.headline2?.fontSize ?? 16,
              borderRadius: BorderRadius.circular(7),
            ),
            const SizedBox(height: 2),
            Skeleton(
              width: screenSize.width / 4,
              height: textTheme.subtitle2?.fontSize ?? 16,
              borderRadius: BorderRadius.circular(7),
            ),
            const SizedBox(height: 24),
            ...List.generate(
              8,
              (index) => Column(
                children: [
                  Skeleton(
                    width: screenSize.width,
                    height: textTheme.subtitle1?.fontSize ?? 16,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  const SizedBox(height: 2),
                ],
              ),
            ),
            const Spacer(),
            Skeleton(
              width: screenSize.width,
              height: 48,
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(height: 24),
            Divider(
              height: 0,
              color: theme.colorScheme.onBackground,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Skeleton(
                  width: 150,
                  height: 30,
                  borderRadius: BorderRadius.circular(12),
                ),
                Skeleton(
                  width: 150,
                  height: 30,
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
