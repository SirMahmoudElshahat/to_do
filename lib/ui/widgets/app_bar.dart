import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key, required this.icon, required this.function})
      : super(key: key);

  final String icon;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppBarTheme.of(context).foregroundColor,
      leading: IconButton(
        onPressed: function,
        icon: Icon(
          icon == 'addTask'
              ? Icons.arrow_back_ios
              : Get.isDarkMode
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round_outlined,
          size: 24,
          color: IconTheme.of(context).color,
        ),
      ),
      elevation: 0,
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
          radius: 20,
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
