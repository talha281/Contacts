import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/models/contact_model.dart';
import 'data/repositories/contacts_repository.dart';
import 'data/repositories/i_contacts_repository.dart';
import 'feature/home/bloc/contacts_bloc.dart';

GetIt getIt = GetIt.instance;
Future<void> inject() async {
  //External
  FirebaseApp app = await Firebase.initializeApp();
  getIt.registerFactory<FirebaseApp>(() => app);
  var pref = await SharedPreferences.getInstance();
  var firebaseStorage = FirebaseFirestore.instance;
  getIt.registerLazySingleton(() => pref);
  getIt.registerLazySingleton(() => firebaseStorage);

  //Helpers/Services
 

  //Bloc
  getIt.registerFactory<ContactsBloc>(() => ContactsBloc(getIt()));

  // Repos
  getIt.registerFactory<IContactRepository>(
      () => ContactsRepository(getIt()));
}
