import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:moengage_flutter/model/app_status.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MoELearn());
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

    _moengagePlugin.enableAdIdTracking();

    // _moengagePlugin.disableAdIdTracking();
    _moengagePlugin.setAppStatus(MoEAppStatus.install);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

