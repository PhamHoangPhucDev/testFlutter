import 'package:flutter/material.dart';

import '../../configs/appStyle.Config.dart';

class TextFieldComponent extends StatefulWidget {
  TextFieldComponent({super.key,this.enabled = true,this.label = "Giá trị",this.hintText = "Nhập giá trị",this.obscured,this.listRightIcon,this.keyboardType,this.textController,this.line,this.onChange});
  final String? label;
  final String? hintText;
  final List<Widget>? listRightIcon;
  final bool? obscured;
  final TextInputType? keyboardType;
  final TextEditingController? textController;
  final bool? enabled;
  final int? line;
  final Function(String)? onChange;
  
  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColor.aqua)
        )
      ),
      onChanged: widget.onChange??(String text){},
    );
  }
}