import 'package:alura_bytebank/components/contact_item.dart';
import 'package:alura_bytebank/components/input_field.dart';
import 'package:alura_bytebank/models/contact.dart';
import 'package:flutter/material.dart';

import 'package:alura_bytebank/components/feature_item.dart';

bool featureItemMatcher(Widget widget, String text, IconData icon) {
  if (widget is FeatureItem) {
    return widget.text == text && widget.icon == icon;
  }
  return false;
}

bool textFieldMatcher(Widget widget, String labelText) {
  if (widget is TextField) {
    return widget.decoration!.labelText == labelText;
  }
  return false;
}

bool contactItemMatcher(Widget widget, Contact contact) {
  if (widget is ContactItem) {
    return widget.contact == contact;
  }
  return false;
}

bool inputFieldMatcher(Widget widget, String labelText) {
  if (widget is InputField) {
    return widget.label == labelText;
  }
  return false;
}
