import 'package:flutter/material.dart';

class ExerciseListEntry extends StatelessWidget {
  final VoidCallback onTapped;
  final VoidCallback onDelete;
  final String title;
  const ExerciseListEntry(
      {Key? key,
      required this.onTapped,
      required this.onDelete,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 4.0,
        ),
        child: ElevatedButton(
          onPressed: onTapped,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(20)),
              elevation: 0,
              primary: Colors.white),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              child: Text(title, style: TextStyle(color: Colors.black)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: ElevatedButton(
                child: Icon(Icons.close),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[300],
                  onPrimary: Colors.grey[400],
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: onDelete,
              ),
            ),
          ]),
        ));
  }
}
