// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextField extends StatefulWidget {
  final String fieldName;
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final IconData icon;
  final double bottomMargin;
  final bool isPasswordField;
  final FormFieldValidator<String?> validator;
  final String? initialValue;
  final bool numKeyboardType;

  const CustomTextField({
    super.key,
    required this.fieldName,
    required this.title,
    required this.hintText,
    this.controller,
    required this.icon,
    this.bottomMargin = 18,
    this.isPasswordField = false,
    required this.validator,
    this.initialValue,
    this.numKeyboardType = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;
  bool numberKeyboard = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.bottomMargin),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          FormBuilderTextField(
            controller: widget.controller,
            name: widget.fieldName, 
            obscureText: widget.isPasswordField ? obscureText : false,
            validator: widget.validator,
            initialValue: widget.initialValue,
            keyboardType: widget.numKeyboardType
                ? TextInputType.number
                : TextInputType.text,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              prefixIcon: Icon(
                widget.icon,
                color: Colors.grey,
              ),
              suffixIcon: widget.isPasswordField
                  ? Container(
                      padding: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : null,
              hintText: widget.hintText,
              hintStyle: const TextStyle(fontStyle: FontStyle.italic),
              fillColor: Colors.grey.shade200,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
