import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:outfitter/generated/i18n.dart';
import 'package:outfitter/utils/utils.dart';

class PriceForm extends StatefulWidget {
  final _state;

  PriceForm(this._state);

  @override
  State<StatefulWidget> createState() => _state;

  bool validate() {
    return _state._formKey.currentState.validate();
  }
}

class PriceFormState extends State<PriceForm> {
  final _formKey = GlobalKey<FormState>();
  MoneyMaskedTextController controller;

  num _initialValue;
  Function(num) _onPriceChanged;

  PriceFormState(this._initialValue, {@required Function(num) onPriceChanged}) {
    _onPriceChanged = onPriceChanged;
  }

  @override
  Widget build(BuildContext context) {
    //FIXME Hardcoded PLN
    controller = MoneyMaskedTextController(
        initialValue: _initialValue, rightSymbol: ' zł');
    return Form(
      key: _formKey,
      onChanged: () {
        _onPriceChanged(controller.numberValue);
      },
      child: TextFormField(
        keyboardType: TextInputType.number,
        style: TextStyleFactory.body1(color: ColorConfig.FONT_PRIMARY),
        controller: controller,
        decoration: InputDecoration(
            hintText: S.of(context).descriptionInputHint,
            hintStyle: TextStyleFactory.body1(color: ColorConfig.FONT_HINT)),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
