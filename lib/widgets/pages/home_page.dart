import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primaryContainer,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        leading: IconButton(
          icon: Icon(LucideIcons.settings, color: theme.colorScheme.onBackground),
          onPressed: () {},
        ),
      ),
    );
  }
}