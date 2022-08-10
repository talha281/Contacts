import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../inject.dart';

// ignore: must_be_immutable
abstract class BaseModel extends Equatable {
  final SharedPreferences _pref = getIt<SharedPreferences>();
  final String key = "contactId";
  int id;
  DateTime createdOn;
  bool? isDeleted;
  BaseModel({
    required this.id,
    required this.createdOn,
    required this.isDeleted,
  }) {
    id = id == 0 ? generateID() : id;
    createdOn = createdOn == DateTime(1990) ? DateTime.now() : createdOn;
  }

  int getID() {
    int id = _pref.getInt(key) ?? 1; // 1
    _pref.setInt(key, id + 1); // 2
    return id; //1;
  }

  int generateID() {
    int lastID = getID();

    return lastID;
  }

  DateTime current() => DateTime.now();

  String toJson();
  Map<String, dynamic> toMap();
}
