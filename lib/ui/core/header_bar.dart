import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

// https://github.com/ubuntu-flutter-community/musicpod/blob/7f4cb79e500e7c1fe79907d48536be1bf199a53a/lib/src/common/common_widgets.dart#L108C1-L155C2

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const HeaderBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.style = YaruTitleBarStyle.normal,
    this.titleSpacing,
    this.backgroundColor = Colors.transparent,
    this.foregroundColor,
  });

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final YaruTitleBarStyle style;
  final double? titleSpacing;
  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return YaruWindowTitleBar(
      titleSpacing: titleSpacing,
      actions: actions,
      leading: leading,
      title: title,
      border: BorderSide.none,
      backgroundColor: backgroundColor,
      style: style,
    );
  }

  @override
  Size get preferredSize => const Size(0, kToolbarHeight);
}
