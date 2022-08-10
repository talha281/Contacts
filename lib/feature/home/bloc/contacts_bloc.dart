import 'package:contacts_app/data/models/contact_model.dart';
import 'package:contacts_app/data/repositories/i_contacts_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final IContactRepository _repository;
  ContactModel? selectedContact;
  List<ContactModel>? modelList;
  ContactsBloc(
    this._repository,
  ) : super(ContactsInitial()) {
    on<GetAlContacts>((event, emit) async {
      emit(ContactsInitial());
      List<ContactModel> contactList = await _repository.getAll();
      modelList = contactList;
      print("contact- $contactList");
      emit(ContactsLoaded(contacts: contactList));
    });

    on<AddContact>((event, emit) async {
      emit(ContactsInitial());
      _repository.addContact(event.contactModel);
      List<ContactModel> contactList = await _repository.getAll();
      emit(ContactsLoaded(contacts: contactList));
    });

    on<UpdateContact>((event, emit) async {
      emit(ContactsInitial());
      _repository.updateContact(event.contactModel);
      //selectedContact = event.contactModel;
      List<ContactModel> contactList = await _repository.getAll();
      emit(ContactsLoaded(contacts: contactList));
    });

    on<DeleteContact>((event, emit) async {
      emit(ContactsInitial());
      await _repository.removeContact(event.contactModel);
      List<ContactModel> contactList = await _repository.getAll();
      emit(ContactsLoaded(contacts: contactList));
    });

    on<SearchContact>((event, emit) async {
      emit(ContactsInitial());
      List<ContactModel> searchList = event.contactList!
          .where((element) => (element.firstName + element.lastName)
              .toLowerCase()
              .contains(event.text!.toLowerCase()))
          .toList();
      emit(ContactsLoaded(contacts: searchList));
    });
  }
}
