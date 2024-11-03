import 'package:flutter/material.dart';
import 'package:qms_app/common/icon_path.dart';

class DataTableRow extends StatelessWidget {
  final String errorGroupCode;
  final String errorGroup;
  final String description;
  final String creator;
  final String creationTime;
  final String status;

  const DataTableRow(
      {super.key,
      required this.errorGroupCode,
      required this.errorGroup,
      required this.description,
      required this.creator,
      required this.creationTime,
      required this.status});
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _item_data_table(flex: 1, title: ''),
          _item_data_table(flex: 8, title: errorGroupCode),
          _item_data_table(flex: 13, title: errorGroup),
          _item_data_table(flex: 9, title: description),
          _item_data_table(flex: 6, title: creator),
          _item_data_table(flex: 6, title: creationTime),
          _item_data_table(flex: 5, title: status),
        ],
      ),
    );
  }
}

class _item_data_table extends StatelessWidget {
  const _item_data_table({required this.title, required this.flex});

  final int flex;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(
              color: Colors.black.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                IconPath.search,
                width: 10,
                height: 10,
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
