import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/font_manager.dart';
import 'package:clot/core/presentation/ui/extension/fontsize_extension.dart';
import 'package:flutter/widgets.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.styles,
    this.textAlign,
    this.color,
    this.fontSizes,
    this.fontWeight,
    this.softWrap,
  });

  final String text;
  final TextStyle? styles;
  final TextAlign? textAlign;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSizes;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSizes,
        fontWeight: fontWeight,
      ).merge(styles),
      textAlign: textAlign,
      softWrap: softWrap ?? true,
    );
  }
}

class TextHeading extends AppText {
  const TextHeading(
    super.text, {
    super.key,
    super.textAlign,
    super.color,
    super.fontWeight,
    super.fontSizes,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSizes ?? 32,
        fontWeight: fontWeight ?? FontManagerWeight.bold,
        color: color,
      ),
      textAlign: textAlign,
    );
  }
}

class TextMedium extends AppText {
  const TextMedium(
    super.text, {
    super.key,
    super.textAlign,
    super.color,
    super.fontWeight,
    super.fontSizes,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSizes ?? 24,
        fontWeight: fontWeight ?? FontManagerWeight.semiBold,
        color: color,
      ),
      textAlign: textAlign,
    );
  }
}

class TextRegular extends AppText {
  const TextRegular(
    super.text, {
    super.key,
    super.textAlign,
    super.color,
    super.fontWeight,
    super.fontSizes,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSizes ?? 16.fs,
        fontWeight: fontWeight ?? FontManagerWeight.regular,
        color: color,
      ),
      textAlign: textAlign,
      softWrap: softWrap ?? true,
    );
  }
}

class TextSmall extends AppText {
  const TextSmall(
    super.text, {
    super.key,
    super.textAlign,
    super.color,
    super.fontWeight,
    super.fontSizes,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSizes ?? 12.fs,
        fontWeight: fontWeight ?? FontManagerWeight.regular,
        color: color ?? AppColors.kBlcak100,
      ),
      textAlign: textAlign,
      softWrap: softWrap ?? true,
    );
  }
}

class AppRichText extends StatelessWidget {
  final String? text;
  final List<InlineSpan> textSpan;
  final TextAlign? textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextStyle? styles;

  const AppRichText({
    super.key,
    required this.textSpan,
    this.text,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.styles,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text ?? '',
        children: textSpan,
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
        ).merge(styles),
      ),
      textAlign: textAlign,
    );
  }
}
