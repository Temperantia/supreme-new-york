import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:provider_for_redux/provider_for_redux.dart';
import 'package:supreme/colors.dart';
import 'package:supreme/store/app_state.dart';
import 'package:supreme/view/main_view.dart';

class LoginView extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isPasswordInvisible = true;

  @override
  Widget build(BuildContext context) {
    return ReduxConsumer<AppState>(
      builder: (context, store, state, dispatch, child) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                Image.asset('assets/image 5.png'),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.email_outlined, color: grey)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline, color: grey),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordInvisible = !isPasswordInvisible;
                                  });
                                },
                                icon: Icon(Icons.remove_red_eye),
                                color: grey)),
                        obscureText: isPasswordInvisible,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Row(children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  dispatch(NavigateAction<
                                          AppState>.pushNamedAndRemoveAll(
                                      MainView.id));
                                },
                                child: Text('Sign In'))),
                      ]),
                    ),
                    TextButton(
                        onPressed: () {}, child: Text('Forgot your password?'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
