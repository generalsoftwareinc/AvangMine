// To parse this JSON data, do
//
//     final customFields = customFieldsFromJson(jsonString);

import 'dart:convert';

CustomFields customFieldsFromJson(String str) =>
    CustomFields.fromJson(json.decode(str));

String customFieldsToJson(CustomFields data) => json.encode(data.toJson());

class CustomFields {
  final List<CustomField>? customFields;

  CustomFields({this.customFields});

  factory CustomFields.fromJson(Map<String, dynamic> json) => CustomFields(
      customFields: json["custom_fields"] == null
          ? []
          : List<CustomField>.from(
              json["custom_fields"]!.map((x) => CustomField.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "custom_fields": customFields == null
            ? []
            : List<dynamic>.from(customFields!.map((x) => x.toJson())),
      };
}

class CustomField {
  final int? id;
  final String? name;
  final String? customizedType;
  final String? fieldFormat;
  final String? regexp;
  final String? minLength;
  final String? maxLength;
  final bool? isRequired;
  final bool? isFilter;
  final bool? searchable;
  final bool? multiple;
  final String? defaultValue;
  final bool? visible;
  final List<PossibleValue>? possibleValues;
  final dynamic value;

  CustomField({
    this.id,
    this.name,
    this.customizedType,
    this.fieldFormat,
    this.regexp,
    this.minLength,
    this.maxLength,
    this.isRequired,
    this.isFilter,
    this.searchable,
    this.multiple,
    this.defaultValue,
    this.visible,
    this.possibleValues,
    this.value,
  });

  factory CustomField.fromJson(Map<String, dynamic> json) => CustomField(
        id: json["id"],
        name: json["name"],
        customizedType: json["customized_type"],
        fieldFormat: json["field_format"],
        regexp: json["regexp"],
        minLength: json["min_length"],
        maxLength: json["max_length"],
        isRequired: json["is_required"],
        isFilter: json["is_filter"],
        searchable: json["searchable"],
        multiple: json["multiple"],
        defaultValue: json["default_value"],
        visible: json["visible"],
        possibleValues: json["possible_values"] == null
            ? []
            : List<PossibleValue>.from(
                json["possible_values"]!.map((x) => PossibleValue.fromJson(x))),
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "customized_type": customizedType,
        "field_format": fieldFormat,
        "regexp": regexp,
        "min_length": minLength,
        "max_length": maxLength,
        "is_required": isRequired,
        "is_filter": isFilter,
        "searchable": searchable,
        "multiple": multiple,
        "default_value": defaultValue,
        "visible": visible,
        "possible_values": possibleValues == null
            ? []
            : List<dynamic>.from(possibleValues!.map((x) => x.toJson())),
        "value": value,
      };
}

class PossibleValue {
  final String? value;

  PossibleValue({
    this.value,
  });

  factory PossibleValue.fromJson(Map<String, dynamic> json) => PossibleValue(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}
