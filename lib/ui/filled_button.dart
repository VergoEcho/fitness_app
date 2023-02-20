import 'package:flutter/cupertino.dart';

class AppleFilledButton extends StatelessWidget {
  const AppleFilledButton({Key? key, required this.text, this.onPressed}) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      borderRadius: BorderRadius.circular(100),
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 4),
      minSize: 32,
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
