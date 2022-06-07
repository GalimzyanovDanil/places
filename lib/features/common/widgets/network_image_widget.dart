import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/colors/app_colors.dart';
import 'package:places/assets/res/app_assets.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.maxFinite,
          child: CachedNetworkImage(
            filterQuality: FilterQuality.medium,
            imageUrl: imageUrl,
            imageBuilder: (_, imageProvider) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            placeholder: (context, url) => const _ImagePlaceholder(),
            // ignore: implicit_dynamic_parameter
            errorWidget: (context, url, error) => const _ImagePlaceholder(),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: double.maxFinite,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.whiteMain.withOpacity(0.3),
                  AppColors.whiteSecondary.withOpacity(0.08),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        AppAssets.iconPhoto,
        width: 70,
        height: 70,
        color: Theme.of(context).disabledColor,
      ),
    );
  }
}
