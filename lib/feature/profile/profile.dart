import 'dart:math';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import '../../data/models/contact_model.dart';
import '../add-contacts/form.dart';
import '../home/bloc/contacts_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Color get _random {
    return Colors.primaries.elementAt(Random().nextInt(14)).shade700;
  }

  @override
  void initState() {
    super.initState();
    _getContact();
  }

  late ContactModel contactModel;
  void _getContact() {
    contactModel = BlocProvider.of<ContactsBloc>(context).selectedContact!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ContactForm(),
                ));
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).textTheme.bodyText1!.color!,
              )),
          IconButton(
              onPressed: () {
                BlocProvider.of<ContactsBloc>(context)
                    .add(DeleteContact(contactModel: contactModel));

                BlocProvider.of<ContactsBloc>(context).add(GetAlContacts());
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.delete_outline,
                color: Theme.of(context).textTheme.bodyText1!.color!,
              )),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //2Sl

              Container(
                child: CircleAvatar(
                    radius: 70,
                    backgroundColor: _random,
                    child: Center(
                        child: Text(
                      contactModel.firstName.substring(0, 1),
                      style: TextStyle(fontSize: 80),
                    ))),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  contactModel.firstName + " " + contactModel.lastName,
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35,
                      color: Theme.of(context).textTheme.bodyText1!.color!),
                ),
              ),

              // CircleAvatar(
              //     backgroundColor: _random,
              //     child: Center(
              //         child: Text("A"
              //             // e.firstName.substring(0, 1)
              //             ))),

              InkWell(
                onTap: () {
                  FlutterPhoneDirectCaller.callNumber(
                      contactModel.phoneNumbers[0].value);
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          height: 10,
                        ),
                      ),
                      Icon(
                        Icons.phone_outlined,
                        color: Theme.of(context).primaryColor,
                        size: 45,
                      ),
                      Text(
                        "Call",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          height: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 12, left: 8),
                      child: Text(
                        "Contact Details",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: contactModel.phoneNumbers.length,
                      itemBuilder: (BuildContext context, int i) {
                        return ListTile(
                          leading: Icon(
                            Icons.phone_outlined,
                            size: 22,
                          ),
                          title: Text(contactModel.phoneNumbers[i].value),
                          subtitle: Text(contactModel.phoneNumbers[i].label
                              .toString()
                              .substring(6)),
                        );
                      },
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: contactModel.emails.length,
                      itemBuilder: (BuildContext context, int i) {
                        return ListTile(
                          leading: Icon(
                            Icons.email_outlined,
                            size: 22,
                          ),
                          title: Text(contactModel.emails[i].value),
                          subtitle: Text(contactModel.emails[i].label
                              .toString()
                              .substring(6)),
                        );
                      },
                    ),
                  ],
                ),
              )
              //3
            ],
          ),
        ),
      ),
    );
  }
}
