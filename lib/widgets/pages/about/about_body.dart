import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:pomotimer/common/app_text_style.dart';
import 'package:pomotimer/themes/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/constants.dart';
import '../../../generated/l10n.dart';

class AboutBody extends StatelessWidget {
  const AboutBody({super.key});

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;

    return const Column(
        children: [
          Head(),
          SizedBox(height: 50,),
          DeveloperInfo(),
          Acknowledgments(),
          CopyRight(),
          Bottom(),
        ],
      );
  }
}

class Head extends StatelessWidget {
  const Head({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var logoText = AppTextStyle.generate(
      fontSize: 20,
      color: fromCssColor("#E8580C"),
      shadows: [
        Shadow(
          color: fromCssColor("#E8580C").withOpacity(0.25),
          offset: const Offset(1, 1),
          blurRadius: 4,
        ),
      ],
      fontWeight: FontWeight.bold,
    );

    var versionText = AppTextStyle.generate(
      fontSize:13,
      fontWeight: FontWeight.w200,
      color: fromCssColor("#333333"),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: 280,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 60,
                    child: Image(image: AssetImage("assets/media/image/logo.png")),
                  ),
                  SizedBox(
                    height: 70,
                    width: 121,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("PomoTimer", style: logoText),
                        Container(
                          width: 120,
                          height: 1,
                          color: fromCssColor("#333333").withAlpha(80),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${S.current.version}: v0.1.0", style: versionText,),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DeveloperInfo extends StatelessWidget {
  const DeveloperInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;

    var titleText = AppTextStyle.generate(
      color: themeColor.onSurface,
      fontSize: 16,
      fontWeight: FontWeight.w500
    );

    var contentText = AppTextStyle.generate(
      color: themeColor.onSurface,
      fontSize: 16,
      fontWeight: FontWeight.w300
    );
    
    return Container(
      width: 323,
      height: 157,
      decoration: BoxDecoration(
        color: themeColor.primaryContainer.withAlpha(80),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
    ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20, left: 26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(children: [
              SizedBox(child: Icon(LucideIcons.code_xml, color: themeColor.onSurfaceVariant,size: 25, )),
              const SizedBox(width: 7,),
              Text("${S.current.developer}:", style: titleText,),
              const SizedBox(width: 5,),
              Text(S.current.lushangkan, style: contentText,),
            ],),
            // 代码仓库: lushangkan/PomoTimer
            Row(children: [
              SizedBox(child: Icon(LucideIcons.github, color: themeColor.onSurfaceVariant,size: 25, )),
              const SizedBox(width: 7,),
              Text("${S.current.codeRepo}:", style: titleText,),
              const SizedBox(width: 5,),
              Text("lushangkan/PomoTimer", style: contentText,),
            ],),
            // 代码协议: GPLv3
            Row(children: [
              SizedBox(child: Icon(LucideIcons.creative_commons, color: themeColor.onSurfaceVariant,size: 25, )),
              const SizedBox(width: 7,),
              Text("${S.current.codeLicense}:", style: titleText,),
              const SizedBox(width: 5,),
              Text("GPLv3", style: contentText,),
            ],),
          ],

        ),
      ),
    );
  }
}

class Acknowledgments extends StatelessWidget {
  const Acknowledgments({super.key});

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;

    var titleText = AppTextStyle.generate(
        color: themeColor.onSurface,
        fontSize: 16,
        fontWeight: FontWeight.w500
    );

    var contentText = AppTextStyle.generate(
        color: themeColor.onSurface,
        fontSize: 15,
        fontWeight: FontWeight.w300
    );

    var lagerTitleText = AppTextStyle.generate(
        color: themeColor.onSurface,
        fontSize: 18,
        fontWeight: FontWeight.w500
    );

    return SizedBox(
      width: 323,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(children: [
              Text(S.current.acknowledgments, style: lagerTitleText,),
            ],),
          ),
          Container(
            width: 323,
            height: 60,
            decoration: BoxDecoration(
              color: themeColor.primaryContainer.withAlpha(80),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20, left: 26),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text("Imsale", style: titleText,),
                const SizedBox(width: 5,),
                Text(S.current.acknowledgmentsLogoDesign, style: contentText,),
              ],)
            ),
          ),
        ],
      ),
    );
  }


  
}
/// 版权信息
class CopyRight extends StatelessWidget {
  const CopyRight({super.key});

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme;

    var titleText = AppTextStyle.generate(
        color: themeColor.onSurface,
        fontSize: 16,
        fontWeight: FontWeight.w500
    );

    var contentText = AppTextStyle.generate(
        color: themeColor.onSurface,
        fontSize: 16,
        fontWeight: FontWeight.w300
    );

    var lagerTitleText = AppTextStyle.generate(
        color: themeColor.onSurface,
        fontSize: 18,
        fontWeight: FontWeight.w500
    );

    return SizedBox(
      width: 323,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(children: [
              Text(S.current.copyrightInfo, style: lagerTitleText,),
            ],),
          ),
          Container(
            decoration: BoxDecoration(
              color: themeColor.primaryContainer.withAlpha(80),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20, left: 26),
              child: Row(children: [
                Text("${S.current.fontCopyRight}:", style: titleText,),
                const SizedBox(width: 5,),
                Text("MiSans", style: contentText,),
              ],),
            ),
          ),
        ],
      ),
    );
  }
}

class Bottom extends StatelessWidget {
  const Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20),
      child: SizedBox(
        width: 323,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Sponsor(),

            BugReport(),
          ],
        ),
      ),
    );
  }
}

class Sponsor extends StatelessWidget {
  const Sponsor({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var themeColor = Theme.of(context).colorScheme;

    var titleStyle = AppTextStyle.generate(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: themeColor.onSurface,
    );

    var buttonTextStyle = AppTextStyle.generate(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: themeColor.onPrimaryContainer,
    );

    var buttonStyle = FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: theme.colorScheme.primaryContainer.withAlpha(80),
    );

    void onClick() {
      var url = Uri.parse(Constants.sponsorUrl);
      try {
        launchUrl(url);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('无法打开链接: ${url.toString()} 原因: $e'),
          ),
        );
      }
    }

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 11,bottom: 20),
                child: Text(S.current.sponsor, style: titleStyle,),
              ),
              SizedBox(
                width: 160,
                height: 50,
                child: FilledButton(
                  style: buttonStyle,
                  onPressed: onClick,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width:30, child: Image(image: AssetImage("assets/media/image/aifadian.png"))),
                        const SizedBox(width: 5,),
                        Text(S.current.afadiana, style: buttonTextStyle,)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BugReport extends StatelessWidget {
  const BugReport({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var themeColor = Theme.of(context).colorScheme;

    var titleStyle = AppTextStyle.generate(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: themeColor.onSurface,
    );

    var buttonTextStyle = AppTextStyle.generate(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: themeColor.onPrimaryContainer,
    );

    var buttonStyle = FilledButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: theme.colorScheme.primaryContainer.withAlpha(80),
    );

    void onClick() {
      var url = Uri.parse(Constants.issueUrl);
      try {
        launchUrl(url);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('无法打开链接: ${url.toString()} 原因: $e'),
          ),
        );
      }
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 11,bottom: 20),
          child: Text(S.current.bugReport, style: titleStyle,),
        ),
        SizedBox(
          width: 145,
          height: 50,
          child: FilledButton(
            style: buttonStyle,
            onPressed: onClick,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(LucideIcons.github, size: 25, color: themeColor.onPrimaryContainer,),
                  const SizedBox(width: 5,),
                  Text("Github", style: buttonTextStyle,)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  
}