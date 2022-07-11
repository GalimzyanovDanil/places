import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';

class CommonAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  /// AppBar height. Default 56.
  final double? toolbarHeight;
  final AsyncCallback onTrailingButtonTap;
  final VoidCallback? onSearchBarTap;
  final Widget trailingButtonIcon;
  final bool? autofocusOnSearchFiled;
  final TextEditingController? searchBarcontroller;
  final bool? enabled;
  final VoidCallback? onBackButtonTap;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);

  const CommonAppBarWidget({
    required this.onTrailingButtonTap,
    required this.trailingButtonIcon,
    this.onBackButtonTap,
    this.enabled,
    this.onSearchBarTap,
    this.autofocusOnSearchFiled,
    this.toolbarHeight,
    this.searchBarcontroller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      leading: onBackButtonTap != null
          ? IconButton(
              onPressed: onBackButtonTap,
              splashRadius: 15,
              icon: SvgPicture.asset(
                AppAssets.iconArrow,
                color: theme.iconTheme.color,
              ),
            )
          : null,
      toolbarHeight: toolbarHeight,
      centerTitle: true,
      title: Text(
        PlacesListStrings.appBarTitle,
        style: Theme.of(context).textTheme.headline4,
      ),
      bottom: SearchFieldWidget(
        onSearchBarTap: onSearchBarTap,
        onTrailingButtonTap: onTrailingButtonTap,
        trailingButtonIcon: trailingButtonIcon,
        autofocus: autofocusOnSearchFiled,
        controller: searchBarcontroller,
        enabled: enabled,
      ),
    );
  }
}

class SearchFieldWidget extends StatelessWidget implements PreferredSizeWidget {
  final double? toolbarHeight;
  final VoidCallback onTrailingButtonTap;
  final VoidCallback? onSearchBarTap;
  final Widget trailingButtonIcon;
  final bool? autofocus;
  final TextEditingController? controller;
  final bool? enabled;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);

  const SearchFieldWidget({
    required this.onTrailingButtonTap,
    required this.onSearchBarTap,
    required this.trailingButtonIcon,
    this.enabled,
    this.autofocus,
    this.controller,
    this.toolbarHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(12),
          color: theme.primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              SvgPicture.asset(
                AppAssets.iconSearch,
                color: theme.disabledColor,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: GestureDetector(
                  onTap: onSearchBarTap,
                  child: TextField(
                    controller: controller,
                    enabled: enabled,
                    autofocus: autofocus ?? false,
                    decoration: InputDecoration(
                      hintText: PlacesListStrings.hintText,
                      hintStyle: theme.textTheme.overline,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              IconButton(
                key: const ValueKey('Filter'),
                onPressed: onTrailingButtonTap,
                splashRadius: 15,
                icon: trailingButtonIcon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
