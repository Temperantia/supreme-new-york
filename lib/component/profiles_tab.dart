import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http_proxy/http_proxy.dart';
import 'package:provider_for_redux/provider_for_redux.dart';
import 'package:supreme/colors.dart';
import 'package:supreme/model/profile.dart';
import 'package:supreme/store/app_state.dart';
import 'package:supreme/store/profile_create_action.dart';

class ProfilesTab extends StatefulWidget {
  @override
  _ProfilesTabState createState() => _ProfilesTabState();
}

class _ProfilesTabState extends State<ProfilesTab> {
  AwesomeDialog profileCreationDialog1;
  AwesomeDialog profileCreationDialog2;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expirationDateController =
      TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  Widget createProfileCreation1() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'New Profile',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(hintText: 'First Name'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(hintText: 'Last Name'),
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
                  controller: emailController,
                  decoration: InputDecoration(hintText: 'johndoe@gmail.com'),
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
                  controller: phoneNumberController,
                  decoration: InputDecoration(hintText: 'Phone Number'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: countryController,
                  decoration: InputDecoration(hintText: 'Country'),
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
                  controller: cityController,
                  decoration: InputDecoration(hintText: 'City'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: stateController,
                  decoration: InputDecoration(hintText: 'State'),
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
                  controller: address1Controller,
                  decoration: InputDecoration(hintText: 'Address 1'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: address2Controller,
                  decoration: InputDecoration(hintText: 'Address 2'),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget createProfileCreation2() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: cardNumberController,
                  decoration: InputDecoration(hintText: 'Card #'),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: expirationDateController,
                  decoration: InputDecoration(hintText: 'Exp. Date'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: cvvController,
                  decoration: InputDecoration(hintText: 'CVV'),
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
            profileCreationDialog1 = AwesomeDialog(
              dialogBackgroundColor: black,
              context: context,
              animType: AnimType.SCALE,
              dialogType: DialogType.NO_HEADER,
              body: createProfileCreation1(),
              btnCancel: ElevatedButton(
                onPressed: () {
                  profileCreationDialog1.dissmiss();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(pink)),
                child: Text('Cancel'),
              ),
              btnOk: ElevatedButton(
                onPressed: () {
                  profileCreationDialog1.dissmiss();
                  profileCreationDialog2 = AwesomeDialog(
                    dialogBackgroundColor: black,
                    context: context,
                    animType: AnimType.SCALE,
                    dialogType: DialogType.NO_HEADER,
                    body: createProfileCreation2(),
                    btnCancel: ElevatedButton(
                      onPressed: () {
                        profileCreationDialog2.dissmiss();
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(pink)),
                      child: Text('Cancel'),
                    ),
                    btnOk: ReduxConsumer<AppState>(
                        builder: (context, store, state, dispatch, child) =>
                            ElevatedButton(
                              onPressed: () {
                                dispatch(ProfileCreateAction(Profile(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  phoneNumber: phoneNumberController.text,
                                  country: countryController.text,
                                  city: cityController.text,
                                  state: stateController.text,
                                  address1: address1Controller.text,
                                  address2: address2Controller.text,
                                  cardNumber: cardNumberController.text,
                                  cardExpirationDate:
                                      expirationDateController.text,
                                  cardCvv: cvvController.text,
                                )));
                                profileCreationDialog1.dissmiss();
                                profileCreationDialog2.dissmiss();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(green)),
                              child: Text('Create'),
                            )),
                  )..show();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(green)),
                child: Text('Create'),
              ),
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
    return ReduxConsumer<AppState>(
        builder: (context, store, state, dispatch, child) => Stack(
              children: [
                ListView.builder(
                    itemCount: state.profiles.length,
                    itemBuilder: (context, index) {
                      final Profile profile = state.profiles[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        decoration: BoxDecoration(
                            color: purple,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Image.asset(
                                              'assets/Group 123.png'))),
                                  Icon(
                                    Icons.edit_outlined,
                                    color: grey,
                                  ),
                                  Icon(
                                    Icons.delete_outline,
                                    color: grey,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      '●●●●  ●●●●  ●●●●  ' +
                                          profile.cardNumber.substring(12),
                                      style:
                                          Theme.of(context).textTheme.headline5)
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('CARD HOLDER'),
                                  Text('EXPIRES')
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    profile.firstName + ' ' + profile.lastName),
                                Text(profile.cardExpirationDate)
                              ],
                            )
                          ],
                        ),
                      );
                    }),
                createButton(),
              ],
            ));
  }
}
