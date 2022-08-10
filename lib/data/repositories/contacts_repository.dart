import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_app/data/models/contact_model.dart';
import 'package:contacts_app/data/repositories/i_contacts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsRepository extends IContactRepository {
  final FirebaseFirestore _firebaseFirestore;
  ContactsRepository(this._firebaseFirestore);

  @override
  Future<void> addContact(ContactModel contactModel) async {
    CollectionReference contactRef = _firebaseFirestore.collection("contacts");
    contactRef.doc(contactModel.id.toString()).set(contactModel.toMap());
  }

  @override
  Future<void> removeContact(ContactModel contactModel) async {
    CollectionReference contactRef = _firebaseFirestore.collection("contacts");
    await contactRef.doc(contactModel.id.toString()).delete();
  }

  @override
  Future<List<ContactModel>> getAll() async {
    CollectionReference contactRef = _firebaseFirestore.collection("contacts");

    QuerySnapshot querySnapshot = await contactRef.get();
    final List<ContactModel> contactList = querySnapshot.docs
        .map((e) => ContactModel.fromMap(e.data() as Map<String, dynamic>))
        .toList();
    print("list of contacts$contactList");
    return contactList;
  }

  @override
  Future<void> updateContact(ContactModel contactModel) async {
    CollectionReference contactRef = _firebaseFirestore.collection("contacts");
    await contactRef
        .doc(contactModel.id.toString())
        .update(contactModel.toMap());
  }
}
