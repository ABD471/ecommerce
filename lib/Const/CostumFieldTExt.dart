import 'package:flutter/material.dart';

class Costumfiledtext extends StatelessWidget {
  // final double cursorHeight;
  final String hintText;
  final String label;
  final Widget IconData;
  final Widget? hide;
  final bool obscureText;
  final TextEditingController Mycontroller;
  final String? Function(String?) validator;
  const Costumfiledtext({
    super.key,
    required this.hintText,
    required this.Mycontroller,
    required this.validator,
    required this.label,
    required this.IconData,
    required this.obscureText,
    this.hide,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: Mycontroller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 19, 36, 180))),
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 19, 36, 180))),

        label: Text(label),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        suffixIcon: IconData,
        icon: hide,
        hintText: hintText,
        hintStyle: TextStyle(color: const Color.fromARGB(255, 19, 36, 180)),

        errorStyle: TextStyle(color: const Color.fromARGB(255, 19, 36, 180)),
        //     hint: Text("data"),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(3)),
      ),
    );
  }
}
