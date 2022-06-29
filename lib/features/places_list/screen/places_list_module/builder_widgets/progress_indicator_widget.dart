import 'package:flutter/material.dart';
import 'package:places/features/common/widgets/skeleton.dart';

class ProgresIndicatorWidget extends StatelessWidget {
  const ProgresIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List<Widget>.generate(
            3,
            (_) => Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                _CardLoader(),
                SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardLoader extends StatelessWidget {
  const _CardLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Expanded(
                        child: Skeleton(height: double.infinity),
                      ),
                      Expanded(
                        child: Container(
                          color: theme.primaryColor,
                          width: double.infinity,
                          height: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                Skeleton(
                                  height: 18,
                                  width: (screenSize.width) / 4,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                const SizedBox(height: 2),
                                Skeleton(
                                  height: 18,
                                  width: double.infinity,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                const SizedBox(height: 2),
                                Skeleton(
                                  height: 18,
                                  width: double.infinity,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Skeleton(
                height: 24,
                width: 24,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Skeleton(
                height: 18,
                width: 92,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
