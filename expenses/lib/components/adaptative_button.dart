import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  const AdaptativeButton({
    required this.label, required this.onPressed
  });


  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? 
      CupertinoButton(
        onPressed: () => onPressed,
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(label),
      )
      : ElevatedButton(
        style: TextButton.styleFrom(primary: Theme.of(context).textTheme.button?.color,),
        onPressed: () => onPressed,
        child: Text(label),
      );
  }
}