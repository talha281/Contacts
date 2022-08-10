part of 'contacts_bloc.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object> get props => [];
}

class ContactsInitial extends ContactsState {}

class ContactsLoaded extends ContactsState {
  final List<ContactModel> contacts;
  ContactsLoaded({
    required this.contacts,
  });
}
