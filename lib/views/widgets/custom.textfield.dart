import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String validatorText, hintText;
  final void Function(String value) onChange;
  final FormFieldValidator<String> validator;
  final bool isPasswordField;
  final TextInputType inputType;
  final TextEditingController controller;

  CustomTextField(
      {@required this.validatorText,
      @required this.hintText,
      @required this.onChange,
      this.isPasswordField = false,
      this.inputType,
      this.validator,
      this.controller});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPasswordField ? isObscureText : false,
      validator: widget.validator ??
          (val) {
            return val.isEmpty ? widget.validatorText : null;
          },
      controller: widget.controller,
      keyboardType: widget.inputType,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Color(0xffD8D8D8),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Color(0xffD8D8D8),
              width: 2.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xffD8D8D8), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xffD8D8D8), width: 2),
          ),
          suffixIcon: widget.isPasswordField
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                  child: Icon(
                      isObscureText ? Icons.visibility_off : Icons.visibility),
                )
              : SizedBox(),
          hintStyle: TextStyle(color: Colors.black, fontSize: 17)),
      cursorColor: Colors.white,
      onChanged: widget.onChange,
    );
  }
}
