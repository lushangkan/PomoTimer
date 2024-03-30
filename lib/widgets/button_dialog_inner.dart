import 'package:flutter/material.dart';
import 'package:pomotimer/common/app_text_style.dart';

class ButtonDialogInner extends StatelessWidget {
  const ButtonDialogInner(
      {super.key, required this.title, required this.content, this.selectMode = true});

  final String title;
  final String content;
  final bool selectMode;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    var titleTextTheme = AppTextStyle.generateWithTextStyle(
        theme.textTheme.titleLarge!.copyWith(
      fontWeight: FontWeight.w500,
    ));
    var contentTextTheme =
        AppTextStyle.generateWithTextStyle(theme.textTheme.bodyLarge!.copyWith(
          fontSize: 15,
      fontWeight: FontWeight.w300,
          height: 1.7,
    ));

    var confirmButtonTheme = FilledButton.styleFrom(
      backgroundColor: colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9999),
      ),
      textStyle: AppTextStyle.generateWithTextStyle(theme.textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w400,
        color: colorScheme.onPrimary,
        fontSize: 16
      )),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
    );

    var cancelButtonTheme = FilledButton.styleFrom(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(9999),
      ),
      textStyle: AppTextStyle.generateWithTextStyle(theme.textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      )),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
    );

    void onClickCancelButton() {
      Navigator.of(context).pop(false);
    }

    void onClickConfirmButton() {
      Navigator.of(context).pop(true);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: titleTextTheme,
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              content.replaceAll(RegExp(r'\n'), "\n\n"),
              style: contentTextTheme,
            ),
          ),
          const SizedBox(height: 40),
          if (selectMode)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton(
                onPressed: onClickCancelButton,
                style: cancelButtonTheme,
                child: const Text('取消'),
              ),
              FilledButton(
                onPressed: onClickConfirmButton,
                style: confirmButtonTheme,
                child: const Text('确定'),
              ),
            ],
          ),
          if (!selectMode)
          FilledButton(
            onPressed: onClickConfirmButton,
            style: confirmButtonTheme,
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
