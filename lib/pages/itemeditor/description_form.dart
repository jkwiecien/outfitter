import 'package:flutter/material.dart';
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/utils/textfield_formatter.dart';
import 'package:outfitter/utils/utils.dart';

class ItemDescriptionForm extends StatefulWidget {
  final _state;

  ItemDescriptionForm(this._state);

  @override
  State<StatefulWidget> createState() => _state;

  bool validate() {
    return _state._formKey.currentState.validate();
  }
}

class ItemDescriptionFormState extends State<ItemDescriptionForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController;

  String _initialText;
  Function(String) _onTextChanged;

  ItemDescriptionFormState(this._initialText,
      {@required Function(String) onTextChanged}) {
    _onTextChanged = onTextChanged;
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: _initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        _onTextChanged(_textEditingController.text);
      },
      child: TextFormField(
        style: TextStyleFactory.body1(color: ColorConfig.FONT_PRIMARY),
        inputFormatters: [CapSentenceTextFormatter()],
        controller: _textEditingController,
        decoration: InputDecoration(
            hintText: S.of(context).descriptionInputHint,
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
