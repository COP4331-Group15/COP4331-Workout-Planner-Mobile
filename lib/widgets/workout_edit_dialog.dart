import 'package:flutter/material.dart';

class WorkoutEditDialogResult {
  final int startTime;
  final int unworkable;
  WorkoutEditDialogResult(this.startTime, this.unworkable);
}

class WorkoutEditDialog extends StatefulWidget {
  final int initialStartTime;
  final int initialUnworkable;
  const WorkoutEditDialog(
      {Key? key,
      required this.initialStartTime,
      required this.initialUnworkable})
      : super(key: key);

  @override
  _WorkoutEditDialogState createState() => _WorkoutEditDialogState();
}

class _WorkoutEditDialogState extends State<WorkoutEditDialog> {
  late bool _unworkable;
  late TimeOfDay _startTime;

  @override
  void initState() {
    super.initState();
    _unworkable = widget.initialUnworkable > 0;
    _startTime = TimeOfDay(
        hour: widget.initialStartTime ~/ 60,
        minute: widget.initialStartTime % 60);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Workout Settings"),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text("Start Time:"),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                        "${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}"),
                    onPressed: () async {
                      var result = await showTimePicker(
                          context: context, initialTime: _startTime);

                      if (result != null) {
                        setState(() {
                          _startTime = result;
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text("Unworkable"),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: Checkbox(
                  value: _unworkable,
                  onChanged: (v) {
                    if (v != null)
                      setState(() {
                        _unworkable = v;
                      });
                  },
                ),
              ))
            ],
          ),
        ),
        TextButton(
          child: Text("Save Changes"),
          onPressed: () {
            WorkoutEditDialogResult result = WorkoutEditDialogResult(
                _startTime.hour * 60 + _startTime.minute, _unworkable ? 1 : 0);

            Navigator.of(context).pop(result);
          },
        )
      ],
    );
  }
}
