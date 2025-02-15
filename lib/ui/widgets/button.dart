// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:to_do/ui/theme.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required String label,
    required dynamic Function() onTap,
  })  : _onTap = onTap,
        _label = label,
        super(key: key);

  final String _label;
  final Function() _onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        width: 100,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: primaryClr),
        child: Text(
          _label,
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
