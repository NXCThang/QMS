import 'package:flutter/material.dart';
import 'package:qms_app/common/color.dart';

class CustomButtonRow extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CustomButtonRow({required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(6)),
            padding: EdgeInsets.all(6),
            child: InkWell(
              onTap: onEdit,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          SizedBox(
            width: 3,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(6)),
            padding: EdgeInsets.all(6),
            child: InkWell(
              onTap: onDelete,
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
