import 'package:flutter/material.dart';
import 'package:places/features/places_list/widgets/add_place_widgets/delete_icon_button.dart';

class CommonTextField extends StatefulWidget {
  final String title;
  final TextInputType? keyboardType;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String?>? validator;
  final ValueChanged<String?> onFieldSubmitted;

  const CommonTextField({
    required this.title,
    required this.onFieldSubmitted,
    this.validator,
    this.maxLines,
    this.textInputAction,
    this.keyboardType,
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
    controller = TextEditingController();
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
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: textTheme.overline,
        ),
        const SizedBox(height: 12),
        AnimatedBuilder(
          animation: Listenable.merge(
            <Listenable>[focusNode, controller],
          ),
          builder: (_, __) {
            final isActive = controller.text.isNotEmpty && focusNode.hasFocus;

            const border = OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            );

            return TextFormField(
              onSaved: (newValue) => widget.onFieldSubmitted(newValue),
              validator: widget.validator,
              focusNode: focusNode,
              style: textTheme.bodyText1,
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
                          onTap: controller.clear,
                          backgroundColor: colorScheme.tertiary,
                          iconColor: colorScheme.onTertiary,
                        ),
                      )
                    : const SizedBox.shrink(),
                isDense: true,
                border: border,
                enabledBorder: controller.text.isNotEmpty && !focusNode.hasFocus
                    ? border.copyWith(
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 0.5,
                        ),
                      )
                    : null,
              ),
            );
          },
        ),
      ],
    );
  }
}
