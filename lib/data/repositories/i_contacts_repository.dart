import '../models/contact_model.dart';

abstract class IContactRepository {
  Future<void> addContact(ContactModel contactModel);
  Future<void> removeContact(ContactModel contactModel);
  Future<void> updateContact(ContactModel contactModel);
  Future<List<ContactModel>> getAll();
}
