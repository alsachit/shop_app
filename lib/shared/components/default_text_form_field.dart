import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {

  final TextEditingController controller;
  final FormFieldValidator validator;
  final TextInputType type;
  Function(String?)? onSubmit;
  Function(String?)? onChange;
  VoidCallback? onTap;
  final Widget label;
  IconData? suffixIcon;
  VoidCallback? suffixPressed;
  final IconData prefixIcon;
  bool isPassword;



   DefaultTextFormField({
    required this.controller,
    required this.validator,
    required this.type,
    this.onSubmit,
    this.onChange,
    this.onTap,
    required this.label,
    this.suffixIcon,
    required this.prefixIcon,
     this.suffixPressed,
    this.isPassword = false,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      onTap: onTap,
      onChanged: onChange,
      validator: validator,
      onFieldSubmitted: onSubmit,
      keyboardType: type,
      decoration: InputDecoration(
        label: label,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null ? IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon)) : null,
        border: const OutlineInputBorder()
      ),
    );
  }

}