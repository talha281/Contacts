import 'package:contacts_app/const/keys.dart';
import '../data/models/contact_model.dart';

T? getType<T>(String json) {
  if (T == ContactModel) {
    return ContactModel.fromJson(json) as T;
  }
}

String getKey<T>() {
  String _key = "NOT_FOUND";

  if (T == ContactModel) {}
  return contactKey;
}
