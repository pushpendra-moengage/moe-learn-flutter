import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:moengage_flutter/model/app_status.dart';
import 'package:moengage_flutter/model/inapp/click_data.dart';
import 'package:moengage_flutter/model/inapp/inapp_data.dart';
import 'package:moengage_flutter/model/push/push_campaign_data.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:moengage_flutter/properties.dart';
import 'package:moengage_inbox/inbox_data.dart';
import 'package:moengage_inbox/inbox_message.dart';
import 'package:moengage_inbox/moengage_inbox.dart';
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

  MoEngageInbox _moengageInbox = MoEngageInbox("8SIW681S80Z08KSHQFSTIZ8T");

  @override
  void initState() {
    super.initState();
    _moengagePlugin.setPushClickCallbackHandler(_onPushClick);

    _moengagePlugin.setInAppClickHandler(_onInAppClick);
    _moengagePlugin.setInAppShownCallbackHandler(_onInAppShown);
    _moengagePlugin.setInAppDismissedCallbackHandler(_onInAppDismiss);

    _moengagePlugin.initialise();

    //_moengagePlugin.showInApp();

    //_moengagePlugin.enableAdIdTracking();

    // _moengagePlugin.disableAdIdTracking();
    // _moengagePlugin.setAppStatus(MoEAppStatus.install);

    //_moengagePlugin.setUniqueId("Allo");

    // _moengagePlugin.logout();

    var myProps = MoEProperties();
    myProps.addAttribute("name", "Allo");
    myProps.addAttribute("key", "some_value");

    // _moengagePlugin.trackEvent("My custom event", myProps);

  }

  void _onPushClick(PushCampaignData message) {
    print("MoE My notification click -> " + message.toString());
  }

  void _onInAppClick(ClickData message) {
    print("MoE My InApp Click Data : " + message.toString());
  }

  void _onInAppShown(InAppData message) {
    print("MoE My InApp Shown Data : " + message.toString());
  }

  void _onInAppDismiss(InAppData message) {
    print("MoE Mi InApp dismiss data : " + message.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Demo App"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [
                ElevatedButton(onPressed: () async {
                  InboxData? data = await _moengageInbox.fetchAllMessages();
                  print("MoE : " + data.toString());
                }, child: Text("Inbox"),),
                ElevatedButton(onPressed: () async {
                  int count = await _moengageInbox.getUnClickedCount();
                  print("MOE" + count.toString());
                }, child: Text("Unclicked Count")),
                ElevatedButton(onPressed: () async {
                  InboxData? data = await _moengageInbox.fetchAllMessages();
                  if(data != null){
                    for(InboxMessage msg in data.messages){
                      _moengageInbox.trackMessageClicked(msg);
                    }
                  }
                }, child: Text("Click all messages")),
                ElevatedButton(onPressed: () async {
                  InboxData? inboxData = await _moengageInbox.fetchAllMessages();
                  if(inboxData != null){
                    for(InboxMessage msg in inboxData.messages){
                      if(msg.isClicked){
                        _moengageInbox.deleteMessage(msg);
                      }
                    }
                  }
                }, child: Text("Delete clicked messages")),
                ElevatedButton(
                  onPressed: () {
                    _moengagePlugin.setUniqueId("8708153354");
                  },
                  child: Text("Login"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _moengagePlugin.logout();
                  },
                  child: Text("Logout"),
                ),
                ElevatedButton(
                  onPressed: () {
                    //.optOutDataTracking(true);
                  },
                  child: Text("optOutTracking"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _moengagePlugin.setUserName("Vipin Kumar");
                    _moengagePlugin.setFirstName("Vipin");
                    _moengagePlugin.setLastName("Kumar");
                    _moengagePlugin.setEmail("vicky7230@gmail.com");
                    _moengagePlugin.setPhoneNumber("8708153354");
                    //_moengagePlugin.setGender(MoEGender
                    //    .male); // Supported values also include MoEGender.female OR MoEGender.other
                    //_moengagePlugin.setLocation(new MoEGeoLocation(23.1,
                    //    21.2)); // Pass coordinates with MoEGeoLocation instance
                    _moengagePlugin.setBirthDate(
                        "2000-12-02T08:26:21.170Z"); // date format - ` yyyy-MM-dd'T'HH:mm:ss.fff'Z'`
                  },
                  child: Text("Track attributes"),
                ),
                ElevatedButton(
                  onPressed: () {
                    var properties = MoEProperties();
                    properties
                        .addAttribute("test_string", "Apple")
                        .addAttribute("test_int", 789)
                        .addAttribute("test_bool", false)
                        .addAttribute("attr_double", 12.32)
                    //.addAttribute(
                    //    "attr_location", new MoEGeoLocation(12.1, 77.18))
                        .addAttribute("attr_array", [
                      "item1",
                      "item2",
                      "item3"
                    ]).addISODateTime("attr_date", "2021-08-18T09:57:21.170Z");

                    _moengagePlugin.trackEvent(
                        'Flutter_test_Event', properties);
                  },
                  child: Text("Track Events"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _moengagePlugin.showInApp();
                  },
                  child: Text("Show InApp"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _moengagePlugin.getSelfHandledInApp();
                  },
                  child: Text("Show Self Handled InApp"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    //int count = await _moEngageInbox.getUnClickedCount();
                    //print("Unclicked Message Count " + count.toString());
                  },
                  child: Text("Get Unclicked Message Count"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // InboxData data = await _moEngageInbox.fetchAllMessages();
                    // print("messages: " + data.toString());
                    // for (final message in data.messages) {
                    //   print(message.toString());
                    // }
                  },
                  child: Text("Fetch All Messages"),
                ),
                ElevatedButton(
                  onPressed: ()  {
                    //_moengagePlugin.optOutPushTracking(false);
                  },
                  child: Text("OPT OUT Push"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

