import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/models/contact_model.dart';
import '../add-contacts/form.dart';
import '../profile/profile.dart';
import 'bloc/contacts_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<ContactModel> modelList = [];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Container(
          padding: EdgeInsets.only(top: 5, left: 10, right: 10),
          height: 45,
          child: TextField(
            onChanged: (value) {
              if (value.isNotEmpty) {
                BlocProvider.of<ContactsBloc>(context)
                    .add(SearchContact(text: value, contactList: modelList));
              } else {
                BlocProvider.of<ContactsBloc>(context).add(GetAlContacts());
              }
            },
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.3),
                      width: 0),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 0),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "    Search..",
                fillColor: Theme.of(context).primaryColor.withOpacity(0.2)),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Padding(
              padding: EdgeInsets.only(left: 30),
              child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ContactForm(),
                    ));
                  },
                  title: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.userPlus,
                        color: Colors.blue.shade900,
                      ),
                      SizedBox(
                        width: 23,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          "Create new contact",
                          style: TextStyle(
                              color: Colors.blue.shade900, fontSize: 20),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          SizedBox(height: 8),
          BlocBuilder<ContactsBloc, ContactsState>(
            builder: (context, state) {
              if (state is ContactsLoaded) {
                if (state.contacts.length > 1) {
                  for (var element in state.contacts) {
                    modelList.add(element);
                  }
                }
                if (state.contacts.length < 1) {
                  return Center(
                    child: Text(
                      "No Contacts Found",
                      style:
                          TextStyle(color: Colors.blue.shade900, fontSize: 25),
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                      children: state.contacts
                          .map(
                            (e) => Container(
                              padding: EdgeInsets.only(left: 30),
                              child: ListTile(
                                onTap: () {
                                  _selectAndNav(e);
                                },
                                leading: CircleAvatar(
                                    backgroundColor: _random,
                                    child: Center(
                                        child:
                                            Text(e.firstName.substring(0, 1)))),
                                title: Text(
                                  "${e.firstName} ${e.lastName}",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          )
                          .toList()),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Icon(Icons.dialpad),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        DialPad(
                            enableDtmf: false,
                            //outputMask: "(000) 000-0000",
                            backspaceButtonIconColor: Colors.red,
                            buttonTextColor: Colors.black,
                            dialOutputTextColor: Colors.black,
                            buttonColor: Colors.grey,
                            keyPressed: (value) {
                              //print('$value was pressed');
                            },
                            makeCall: (number) {
                              FlutterPhoneDirectCaller.callNumber(number);
                            }),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  Color get _random {
    return Colors.primaries.elementAt(Random().nextInt(14)).shade700;
  }

  void _selectAndNav(ContactModel contact) async {
    BlocProvider.of<ContactsBloc>(context).selectedContact = contact;
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Profile(),
    ));
    BlocProvider.of<ContactsBloc>(context).selectedContact = null;
  }
}
