import 'package:accounting_app/widgets/text.dart';
import 'package:flutter/material.dart';

class RTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Color color;
  const RTextField({
    Key? key,
    required this.text,
    required this.controller,
    this.keyboardType,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.indigo,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          RText(
            '$text : ',
            color: Colors.indigo,
            fontSize: 15,
          ),
          Expanded(
            child: TextFormField(
              keyboardType: keyboardType,
              style: TextStyle(
                color: color,
              ),
              controller: controller,
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
