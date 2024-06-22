
import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle? generate({
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>?shadows,
    List<FontFeature>? fontFeatures,
    List<FontVariation>? fontVariations,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    TextOverflow? overflow,
  }) {
    return TextStyle(
      inherit: inherit,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      leadingDistribution: leadingDistribution,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      fontVariations: _generateFontVariations(oldVariation: fontVariations, fontWeight: fontWeight),
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      debugLabel: debugLabel,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
      package: package,
      overflow: overflow,
    );
  }

  static TextStyle? generateWithTextStyle(TextStyle oldStyle) {
    return oldStyle.copyWith(
      fontWeight: null,
      fontVariations: _generateFontVariations(oldVariation: oldStyle.fontVariations, fontWeight: oldStyle.fontWeight),
    );
  }

  static List<FontVariation> _generateFontVariations({List<FontVariation>? oldVariation, FontWeight? fontWeight}) {
    oldVariation = oldVariation ?? [];
    fontWeight = fontWeight ?? FontWeight.normal;

    List<FontVariation> newVariation = oldVariation.where((element) => element.axis != 'wght').toList();
    newVariation.add(FontVariation('wght', _getWGHTValue(fontWeight)));
    return newVariation;
  }

  static double _getWGHTValue(FontWeight fontWeight) {
    return (fontWeight.index + 1) * 100.00;
  }
}