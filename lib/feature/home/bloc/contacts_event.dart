part of 'contacts_bloc.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();

  @override
  List<Object> get props => [];
}

class AddContact extends ContactsEvent {
  final ContactModel contactModel;
  AddContact({
    required this.contactModel,
  });
}

class UpdateContact extends ContactsEvent {
  final ContactModel contactModel;
  UpdateContact({
    required this.contactModel,
  });
}

class DeleteContact extends ContactsEvent {
  final ContactModel contactModel;
  DeleteContact({
    required this.contactModel,
  });
}

class GetAlContacts extends ContactsEvent {}

class SearchContact extends ContactsEvent {
  final String? text;
  final List<ContactModel>? contactList;

  SearchContact({this.text, this.contactList});
}
