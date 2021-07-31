import 'dart:ui';

import 'package:flutter/material.dart';

class TextAuth extends StatefulWidget {
  static String heldText = "";
  final String passedText;
  final bool isHidden;
  const TextAuth({Key? key, required this.passedText, required this.isHidden})
      : super(key: key);

  @override
  State<TextAuth> createState() => _TextAuth();
}

class _TextAuth extends State<TextAuth> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isHidden,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).accentColor, width: 5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 5.0),
        ),
        hintText: widget.passedText,
      ),
      controller: _controller,
      onChanged: (text) {},
    );
  }
}
