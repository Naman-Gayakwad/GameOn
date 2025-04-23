import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextformfieldtwo extends StatefulWidget {
  final String hintText;
  bool isObscured;
  bool showPasswordIcon;
  final Icon icon;
  final TextEditingController controller;
  final int? maxlength;
  bool? isSpecialCharacter;

  CustomTextformfieldtwo({
    super.key,
    required this.hintText,
    this.isObscured = false,
    this.showPasswordIcon = true,
    required this.controller,
    required this.icon,
    this.maxlength,
    this.isSpecialCharacter,
  });

  @override
  State<CustomTextformfieldtwo> createState() => _CustomTextformfieldtwoState();
}

class _CustomTextformfieldtwoState extends State<CustomTextformfieldtwo> {
  String? _validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.86,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.28),
            offset: const Offset(
              5.0,
              5.0,
            ),
            blurRadius: 6.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.05,
          ),
          child: TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(widget.maxlength),
              if (widget.isSpecialCharacter == true)
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
            ],
            controller: widget.controller,
            obscureText: widget.isObscured,
            validator: _validateText,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Icon(
                  widget.icon.icon,
                  size: MediaQuery.of(context).size.height * 0.04,
                  color:  Colors.white,
                ),
              ),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                color: Colors.white70,
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: widget.showPasswordIcon
                  ? Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: IconButton(
                        iconSize: MediaQuery.of(context).size.height * 0.03,
                        icon: widget.isObscured
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            widget.isObscured = !widget.isObscured;
                          });
                        },
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
