import 'package:flutter/material.dart';
import 'package:places/features/common/widgets/network_image_widget.dart';
import 'package:places/features/places_list/domain/entity/place.dart';

class ImageViewWidget extends StatelessWidget {
  const ImageViewWidget({
    required this.place,
    required this.onPageChanged,
    required this.currentPage,
    required this.pageController,
    Key? key,
  }) : super(key: key);

  final Place place;
  final ValueSetter<int> onPageChanged;
  final int currentPage;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final urls = place.urls;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: const ClampingScrollPhysics(),
          itemCount: urls.length,
          itemBuilder: (_, index) {
            return NetworkImageWidget(imageUrl: urls[index]);
          },
        ),
        if (urls.length > 1)
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: 8,
              width: (screenWidth / place.urls.length) * currentPage,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: urls.length != currentPage
                        ? const BorderRadius.only(
                            bottomRight: Radius.circular(8),
                            topRight: Radius.circular(8),
                          )
                        : null),
              ),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
