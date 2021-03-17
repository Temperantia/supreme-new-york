import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:provider_for_redux/provider_for_redux.dart';
import 'package:supreme/colors.dart';
import 'package:supreme/store/app_state.dart';
import 'package:supreme/store/proxies_save_action.dart';
import 'package:supreme/store/proxy_switch_action.dart';
import 'package:supreme/view/login_view.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab(this.state);

  final AppState state;

  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  final TextEditingController proxiesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    proxiesController.text = widget.state.proxies.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return ReduxConsumer<AppState>(
      builder: (context, store, state, dispatch, child) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Row(
                children: [
                  Text(
                    'Proxies',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  Switch(
                      value: state.proxyEnabled,
                      onChanged: (value) {
                        dispatch(ProxySwitchAction());
                      }),
                ],
              )),
              GestureDetector(
                  onTap: () {
                    dispatch(NavigateAction<AppState>.pushNamed(LoginView.id));
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: red)),
                      child: Text('Log Out', style: TextStyle(color: red)))),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                TextField(
                  controller: proxiesController,
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: ElevatedButton(
                              onPressed: () {
                                dispatch(
                                    ProxiesSaveAction(proxiesController.text));
                              },
                              child: Text('Save')),
                        )),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: ElevatedButton(
                              onPressed: () {
                                proxiesController.clear();
                              },
                              child: Text('Clear')),
                        )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
