import 'package:flutter/material.dart';
import 'package:provider_for_redux/provider_for_redux.dart';
import 'package:supreme/colors.dart';
import 'package:supreme/component/profiles_tab.dart';
import 'package:supreme/component/settings_tab.dart';
import 'package:supreme/component/tasks_tab.dart';
import 'package:supreme/store/app_state.dart';

class MainView extends StatefulWidget {
  static const String id = 'main';

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;
  List data = [
    {'name': 'Tasks', 'icon': Icons.show_chart, 'tab': (_) => TasksTab()},
    {
      'name': 'Profiles',
      'icon': Icons.contact_page,
      'tab': (_) => ProfilesTab()
    },
    {
      'name': 'Settings',
      'icon': Icons.settings,
      'tab': (state) => SettingsTab(state)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(data[currentIndex]['icon'], color: primary),
        title: Text(data[currentIndex]['name']),
        backgroundColor: greyDark,
      ),
      backgroundColor: greyDark,
      body: Padding(
          padding: EdgeInsets.all(20.0),
          child: ReduxConsumer<AppState>(
              builder: (context, store, state, dispatch, child) =>
                  data[currentIndex]['tab'](state))),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: greyDark,
        currentIndex: currentIndex,
        onTap: (index) => {
          setState(() {
            currentIndex = index;
          })
        },
        unselectedIconTheme: IconThemeData(color: whiteTransparent30),
        unselectedItemColor: whiteTransparent30,
        items: [
          for (int i = 0; i < 3; i++)
            BottomNavigationBarItem(
                icon: Icon(data[i]['icon']), label: data[i]['name']),
        ],
      ),
    );
  }
}
