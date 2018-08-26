import 'package:flutter/material.dart';
import 'package:outfitter/translations.dart';
import 'package:outfitter/utils/textfield_formatter.dart';
import 'package:outfitter/utils/utils.dart';

class ItemBrandForm extends StatefulWidget {
  final _state = _ItemNameFormState();
  Function(String) _onTextChanged;

  ItemBrandForm({@required Function(String) onTextChanged}) {
    _onTextChanged = onTextChanged;
  }

  @override
  State<StatefulWidget> createState() => _state;

  bool validate() {
    return _state._formKey.currentState.validate();
  }
}

class _ItemNameFormState extends State<ItemBrandForm> {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        widget._onTextChanged(_textEditingController.text);
      },
      child: TextFormField(
        style: TextStyleFactory.body1(color: ColorConfig.FONT_PRIMARY),
        inputFormatters: [CapSentenceTextFormatter()],
        controller: _textEditingController,
        decoration: InputDecoration(
            hintText: Translations.forKey('hint_brand_input', context),
            hintStyle: TextStyleFactory.body1(color: ColorConfig.FONT_HINT)),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
