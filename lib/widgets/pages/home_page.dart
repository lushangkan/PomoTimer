import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: TopBar(theme),
    );
  }
}

class TopBar extends AppBar {

  TopBar(ThemeData theme, {super.key}) : super(
    backgroundColor: Colors.transparent,
    leading: Container(
      margin: const EdgeInsets.only(left: 15),
      child: IconButton(
        iconSize: 25,
        icon: Icon(LucideIcons.settings, color: theme.colorScheme.onBackground),
        onPressed: () {
          // TODO 跳转到设置
        },
      ),
    )
  );

}
