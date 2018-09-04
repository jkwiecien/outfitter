//import 'package:flutter/material.dart';
//import 'package:outfitter/translations.dart';
//import 'package:outfitter/utils/textfield_formatter.dart';
//import 'package:outfitter/utils/utils.dart';
//
//class ItemNameForm extends StatefulWidget {
//  final _state = _ItemNameFormState();
//  Function(String) _onTextChanged;
//
//  ItemNameForm({@required Function(String) onTextChanged}) {
//    _onTextChanged = onTextChanged;
//  }
//
//  @override
//  State<StatefulWidget> createState() => _state;
//
//  bool validate() {
//    return _state._formKey.currentState.validate();
//  }
//}
//
//class _ItemNameFormState extends State<ItemNameForm> {
//  final _formKey = GlobalKey<FormState>();
//  final _textEditingController = TextEditingController();
//
//  @override
//  Widget build(BuildContext context) {
//    return Form(
//      key: _formKey,
//      onChanged: () {
//        widget._onTextChanged(_textEditingController.text);
//      },
//      child: TextFormField(
//        style: TextStyleFactory.subtitle1(color: ColorConfig.FONT_PRIMARY),
//        inputFormatters: [AllCapsTextFormatter()],
//        controller: _textEditingController,
//        decoration: InputDecoration(
//            hintText: S.of(context)('hint_name_input', context),
//            hintStyle:
//                TextStyleFactory.subtitle1(color: ColorConfig.FONT_HINT)),
//        validator: (value) {
//          if (value.isEmpty) {
//            return S.of(context)('error_message_field_required', context);
//          }
//          if (value.length <= 2) {
//            return S.of(context)(
//                'error_message_item_name_too_short', context);
//          }
//        },
//      ),
//    );
//  }
//
//  @override
//  void dispose() {
//    _textEditingController.dispose();
//    super.dispose();
//  }
//}
