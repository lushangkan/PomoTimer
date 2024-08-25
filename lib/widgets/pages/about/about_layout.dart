import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomotimer/widgets/pages/app_page.dart';
import 'package:pomotimer/widgets/pages/home/click_listener.dart';
import 'package:pomotimer/widgets/pages/about/about_body.dart';

class AboutPage extends AppPage {
  const AboutPage({super.key});

  @override
  State<StatefulWidget> createState() => _AboutPageState();
}

class _AboutPageState extends AppPageState<AboutPage> {
  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: themeColor,
      appBar: TopBar(Theme.of(context), context),
      body: const AboutBody(),
    );
  }
}


class TopBar extends AppBar {
  TopBar(ThemeData theme, BuildContext context, {super.key})
      : super(
      backgroundColor: Colors.transparent,
      title: Text("关于", style: theme.textTheme.titleLarge,),
      leading: Container(
        margin: const EdgeInsets.only(left: 15),
        child: IconButton(
          iconSize: 25,
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface,),
          onPressed: () {
            context.go('/');
          },
        ),
      ));
}