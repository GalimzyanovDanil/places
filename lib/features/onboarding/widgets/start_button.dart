import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      child: FloatingActionButton.extended(
        onPressed: () {},
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        label: Text(
          'НА СТАРТ',
          style: Theme.of(context).textTheme.button,
        ),
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
      ),
    );
  }
}
