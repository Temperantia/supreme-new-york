import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http_proxy/http_proxy.dart';
import 'package:provider_for_redux/provider_for_redux.dart';
import 'package:supreme/colors.dart';
import 'package:supreme/model/task.dart';
import 'package:supreme/store/app_state.dart';
import 'package:supreme/store/task_create_action.dart';
import 'package:supreme/tab.dart';
import 'package:flutter_proxy/flutter_proxy.dart';

class ProxiedHttpOverrides extends HttpOverrides {
  String _port;
  String _host;
  ProxiedHttpOverrides(this._host, this._port);

  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..findProxy = (uri) {
        return _host != null ? "PROXY $_host:$_port;" : 'DIRECT';
      };
  }
}

class TasksTab extends StatefulWidget {
  @override
  _TasksTabState createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> with TickerProviderStateMixin {
  bool started = false;
  int currentIndex = 0;
  AwesomeDialog taskCreationDialog;
  String colours;
  String sizes;
  final TextEditingController keywordsController = TextEditingController();
  final TextEditingController delayController = TextEditingController();
  final TextEditingController retryDelayController = TextEditingController();
  List<Widget> views = [
    WebTab(),
    WebTab(),
    WebTab(),
    WebTab(),
  ];
  TabController tabController;
  List<String> proxies;
  bool proxyEnabled;

  @override
  initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() async {
      if (tabController.indexIsChanging) {
        print(currentIndex);
        changeProxy(currentIndex);
      }
    });
  }

  changeProxy(index) async {
    if (!proxyEnabled || !proxies.asMap().containsKey(index)) {
      return;
    }

    String proxy = proxies[index].split('//')[1];

    var env = {};

    if (proxies[index].split('//')[0] == 'http') {
      env['http_proxy'] = proxy;
    } else if (proxies[index].split('//')[0] == 'https') {
      env['https_proxy'] = proxy;
    }

    HttpOverrides.global =
        ProxiedHttpOverrides(proxy.split(':')[0], proxy.split(':')[1]);
  }

  Widget createTaskCreation() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'New Task',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StatefulBuilder(
                    builder: (context, setState) => DropdownButton(
                          dropdownColor: black,
                          hint: Text('Colours'),
                          value: colours,
                          onChanged: (value) {
                            setState(() {
                              colours = value;
                            });
                          },
                          items: [
                            'black',
                            'white',
                            'red',
                            'green',
                            'yellow',
                            'blue',
                            'pink',
                            'gray',
                            'brown',
                            'orange',
                            'purple'
                          ]
                              .map((colour) => DropdownMenuItem(
                                  value: colour, child: Text(colour)))
                              .toList(),
                        )),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StatefulBuilder(
                      builder: (context, setState) => DropdownButton(
                            hint: Text('Sizes'),
                            dropdownColor: black,
                            value: sizes,
                            onChanged: (value) {
                              setState(() {
                                sizes = value;
                              });
                            },
                            items: ['Small', 'Medium', 'Large', 'XLarge']
                                .map((size) => DropdownMenuItem(
                                    value: size, child: Text(size)))
                                .toList(),
                          ))),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: keywordsController,
                  decoration: InputDecoration(hintText: 'Keywords'),
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: delayController,
                  decoration: InputDecoration(hintText: 'Delay'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: retryDelayController,
                  decoration: InputDecoration(hintText: 'Retry Delay'),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget createButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: IconButton(
          onPressed: () {
            taskCreationDialog = AwesomeDialog(
              dialogBackgroundColor: black,
              context: context,
              animType: AnimType.SCALE,
              dialogType: DialogType.NO_HEADER,
              body: createTaskCreation(),
              btnCancel: ElevatedButton(
                onPressed: () {
                  taskCreationDialog.dissmiss();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(pink)),
                child: Text('Cancel'),
              ),
              btnOk: ReduxConsumer<AppState>(
                  builder: (context, store, state, dispatch, child) =>
                      ElevatedButton(
                        onPressed: () {
                          dispatch(TaskCreateAction(Task(
                            color: colours,
                            size: sizes,
                            keywords: keywordsController.text.split(' '),
                            delay: delayController.text,
                            retryDelay: retryDelayController.text,
                          )));
                          taskCreationDialog.dissmiss();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(green)),
                        child: Text('Create'),
                      )),
            )..show();
          },
          color: grey,
          padding: EdgeInsets.all(0.0),
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 50.0,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    var widget;
    if (started) {
      widget = ReduxConsumer<AppState>(
          builder: (context, store, state, dispatch, child) {
        proxies = state.proxies;
        proxyEnabled = state.proxyEnabled;
        return Stack(
          children: [
            Column(
              children: [
                TabBar(controller: tabController, tabs: [
                  for (int index = 0; index < 4; index++)
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                            color: tabController.index == index
                                ? primary
                                : greySecondary,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                tabController.index = index;
                              });
                            },
                            child: Text((index + 1).toString(),
                                style: TextStyle(
                                    color: index == tabController.index
                                        ? Colors.white
                                        : grey,
                                    fontSize: 30.0))),
                      ),
                    )
                ]),
                Expanded(
                    child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: views))
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      started = false;
                    });
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(right: 10.0)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                      backgroundColor: MaterialStateProperty.all(grey)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_left, color: Colors.white, size: 50.0),
                      Text(
                        'Go back',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      )
                    ],
                  )),
            ),
          ],
        );
      });
    } else {
      widget = ReduxConsumer<AppState>(
          builder: (context, store, state, dispatch, child) {
        proxies = state.proxies;
        proxyEnabled = state.proxyEnabled;
        return Stack(children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final Task task = state.tasks[index];
                      return Container(
                        margin: EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: greySecondary,
                            border: Border.all(color: grey),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Text(
                                    task.color + ' > Size ' + task.size,
                                    style: TextStyle(color: primary),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      task.keywords
                                          .map((keyword) => '+' + keyword)
                                          .toList()
                                          .join(', '),
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Visa 4444',
                                    style: TextStyle(color: grey),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Image.asset('assets/Ellipse 1.png'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      'Idle',
                                      style: TextStyle(color: pink),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text((index + 1).toString(),
                                            style: TextStyle(color: grey))),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            createButton(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.0),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      started = true;
                      changeProxy(0);
                      tabController.animateTo(0);
                    });
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(right: 10.0)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                      backgroundColor: MaterialStateProperty.all(green)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_right, color: Colors.white, size: 50.0),
                      Text(
                        'Start All Tasks',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      )
                    ],
                  )),
            )
          ])
        ]);
      });
    }
    return widget;
  }
}
