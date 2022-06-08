import 'package:flutter/material.dart';
import 'package:places/features/common/widgets/network_image_widget.dart';
import 'package:places/features/places_list/domain/entity/place.dart';

class ImageViewWidget extends StatelessWidget {
  const ImageViewWidget({
    required this.place,
    required this.pageOffset,
    required this.pageController,
    Key? key,
  }) : super(key: key);

  final Place place;
  final double pageOffset;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final urls = place.urls;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
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
              width: (screenWidth / place.urls.length) * (pageOffset + 1),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
              ),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
