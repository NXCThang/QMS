import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qms_app/common/components/build_pagination_controls.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qms_app/models/pqc_first_result.dart';
import 'package:qms_app/presentation/pqc/controllers/pqc_first_result_c.dart';
import 'package:qms_app/presentation/widgets/table_custom.dart';

class ListPqcFirstResult extends StatefulWidget {
  ListPqcFirstResult({super.key, this.list});
  List<PQCFirstResultModel>? list;
  @override
  State<ListPqcFirstResult> createState() => _ListPqcFirstResultState();
}

class _ListPqcFirstResultState extends State<ListPqcFirstResult> {
  late List<PQCFirstResultModel> _items;
  late List<List<TextEditingController>> _controllers;
  final pqcFirstResultController = Get.find<PqcFirstResultController>();

  @override
  void initState() {
    super.initState();
    pqcFirstResultController.evaluateItems.clear();
    _items = List.from(pqcFirstResultController.pqcFirstResultList);

    _controllers = List.generate(
      _items.length,
      (index) => [
        TextEditingController(
          text: '',
        ),
      ],
    );
  }

  @override
  void dispose() {
    for (var controllersList in _controllers) {
      for (var controller in controllersList) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Thông tin kiểm tra kết quả đo lường',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      TableCustom(
        title: {
          ItemTitleWidget(title: 'STT'): 1,
          ItemTitleWidget(title: 'Công đoạn'): 3,
          ItemTitleWidget(title: 'Nội dung'): 3,
          ItemTitleWidget(title: 'Tiêu chuẩn'): 2,
          ItemTitleWidget(title: 'Phương pháp'): 2,
          ItemTitleWidget(title: 'Đánh giá'): 3,
          ItemTitleWidget(title: 'Thao tác'): 2,
        },
      ),
      SizedBox(
        height: 680,
        child: ListView.builder(
          itemCount: pqcFirstResultController
              .paginatedController.paginatedItems.length,
          itemBuilder: (BuildContext context, int index) {
            final item = pqcFirstResultController
                .paginatedController.paginatedItems[index];
            final stt = index +
                1 +
                pqcFirstResultController.paginatedController.currentPage.value *
                    pqcFirstResultController.paginatedController.itemsPerPage;
            return TableCustom(
              color: Colors.white,
              title: {
                ItemBodyWidget(title: stt.toString()): 1,
                ItemBodyWidget(title: item.stageName.toString()): 3,
                ItemBodyWidget(title: item.content.toString()): 3,
                ItemBodyWidget(title: item.standard.toString()): 2,
                ItemBodyWidget(title: item.method.toString()): 2,
                Container(
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black.withOpacity(0.5), width: 1),
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: SizedBox.shrink(),
                      value: _controllers[index][0].text.isEmpty
                          ? null
                          : _controllers[index][0].text,
                      items: ['OK', 'NG']
                          .map((value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _controllers[index][0].text = value ?? '';
                          item.conclusion = (value == 'OK') ? 1 : 0;
                          if (item.conclusion != null &&
                              !pqcFirstResultController.evaluateItems
                                  .contains(item)) {
                            pqcFirstResultController.evaluateItems.add(item);
                          } else {
                            pqcFirstResultController.evaluateItems.remove(item);
                          }
                        });
                      },
                    )): 3,
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 24,
                  ),
                ): 2
              },
            );
          },
        ),
      ),
      const SizedBox(height: 10),
      BuildPaginationControls<PQCFirstResultModel>(
        paginatedController: pqcFirstResultController.paginatedController,
      ),
    ]);
  }

  List<PQCFirstResultModel> getEvaluatedItems() {
    return _items.where((item) => item.conclusion != null).toList();
  }
}
