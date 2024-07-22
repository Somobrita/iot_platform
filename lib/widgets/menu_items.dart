import 'package:flutter/material.dart';

/// Created by Chandan Jana on 10-09-2023.
/// Company name: Mindteck
/// Email: chandan.jana@mindteck.com

class MenuItems extends StatelessWidget {
  const MenuItems(
      {super.key,
      required this.textSize,
      required this.iconSize,
      required this.menuName,
      required this.menuImg,
      required this.onMenuItemClick});

  final String menuName;
  final IconData menuImg;
  final double textSize;
  final double iconSize;
  final void Function(String menuName) onMenuItemClick;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        menuImg,
        size: iconSize,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      title: Text(
        menuName,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: textSize,
            ),
      ),
      onTap: () {
        onMenuItemClick(menuName);
      },
    );
  }
}
