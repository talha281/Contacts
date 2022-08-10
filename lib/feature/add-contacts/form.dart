import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/models/contact_details.dart';
import '../../data/models/contact_model.dart';
import '../home/bloc/contacts_bloc.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  @override
  void initState() {
    super.initState();
    _editCheck();
    addPhone();
    addEmail();
  }

  void addPhone() {
    _phoneControllers.add(TextEditingController());
    _phoneLabels.add(Label.home);
    setState(() {});
  }

  void removePhone(int index) {
    _phoneControllers.removeAt(index);
    setState(() {});
  }

  void removeEmail(int index) {
    _emailControllers.removeAt(index);
    setState(() {});
  }

  void addEmail() {
    _emailControllers.add(TextEditingController());
    _emailLabels.add(Label.home);
    setState(() {});
  }

  void _onSave() {
    var s = BlocProvider.of<ContactsBloc>(context).selectedContact;
    List<ContactDetails> phoneNumberList = [];
    List<ContactDetails> emailList = [];
    List<ContactDetails> tempPhoneNumberList = List.generate(
        _phoneControllers.length,
        (index) =>
            ContactDetails(_phoneControllers[index].text, _phoneLabels[index]));

    tempPhoneNumberList.forEach((element) {
      if (element.value.isNotEmpty) {
        phoneNumberList.add(element);
      }
    });

    List<ContactDetails> tempEmailList = List.generate(
        _emailControllers.length,
        (index) =>
            ContactDetails(_emailControllers[index].text, _emailLabels[index]));

    tempEmailList.forEach((element) {
      if (element.value.isNotEmpty) {
        emailList.add(element);
      }
    });

    var contactModel = ContactModel(
        id: isEdit ? s!.id : 0,
        createdOn: isEdit ? s!.createdOn : DateTime(1990),
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phoneNumbers: phoneNumberList,
        emails: tempEmailList);

    BlocProvider.of<ContactsBloc>(context).add(isEdit
        ? UpdateContact(contactModel: contactModel)
        : AddContact(contactModel: contactModel));

    BlocProvider.of<ContactsBloc>(context).add(GetAlContacts());
    _firstNameController.clear();
    _lastNameController.clear();
    _phoneControllers.clear();
    _emailControllers.clear();
    if (isEdit) {
      Navigator.of(context).pop();
    }
    Navigator.of(context).pop();
  }

  _editCheck() {
    var c = BlocProvider.of<ContactsBloc>(context).selectedContact;
    if (BlocProvider.of<ContactsBloc>(context).selectedContact != null) {
      isEdit = true;
      _firstNameController.text = c!.firstName;
      _lastNameController.text = c.lastName;
      _phoneControllers.clear();
      _phoneLabels.clear();
      c.phoneNumbers.forEach((element) {
        _phoneControllers.add(TextEditingController(text: element.value));
        _phoneLabels.add(element.label);
      });
      _emailControllers.clear();
      _emailLabels.clear();
      c.emails.forEach((element) {
        _emailControllers.add(TextEditingController(text: element.value));
        _emailLabels.add(element.label);
      });
      setState(() {});
    }
  }

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  List<TextEditingController> _phoneControllers = [];
  List<TextEditingController> _emailControllers = [];
  List<Label> _phoneLabels = [];
  List<Label> _emailLabels = [];
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Contact" : "Add Contact",
            style: TextStyle(color: Colors.grey)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              color: (_firstNameController.text.isEmpty ||
                      _lastNameController.text.isEmpty ||
                      _phoneControllers.any((element) =>
                          element.text.isEmpty ||
                          _emailControllers
                              .any((element) => element.text.isEmpty)))
                  ? Theme.of(context).primaryColor.withOpacity(0.5)
                  : Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              onPressed: (_firstNameController.text.isEmpty ||
                      _lastNameController.text.isEmpty ||
                      _phoneControllers.any((element) =>
                          element.text.isEmpty ||
                          _emailControllers
                              .any((element) => element.text.isEmpty)))
                  ? () {}
                  : _onSave,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFieldEdited(
                icon: Icons.person_outline,
                controller: _firstNameController,
                label: "First Name",
                typr: TextInputType.text,
              ),
              SizedBox(
                height: 10,
              ),
              TextFieldEdited(
                controller: _lastNameController,
                label: "Last Name",
                typr: TextInputType.text,
              ),
              Column(
                children: _phoneControllers
                    .map((e) => Row(
                          children: [
                            ContactDetailWidget(
                                selected:
                                    _phoneLabels[_phoneControllers.indexOf(e)],
                                icon: (_phoneControllers.indexOf(e) == 0)
                                    ? Icons.phone_outlined
                                    : null,
                                label: "Phone",
                                cancelFunction: () {
                                  if (_phoneControllers.indexOf(e) > 0) {
                                    int index = _phoneControllers.indexOf(e);
                                    removePhone(index);
                                  }
                                },
                                isShowCancel:
                                    (_phoneControllers.indexOf(e) == 0)
                                        ? false
                                        : true,
                                controller: e,
                                typr: TextInputType.phone,
                                onChanged: (v) {
                                  setState(() {
                                    _phoneLabels[_phoneControllers.indexOf(e)] =
                                        v!;
                                  });
                                }),
                          ],
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    addPhone();
                  },
                  child: Text("Add")),
              Column(
                children: _emailControllers
                    .map((e) => ContactDetailWidget(
                        selected: _emailLabels[_emailControllers.indexOf(e)],
                        icon: (_emailControllers.indexOf(e) == 0)
                            ? Icons.email_outlined
                            : null,
                        label: "Email",
                        cancelFunction: () {
                          if (_emailControllers.indexOf(e) > 0) {
                            int index = _emailControllers.indexOf(e);
                            removeEmail(index);
                          }
                        },
                        isShowCancel:
                            (_emailControllers.indexOf(e) == 0) ? false : true,
                        controller: e,
                        typr: TextInputType.emailAddress,
                        onChanged: (v) {
                          setState(() {
                            _emailLabels[_emailControllers.indexOf(e)] = v!;
                          });
                        }))
                    .toList(),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    addEmail();
                  },
                  child: Text("Add")),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldEdited extends StatelessWidget {
  final IconData? icon;
  final String label;
  final TextEditingController controller;
  final TextInputType typr;
  final Function()? cancelFunction;
  final bool isShowCancel;
  const TextFieldEdited({
    Key? key,
    this.icon,
    this.isShowCancel = false,
    this.cancelFunction,
    required this.label,
    required this.controller,
    required this.typr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(icon),
              Container(
                margin: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextField(
                  controller: controller,
                  keyboardType: typr,
                  decoration: InputDecoration(
                      label: Text(label),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              (isShowCancel)
                  ? InkWell(
                      onTap: cancelFunction,
                      child: Icon(
                        Icons.cancel,
                        size: 25,
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class ContactDetailWidget extends StatelessWidget {
  const ContactDetailWidget({
    Key? key,
    required this.label,
    required this.controller,
    required this.typr,
    required this.onChanged,
    this.cancelFunction,
    this.isShowCancel = false,
    this.icon,
    this.selected,
  }) : super(key: key);
  final String label;
  final TextEditingController controller;
  final TextInputType typr;
  final bool? isShowCancel;
  final Function()? cancelFunction;
  final Function(Label?) onChanged;
  final IconData? icon;
  final Label? selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldEdited(
            label: label,
            controller: controller,
            typr: typr,
            cancelFunction: cancelFunction,
            icon: icon,
            isShowCancel: isShowCancel!,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 35),
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<Label>(
                value: selected,
                hint: Text("Select Label"),
                items: Label.values
                    .map((e) => DropdownMenuItem<Label>(
                        value: e, child: Text(e.toString().substring(6))))
                    .toList(),
                onChanged: onChanged),
          )
        ],
      ),
    );
  }
}
