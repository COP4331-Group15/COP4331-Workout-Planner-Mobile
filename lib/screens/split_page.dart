import 'dart:ui';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:large_project_app/utils/communication.dart';

import 'package:large_project_app/data/exercise.dart';
import 'package:large_project_app/data/split.dart';
import 'package:large_project_app/data/workout.dart';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

class SplitPage extends StatefulWidget {
  @override
  _SplitPageState createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  List<DragAndDropList> _contents = [];
  //final TextEditingController _email = new TextEditingController();
  //final TextEditingController _password = new TextEditingController();
  DateTime selectedDate = DateTime.now();
  Split Split_d = new Split(-1, -1, -1, []);

  @override
  void initState() {
    super.initState();
    print("1111anythingprintlol");
    debugPrint("1111anythinglol");
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => Communication.getSplit().then((value) {
              print("anythingprintlol");
              debugPrint("anythinglol");
              print(value);
              debugPrint("yyyy - " + value.startYear.toString());
              setState(() {
                Split_d = value;
                selectedDate = new DateTime(value.startYear, value.startMonth,
                    value.startDate, 0, 0, 0, 0, 0);
              });
            }));
    Communication.getExerciseUser().then((value) => print(value));
    Communication.getWorkoutUser().then((value) => print(value));
    _contents = List.generate(10, (index) {
      return DragAndDropList(
        header: Text('Header $index'),
        children: <DragAndDropItem>[
          DragAndDropItem(
            child: Text('$index.1'),
          ),
          DragAndDropItem(
            child: Text('$index.2'),
          ),
          DragAndDropItem(
            child: Text('$index.3'),
          ),
        ],
      );
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  int _count = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Split Page'),
      ),
      body: new Container(
        child: new Row(children: [
          Column(children: [
            // DragAndDropLists(
            //   children: _contents,
            //   onItemReorder: _onItemReorder,
            //   onListReorder: _onListReorder,
            // ),
            Text('You have pressed the button $_count times.')
          ]),
        ]),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => {_count++});
          _selectDate(context);
          Map data = {
            "startDate": 1,
            "startMonth": 0,
            "startYear": 2020,
            "workouts": [],
          };
          //Communication.postSplit(data);
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
    });
  }
}
