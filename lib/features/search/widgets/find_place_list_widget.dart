import 'package:flutter/material.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/widgets/network_image_widget.dart';

class FindPlaceListWidget extends StatelessWidget {
  final List<Place>? placesList;
  final ValueSetter<int> onTapPlace;
  final String queryText;

  const FindPlaceListWidget({
    required this.queryText,
    required this.placesList,
    required this.onTapPlace,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.separated(
      separatorBuilder: (_, __) => Divider(
        indent: 80,
        height: 10,
        color: theme.disabledColor,
      ),
      shrinkWrap: true,
      itemCount: placesList?.length ?? 0,
      itemBuilder: (_, index) {
        var tempName = placesList![index].name.toString();

        final indexQuery =
            tempName.toLowerCase().indexOf(queryText.toLowerCase());
        final queryTextSpan = TextSpan(
          text: tempName.substring(indexQuery, indexQuery + queryText.length),
          style: theme.textTheme.bodyText1
              ?.copyWith(color: theme.colorScheme.primary),
        );

        tempName = tempName.replaceRange(
          indexQuery,
          indexQuery + queryText.length,
          '|',
        );

        final resultListTextSpan = tempName
            .split('|')
            .map((e) => TextSpan(text: e, style: theme.textTheme.bodyText1))
            .toList()
          ..insert(1, queryTextSpan);

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Stack(
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: NetworkImageWidget(
                        imageUrl: placesList![index].urls.isNotEmpty
                            ? placesList![index].urls.first
                            : null,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: resultListTextSpan,
                              ),
                              maxLines: 2,
                            ),
                            Text(
                              placesList![index].placeType.filterTitle,
                              style: theme.textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => onTapPlace(index),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
