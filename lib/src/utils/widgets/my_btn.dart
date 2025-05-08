import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_silver/src/theme/theme.dart';
import 'package:gold_silver/src/utils/extensions/exts.dart';

class MyButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? icon;
  final String? title;
  final Color titleColor;
  final Color backgroundColor;
  final bool valid;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final int? flexInCombo;
  final BorderRadiusGeometry? borderRadius;

  const MyButton({
    super.key,
    this.onTap,
    this.icon,
    this.title,
    this.backgroundColor = AppColors.brandColor,
    this.titleColor = AppColors.white,
    this.valid = true,
    this.padding,
    this.margin,
    this.height,
    this.width,
    this.flexInCombo,
    this.borderRadius,
  });

  const MyButton.white({
    super.key,
    this.onTap,
    this.icon,
    this.title,
    this.valid = true,
    this.padding,
    this.margin,
    this.height,
    this.width,
    this.flexInCombo,
    this.titleColor = AppColors.schemeColor,
    this.borderRadius,
  }) : backgroundColor = AppColors.white;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 44,
        width: width,
        clipBehavior: Clip.hardEdge,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(6),
          color: valid ? backgroundColor : AppColors.black300,
        ),
        child: Visibility(
          visible: icon != null && title.isEmptyOrNull,
          replacement: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _icon(16),
                ),
              if (title.isNotEmptyOrNull) _title(),
            ],
          ),
          child: _icon(32),
        ),
      ),
    );
  }

  Widget _title() {
    return Flexible(
      child: Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
          color: valid ? titleColor : AppColors.white,
        ),
      ),
    );
  }

  Widget _icon(double size) {
    if (icon == null) return const SizedBox();
    return SvgPicture.asset(
      icon!,
      colorFilter: ColorFilter.mode(
        valid ? titleColor : AppColors.white,
        BlendMode.srcIn,
      ),
      height: size,
      width: size,
    );
  }
}
