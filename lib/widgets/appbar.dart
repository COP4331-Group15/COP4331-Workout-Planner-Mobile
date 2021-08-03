import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hercules\'',
              style: TextStyle(
                  fontFamily: 'ChunkFive', fontSize: 15, color: Colors.black),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              child: Image.asset(
                'assets/dumbell.png',
                width: 70,
                height: 40,
              ),
            ),
            Text(
              'Notebook',
              style: TextStyle(
                  fontFamily: 'ChunkFive', fontSize: 15, color: Colors.black),
            ),
          ],
        ));
  }
}
