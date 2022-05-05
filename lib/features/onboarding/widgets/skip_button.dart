import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: () {},
      child: Text(
        'Пропустить',
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
