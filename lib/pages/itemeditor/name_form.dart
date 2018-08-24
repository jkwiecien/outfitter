import 'package:flutter/material.dart';
import 'package:outfitter/translations.dart';
import 'package:outfitter/utils.dart';

class ItemNameForm extends StatefulWidget {
  final _state = _ItemNameFormState();

  @override
  State<StatefulWidget> createState() => _state;

  bool validate() {
    return _state._formKey.currentState.validate();
  }
}

class _ItemNameFormState extends State<ItemNameForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        decoration: InputDecoration(
            hintText: Translations.forKey('hint_name_input', context),
            hintStyle: TextStyleFactory.h5(color: ColorConfig.FONT_HINT)),
        validator: (value) {
          if (value.isEmpty) {
            return Translations.forKey('error_message_field_required', context);
          }
          if (value.length <= 2) {
            return Translations.forKey(
                'error_message_item_name_too_short', context);
          }
        },
      ),
    );
  }
}
