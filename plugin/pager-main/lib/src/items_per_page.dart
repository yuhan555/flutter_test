import 'package:flutter/material.dart';

class ItemsPerPage extends StatefulWidget {
  const ItemsPerPage({
    Key? key,
    required this.itemsPerPage,
    required this.onChanged,
    this.itemsPerPageText,
    this.itemsPerPageTextStyle,
    this.dropDownMenuItemTextStyle,
  }) : super(key: key);
  final List<int> itemsPerPage;
  final Function(int) onChanged;
  final String? itemsPerPageText;
  final TextStyle? itemsPerPageTextStyle, dropDownMenuItemTextStyle;

  @override
  State<ItemsPerPage> createState() => _ItemsPerPageState();
}

class _ItemsPerPageState extends State<ItemsPerPage> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.itemsPerPage.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.itemsPerPageText ?? "Items per page: ",
          style: widget.itemsPerPageTextStyle ??
              const TextStyle(
                color: Colors.black87,
              ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 60,
          height: 35,
          child: DropdownButtonFormField(
            value: _currentValue,
            focusColor: Colors.transparent,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
            ),
            items: widget.itemsPerPage.map((value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(
                  value.toString(),
                  style: widget.dropDownMenuItemTextStyle ??
                      const TextStyle(
                        fontSize: 14,
                      ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _currentValue = value as int;
                widget.onChanged(value);
              });
            },
          ),
        )
      ],
    );
  }
}
