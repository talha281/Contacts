import 'dart:convert';

enum Label { home, work, other }

class ContactDetails {
  final String value;
  final Label label;

  ContactDetails(
    this.value,
    this.label,
  );

  ContactDetails copyWith({
    String? value,
    Label? label,
  }) {
    return ContactDetails(
      value ?? this.value,
      label ?? this.label,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'label': Label.values.indexOf(label),
    };
  }

  factory ContactDetails.fromMap(Map<String, dynamic> map) {
    return ContactDetails(
      map['value'] ?? '',
      Label.values[map['label']],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactDetails.fromJson(String source) =>
      ContactDetails.fromMap(json.decode(source));

  @override
  String toString() => 'ContactDetails(value: $value, label: $label)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactDetails &&
        other.value == value &&
        other.label == label;
  }

  @override
  int get hashCode => value.hashCode ^ label.hashCode;
}
