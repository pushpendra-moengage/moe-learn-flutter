import 'package:flutter/material.dart';
import 'package:moengage_flutter/moengage_flutter.dart';

void main() {
  runApp(MaterialApp(
    home: Text('Hello AP'),
  ));
}

class MoELearn extends StatefulWidget {
  @override
  State<MoELearn> createState() => _MoELearnState();
}

class _MoELearnState extends State<MoELearn> {

  String MoEAppID = "8SIW681S80Z08KSHQFSTIZ8T";
  final MoEngageFlutter _moengagePlugin = MoEngageFlutter("8SIW681S80Z08KSHQFSTIZ8T");

  @override
  void initState(){
    super.initState();
    _moengagePlugin.initialise();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

