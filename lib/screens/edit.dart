import 'package:flutter/material.dart';
import 'package:large_project_app/widgets/appbar.dart';

class EditPage extends StatelessWidget {
  const EditPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: CustomAppBar()), body: Container());
  }
}
