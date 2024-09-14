import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_spotify/common/helpers/is_dark_mode.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;
  final Color? backgroundColor;
  final double? height;
  final Widget? leading;
  const BasicAppbar(
      {this.title,
      this.leading,
      this.action,
      this.backgroundColor,
      super.key,
      this.height});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      toolbarHeight: height ?? 50,
      centerTitle: true,
      title: title ?? const Text(''),
      actions: [action ?? Container()],
      leading: leading ??
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? Colors.white.withOpacity(0.03)
                      : Colors.black.withOpacity(0.04),
                  shape: BoxShape.circle),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 15,
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
