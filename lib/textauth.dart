import 'dart:ui';

import 'package:flutter/material.dart';

class TextAuth extends StatefulWidget {
  final String passedText;
  const TextAuth({Key? key, required this.passedText}) : super(key: key);

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
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 5.0),
        ),
        hintText: widget.passedText,
      ),
      controller: _controller,
      onSubmitted: (String value) async {
        await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Input recieved',
                textAlign: TextAlign.center,
              ),
              content: Text(
                'You typed "$value", which has length ${value.characters.length}.',
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      _controller.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
