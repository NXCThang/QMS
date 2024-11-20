import 'package:flutter/material.dart';

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
          ElevatedButton(
            onPressed: onEdit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 20,
            ),
          ),
          ElevatedButton(
            onPressed: onDelete,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
