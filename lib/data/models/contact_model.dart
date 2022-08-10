import 'dart:convert';

import 'package:contacts_app/data/models/base_model.dart';
import 'contact_details.dart';

// ignore: must_be_immutable
class ContactModel extends BaseModel {
  final String firstName;
  final String lastName;
  final List<ContactDetails> phoneNumbers;
  final List<ContactDetails> emails;
  ContactModel({
    required int id,
    required DateTime createdOn,
    bool? isDeleted,
    required this.firstName,
    required this.lastName,
    required this.phoneNumbers,
    required this.emails,
  }) : super(
            createdOn: createdOn,
            id: id,
            isDeleted: isDeleted,
            );

  ContactModel copyWith({
    String? firstName,
    String? lastName,
    List<ContactDetails>? phoneNumbers,
    List<ContactDetails>? emails,
  }) {
    return ContactModel(
      id: id,
      createdOn: createdOn,
      isDeleted: isDeleted ?? false,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      emails: emails ?? this.emails,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdOn': createdOn.millisecondsSinceEpoch,
      'isDeleted': isDeleted ?? false,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumbers': phoneNumbers.map((x) => x.toMap()).toList(),
      'emails': emails.map((x) => x.toMap()).toList(),
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id']?.toInt() ?? 0,
      createdOn: DateTime.fromMillisecondsSinceEpoch(map['createdOn']),
      isDeleted: map['isDeleted'],
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      phoneNumbers: List<ContactDetails>.from(
          map['phoneNumbers']?.map((x) => ContactDetails.fromMap(x))),
      emails: List<ContactDetails>.from(
          map['emails']?.map((x) => ContactDetails.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContactModel(firstName: $firstName, lastName: $lastName, phoneNumbers: $phoneNumbers, emails: $emails)';
  }

  @override
  List<Object> get props => [firstName, lastName, phoneNumbers, emails];
}
