import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:pomotimer/common/app_text_style.dart';
import 'package:pomotimer/themes/app_theme.dart';

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
      color: fromCssColor("#E8590C"),
      shadows: [
        Shadow(
          color: fromCssColor("#E8590C").withOpacity(0.25),
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
      padding: const EdgeInsets.only(top: 50),
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
                            Text("版本: v0.1.0", style: versionText,),
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
      color: themeColor.onSurfaceVariant,
      fontSize: 16,
      fontWeight: FontWeight.w500
    );

    var contentText = AppTextStyle.generate(
      color: themeColor.onSurfaceVariant,
      fontSize: 16,
      fontWeight: FontWeight.w300
    );
    
    return Container(
      width: 323,
      height: 157,
      decoration: BoxDecoration(
        color: themeColor.surfaceContainer,
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
              Text("开发者:", style: titleText,),
              const SizedBox(width: 5,),
              Text("路上看见", style: contentText,),
            ],),
            // 代码仓库: lushangkan/PomoTimer
            Row(children: [
              SizedBox(child: Icon(LucideIcons.github, color: themeColor.onSurfaceVariant,size: 25, )),
              const SizedBox(width: 7,),
              Text("代码仓库:", style: titleText,),
              const SizedBox(width: 5,),
              Text("lushangkan/PomoTimer", style: contentText,),
            ],),
            // 代码协议: GPLv3
            Row(children: [
              SizedBox(child: Icon(LucideIcons.creative_commons, color: themeColor.onSurfaceVariant,size: 25, )),
              const SizedBox(width: 7,),
              Text("代码协议:", style: titleText,),
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
        color: themeColor.onSurfaceVariant,
        fontSize: 16,
        fontWeight: FontWeight.w500
    );

    var contentText = AppTextStyle.generate(
        color: themeColor.onSurfaceVariant,
        fontSize: 15,
        fontWeight: FontWeight.w300
    );

    var lagerTitleText = AppTextStyle.generate(
        color: themeColor.onSurfaceVariant,
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
              Text("鸣谢", style: lagerTitleText,),
            ],),
          ),
          Container(
            width: 323,
            height: 60,
            decoration: BoxDecoration(
              color: themeColor.surfaceContainer,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20, left: 26),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text("imsale", style: titleText,),
                const SizedBox(width: 5,),
                Text("提供Logo设计指导", style: contentText,),
              ],)
            ),
          ),
        ],
      ),
    );
  }
  
}