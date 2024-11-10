import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TableCustom extends StatelessWidget {
  TableCustom({
    super.key,
    required this.title,
    this.color = QMSColor.orangetableheader,
  });
  final Map<Widget, int> title;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        border: TableBorder.all(color: Colors.black.withOpacity(0.1)),
        columnWidths: <int, TableColumnWidth>{
          for (int i = 0; i < title.length; i++)
            i: FlexColumnWidth(title.values.elementAt(i).toDouble()),
        },
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: color!,
            ),
            children: [
              for (var key in title.keys) TableCell(child: key),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemTitleWidget extends StatelessWidget {
  const ItemTitleWidget({
    super.key,
    required this.title,
    this.asset,
  });
  final String title;
  final String? asset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (asset != null)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SvgPicture.asset(
                  asset!,
                  width: 10,
                  height: 10,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
