import 'package:flutter/material.dart';
import 'package:off_top_mobile/accountCreation.dart';

class UserInput {
  UserInput(this.context);
  BuildContext context;
  final SignUp signUp = SignUp(email: null);
  String check(String value, String hintText) {
    if (value.isEmpty) {
      return hintText;
    }
    return null;
  }

  Container textForm(String hintText, String requiredText,
      TextEditingController userValue, bool keyBoardtype, bool finalField) {
    return Container(
        width: 280.0,
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
            controller: userValue,
            autocorrect: true,
            keyboardType: keyBoardtype == false
                ? TextInputType.text
                : TextInputType.number,
            textCapitalization: finalField == false
                ? TextCapitalization.sentences
                : TextCapitalization.none,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(hintText: hintText),
            validator: (String value) {
              return check(value, hintText);
            },
            onFieldSubmitted: finalField == false
                ? (_) => FocusScope.of(context).nextFocus()
                : (_) => FocusScope.of(context).unfocus()));
  }
}
