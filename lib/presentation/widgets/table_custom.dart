import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TableCustom extends StatelessWidget {
  const TableCustom({super.key, required this.title});
  final Map<String, int> title;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return SingleChildScrollView(
      child: Table(
        border: TableBorder.all(color: Colors.black.withOpacity(0.1)),
        columnWidths: <int, TableColumnWidth>{
          0: const FlexColumnWidth(1),
          for (int i = 0; i < title.length; i++)
            i + 1: FlexColumnWidth(title.values.elementAt(i).toDouble()),
        },
        children: [
          TableRow(
            decoration: const BoxDecoration(
              color: QMSColor.orangetableheader,
            ),
            children: [
              const TableCell(
                child: ItemTitleWidget(
                  title: '#',
                ),
              ),
              for (var key in title.keys)
                TableCell(
                  child: ItemTitleWidget(
                    title: key,
                    asset: IconPath.filter,
                  ),
                ),
            ],
          ),
          // Hàng chứa các mục tìm kiếm
          // TableRow(
          //   decoration: const BoxDecoration(
          //     color: Colors.white,
          //   ),
          //   children: [
          //     const TableCell(child: Text('')),
          //     for (int i = 1; i < title.length; i++)
          //       const TableCell(
          //           child:
          //               ItemSearch()), // Widget ItemSearch() được sử dụng cho từng cột
          //   ],
          // ),
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
