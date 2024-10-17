import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/icon_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TitleTable extends StatelessWidget {
  const TitleTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _ItemTitleTable(flex: 1, title: ''),
            _ItemTitleTable(
                flex: 8,
                title: appLocalizations?.errorGroupCode ?? '',
                assetname: IconPath.filter),
            _ItemTitleTable(
                title: appLocalizations?.errorGroup ?? '',
                assetname: IconPath.filter,
                flex: 13),
            _ItemTitleTable(
                title: appLocalizations?.description ?? '',
                assetname: IconPath.filter,
                flex: 9),
            _ItemTitleTable(
                title: appLocalizations?.creator ?? '',
                assetname: IconPath.filter,
                flex: 6),
            _ItemTitleTable(
                title: appLocalizations?.creationTime ?? '',
                assetname: IconPath.filter,
                flex: 6),
            _ItemTitleTable(
                title: appLocalizations?.status ?? '',
                assetname: IconPath.filter,
                flex: 5),
          ],
        ),
      ),
    );
  }
}

class _ItemTitleTable extends StatelessWidget {
  _ItemTitleTable({
    super.key,
    required this.title,
    required this.flex,
    this.assetname,
  });

  final int flex;
  final String title;
  String? assetname;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          color: QMSColor.orangetableheader,
          border: Border(
            right: BorderSide(
              color: Colors.black.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
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
              if (assetname != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SvgPicture.asset(
                    assetname!,
                    width: 10,
                    height: 10,
                    fit: BoxFit.scaleDown,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ItemTitleTable(flex: 1, title: ''),
          _ItemTitleSearch(flex: 8, title: ''),
          _ItemTitleSearch(flex: 13, title: ''),
          _ItemTitleSearch(flex: 9, title: ''),
          _ItemTitleSearch(flex: 6, title: ''),
          _ItemTitleSearch(flex: 6, title: ''),
          _ItemTitleSearch(flex: 5, title: ''),
        ],
      ),
    );
  }
}

class _ItemTitleSearch extends StatelessWidget {
  _ItemTitleSearch({
    super.key,
    required this.title,
    required this.flex,
  });

  final int flex;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          color: QMSColor.orangetableheader,
          border: Border(
            right: BorderSide(
              color: Colors.black.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Image.asset(
                  IconPath.search,
                  width: 10,
                  height: 10,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Flexible(
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
            ],
          ),
        ),
      ),
    );
  }
}
