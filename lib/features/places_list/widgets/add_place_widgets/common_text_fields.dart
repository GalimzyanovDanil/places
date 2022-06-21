import 'package:flutter/material.dart';
import 'package:places/features/places_list/widgets/add_place_widgets/delete_icon_button.dart';

class CommonTextField extends StatefulWidget {
  final VoidCallback onClearText;
  final String title;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;

  CommonTextField({
    required this.onClearText,
    required this.title,
    this.maxLines,
    this.textInputAction,
    this.keyboardType,
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late final TextEditingController controller;
  late final FocusNode focusNode;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: theme.textTheme.overline,
        ),
        const SizedBox(height: 12),
        AnimatedBuilder(
          animation: Listenable.merge(
            <Listenable>[focusNode, controller],
          ),
          builder: (_, __) {
            final isActive = controller.text.isNotEmpty && focusNode.hasFocus;

            return TextFormField(
              focusNode: focusNode,
              style: theme.textTheme.bodyText1,
              maxLines: widget.maxLines ?? 1,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction ?? TextInputAction.next,
              controller: controller,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                suffixIcon: isActive
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: DeleteIconButton(
                          onTap: widget.onClearText,
                          backgroundColor: theme.colorScheme.tertiary,
                          iconColor: theme.colorScheme.onTertiary,
                        ),
                      )
                    : const SizedBox.shrink(),
                isDense: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
