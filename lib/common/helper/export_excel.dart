import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:qms_app/data/local/login_session.dart';
import 'package:qms_app/presentation/oqc/controllers/sell_order_c.dart';
import 'package:qms_app/presentation/report/model/report_ng_ok.dart';
import 'package:qms_app/common/extensions/date_time_format.dart';
import 'package:qms_app/presentation/report/model/so_report.dart';
import 'package:qms_app/presentation/report/model/wo_report.dart';

void exportCustomExcelNGOK(List<ReportNgOkModel> list) {
  var excel = Excel.createExcel();
  var sheet = excel['Báo cáo tỷ lệ NG_OK'];
  excel.delete('Sheet1');

  // Tạo tiêu đề chính
  sheet.merge(CellIndex.indexByString('A1'), CellIndex.indexByString('K1'));
  sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue(
      'CÔNG TY CỔ PHẦN CÔNG NGHỆ CAO VÀ DỊCH VỤ PHẦN MỀM FACENET');
  sheet.cell(CellIndex.indexByString('A1')).cellStyle = CellStyle(
    bold: true,
    fontSize: 14,
    horizontalAlign: HorizontalAlign.Center,
    backgroundColorHex: ExcelColor.white,
    fontColorHex: ExcelColor.black,
    textWrapping: TextWrapping.Clip,
  );

  // Tạo sub-title
  sheet.merge(CellIndex.indexByString('A2'), CellIndex.indexByString('K2'));
  sheet.cell(CellIndex.indexByString('A2')).value =
      TextCellValue('BÁO CÁO TỶ LỆ NG/OK');
  sheet.cell(CellIndex.indexByString('A2')).cellStyle = CellStyle(
    bold: true,
    fontSize: 12,
    horizontalAlign: HorizontalAlign.Center,
    fontColorHex: ExcelColor.black,
    backgroundColorHex: ExcelColor.white, // Màu nền xanh
    textWrapping: TextWrapping.Clip,
  );

  // Thêm "Từ ngày" và "Đến ngày"
  sheet.merge(CellIndex.indexByString('E3'), CellIndex.indexByString('F3'));
  sheet.merge(CellIndex.indexByString('G3'), CellIndex.indexByString('H3'));

  sheet.cell(CellIndex.indexByString('E3')).value =
      TextCellValue('Từ ngày: 01/01/2024');
  sheet.cell(CellIndex.indexByString('G3')).value = TextCellValue(
      'Đến ngày: ${DateTime.now().toIso8601String().formatDateTime()}');

  // Header cho bảng dữ liệu
  List<String> headers = [
    'STT',
    'Mã WO',
    'Mã đơn hàng',
    'Mã sản phẩm',
    'Tên sản phẩm',
    'Thời gian bắt đầu',
    'Thời gian kết thúc',
    'Tổng thực tế',
    'Số lượng NG',
    'Số lượng OK',
    'Tỷ lệ NG(%)',
  ];

  for (int colIndex = 0; colIndex < headers.length; colIndex++) {
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: colIndex, rowIndex: 4))
        .value = TextCellValue(headers[colIndex]);
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: colIndex, rowIndex: 4))
        .cellStyle = CellStyle(
      bold: true,
      fontSize: 11,
      backgroundColorHex: ExcelColor.blue100, // Màu nền xanh
      horizontalAlign: HorizontalAlign.Center,
      fontColorHex: ExcelColor.black,
      textWrapping: TextWrapping.WrapText,
    );

    sheet.setColumnWidth(colIndex, colIndex < 2 ? 10 : 15);
  }

  // Đặt chiều cao cho các hàng có khả năng chứa tối đa 2 dòng
  for (int rowIndex = 0; rowIndex <= 8; rowIndex++) {
    sheet.setRowHeight(rowIndex, 30); // Điều chỉnh chiều cao hàng nếu cần
  }
  var sellOrderController = Get.find<SellOrderController>();
  for (int index = 0; index < list.length; index++) {
    final item = list[index];
    final row = index + 5;

    // Tính toán STT và các trường dữ liệu
    final stt = index + 1;
    final totalQuantity = (item.ngQuantity ?? 0) + (item.totalQuantity ?? 0);
    final ngRate = item.ngQuantity == 0
        ? '0.00'
        : (((item.ngQuantity ?? 0) / (item.totalQuantity ?? 1)) * 100)
            .toStringAsFixed(2);

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
      ..value = TextCellValue('$stt');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
      ..value = TextCellValue(sellOrderController
              .sellOrderList[item.workOrderModel?.id ?? 1].soCode ??
          '');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row))
      ..value = TextCellValue(item.workOrderModel?.productId.toString() ?? '');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row))
      ..value = TextCellValue(item.workOrderModel?.productName ?? '');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row))
      ..value = TextCellValue(item.workOrderModel?.id.toString() ?? '');
    sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row))
            .value =
        TextCellValue(item.workOrderModel?.startDate?.formatDateTime() ?? '');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row))
      ..value =
          TextCellValue(item.workOrderModel?.dueDate?.formatDateTime() ?? '');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row))
      ..value = TextCellValue('$totalQuantity');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row))
      ..value = TextCellValue(item.totalQuantity?.toString() ?? '0');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: row))
      ..value = TextCellValue(item.ngQuantity?.toString() ?? '0');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: row))
      ..value = TextCellValue('$ngRate%');
  }

  // Phần "Người tạo" và "Người phê duyệt"
  sheet.cell(CellIndex.indexByString('B${list.length + 8}')).value =
      TextCellValue('Người tạo');
  sheet.cell(CellIndex.indexByString('B${list.length + 9}')).value =
      TextCellValue('${LoginSession().getUser()?.name ?? ''}');
  sheet.cell(CellIndex.indexByString('I${list.length + 8}')).value =
      TextCellValue('Người phê duyệt');

  // Lưu file
  String outputFile = "C:/Users/Victory/Downloads/NG_OK_report.xlsx";
  List<int>? fileBytes = excel.save();
  if (fileBytes != null) {
    File(join(outputFile))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
    Get.snackbar('Xuất Excel thành công ', 'File đã được lưu tại: $outputFile',
        backgroundColor: Colors.green);
    print('File đã được lưu tại: $outputFile');
  } else {
    Get.snackbar('Xuất file thất bại', '', backgroundColor: Colors.red);
    print('Không thể lưu file.');
  }
}

void exportCustomExcelSO(List<SoReportModel> list) {
  var excel = Excel.createExcel();
  var sheet = excel['BÁO CÁO TỶ LỆ HOÀN THÀNH THEO SO'];
  excel.delete('Sheet1');

  // Tạo tiêu đề chính
  sheet.merge(CellIndex.indexByString('A1'), CellIndex.indexByString('K1'));
  sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue(
      'CÔNG TY CỔ PHẦN CÔNG NGHỆ CAO VÀ DỊCH VỤ PHẦN MỀM FACENET');
  sheet.cell(CellIndex.indexByString('A1')).cellStyle = CellStyle(
    bold: true,
    fontSize: 14,
    horizontalAlign: HorizontalAlign.Center,
    backgroundColorHex: ExcelColor.white,
    fontColorHex: ExcelColor.black,
    textWrapping: TextWrapping.Clip,
  );

  // Tạo sub-title
  sheet.merge(CellIndex.indexByString('A2'), CellIndex.indexByString('K2'));
  sheet.cell(CellIndex.indexByString('A2')).value =
      TextCellValue('BÁO CÁO TỶ LỆ HOÀN THÀNH THEO SO');
  sheet.cell(CellIndex.indexByString('A2')).cellStyle = CellStyle(
    bold: true,
    fontSize: 12,
    horizontalAlign: HorizontalAlign.Center,
    fontColorHex: ExcelColor.black,
    backgroundColorHex: ExcelColor.white, // Màu nền xanh
    textWrapping: TextWrapping.Clip,
  );

  // Thêm "Từ ngày" và "Đến ngày"
  sheet.merge(CellIndex.indexByString('E3'), CellIndex.indexByString('F3'));
  sheet.merge(CellIndex.indexByString('G3'), CellIndex.indexByString('H3'));

  sheet.cell(CellIndex.indexByString('E3')).value =
      TextCellValue('Từ ngày: 01/01/2024');
  sheet.cell(CellIndex.indexByString('G3')).value = TextCellValue(
      'Đến ngày: ${DateTime.now().toIso8601String().formatDateTime()}');

  // Header cho bảng dữ liệu
  List<String> headers = [
    'STT',
    'Mã đơn hàng',
    'Mã sản phẩm',
    'Tên sản phẩm',
    'Thời gian bắt đầu',
    'Thời gian kết thúc',
    'Sản lượng kế hoạch',
    'Tổng số lượng nhập kho',
    'Tỷ lệ hoàn thành',
    'Trạng thái',
  ];

  for (int colIndex = 0; colIndex < headers.length; colIndex++) {
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: colIndex, rowIndex: 4))
        .value = TextCellValue(headers[colIndex]);
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: colIndex, rowIndex: 4))
        .cellStyle = CellStyle(
      bold: true,
      fontSize: 11,
      backgroundColorHex: ExcelColor.blue100, // Màu nền xanh
      horizontalAlign: HorizontalAlign.Center,
      fontColorHex: ExcelColor.black,
      textWrapping: TextWrapping.WrapText,
    );

    sheet.setColumnWidth(colIndex, colIndex < 2 ? 10 : 15);
  }

  // Đặt chiều cao cho các hàng có khả năng chứa tối đa 2 dòng
  for (int rowIndex = 0; rowIndex <= 8; rowIndex++) {
    sheet.setRowHeight(rowIndex, 30); // Điều chỉnh chiều cao hàng nếu cần
  }
  var sellOrderController = Get.find<SellOrderController>();
  for (int index = 0; index < list.length; index++) {
    final item = list[index];
    final row = index + 5;

    // Tính toán STT và các trường dữ liệu
    final stt = index + 1;
    final planQuantity = item.planQquantity ?? 0; // Sản lượng kế hoạch
    final totalQuantity = item.totalQuantity ?? 0; // Tổng số lượng nhập kho
    final completionRate = planQuantity == 0
        ? '0.00'
        : ((totalQuantity / planQuantity) * 100).toStringAsFixed(2);

    // Thêm dữ liệu vào từng cột
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
      ..value = TextCellValue('$stt'); // STT
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
      ..value = TextCellValue(sellOrderController
              .sellOrderList[item.workOrderModel?.id ?? 1].soCode ??
          ''); // Mã đơn hàng
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row))
      ..value = TextCellValue(
          item.workOrderModel?.productId?.toString() ?? ''); // Mã sản phẩm
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row))
      ..value =
          TextCellValue(item.workOrderModel?.productName ?? ''); // Tên sản phẩm
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row))
      ..value = TextCellValue(
          item.workOrderModel?.startDate?.formatDateTime() ??
              ''); // Thời gian bắt đầu
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row))
      ..value = TextCellValue(item.workOrderModel?.dueDate?.formatDateTime() ??
          ''); // Thời gian kết thúc
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row))
      ..value = TextCellValue('$planQuantity'); // Sản lượng kế hoạch
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row))
      ..value = TextCellValue('$totalQuantity'); // Tổng số lượng nhập kho
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row))
      ..value = TextCellValue('$completionRate%'); // Tỷ lệ hoàn thành
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: row))
      ..value = TextCellValue(item.workOrderModel?.isActive == 1
          ? 'Đang sản xuất'
          : 'Ngưng sản xuất'); // Trạng thái
  }

  // Phần "Người tạo" và "Người phê duyệt"
  sheet.cell(CellIndex.indexByString('B${list.length + 8}')).value =
      TextCellValue('Người tạo');
  sheet.cell(CellIndex.indexByString('B${list.length + 9}')).value =
      TextCellValue('${LoginSession().getUser()?.name ?? ''}');
  sheet.cell(CellIndex.indexByString('I${list.length + 8}')).value =
      TextCellValue('Người phê duyệt');

  // Lưu file
  String outputFile = "C:/Users/Victory/Downloads/so_report.xlsx";
  List<int>? fileBytes = excel.save();
  if (fileBytes != null) {
    File(join(outputFile))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
    Get.snackbar('Xuất Excel thành công ', 'File đã được lưu tại: $outputFile',
        backgroundColor: Colors.green);
    print('File đã được lưu tại: $outputFile');
  } else {
    Get.snackbar('Xuất file thất bại', '', backgroundColor: Colors.red);
    print('Không thể lưu file.');
  }
}

void exportCustomExcelWO(List<WoReportModel> list) {
  var excel = Excel.createExcel();
  var sheet = excel['BÁO CÁO TỶ LỆ HOÀN THÀNH THEO WO'];
  excel.delete('Sheet1');

  // Tạo tiêu đề chính
  sheet.merge(CellIndex.indexByString('A1'), CellIndex.indexByString('K1'));
  sheet.cell(CellIndex.indexByString('A1')).value = TextCellValue(
      'CÔNG TY CỔ PHẦN CÔNG NGHỆ CAO VÀ DỊCH VỤ PHẦN MỀM FACENET');
  sheet.cell(CellIndex.indexByString('A1')).cellStyle = CellStyle(
    bold: true,
    fontSize: 14,
    horizontalAlign: HorizontalAlign.Center,
    backgroundColorHex: ExcelColor.white,
    fontColorHex: ExcelColor.black,
    textWrapping: TextWrapping.Clip,
  );

  // Tạo sub-title
  sheet.merge(CellIndex.indexByString('A2'), CellIndex.indexByString('K2'));
  sheet.cell(CellIndex.indexByString('A2')).value =
      TextCellValue('BÁO CÁO TỶ LỆ HOÀN THÀNH THEO WO');
  sheet.cell(CellIndex.indexByString('A2')).cellStyle = CellStyle(
    bold: true,
    fontSize: 12,
    horizontalAlign: HorizontalAlign.Center,
    fontColorHex: ExcelColor.black,
    backgroundColorHex: ExcelColor.white, // Màu nền xanh
    textWrapping: TextWrapping.Clip,
  );

  // Thêm "Từ ngày" và "Đến ngày"
  sheet.merge(CellIndex.indexByString('E3'), CellIndex.indexByString('F3'));
  sheet.merge(CellIndex.indexByString('G3'), CellIndex.indexByString('H3'));

  sheet.cell(CellIndex.indexByString('E3')).value =
      TextCellValue('Từ ngày: 01/01/2024');
  sheet.cell(CellIndex.indexByString('G3')).value = TextCellValue(
      'Đến ngày: ${DateTime.now().toIso8601String().formatDateTime()}');

  // Header cho bảng dữ liệu
  List<String> headers = [
    'STT',
    'Mã WO',
    'Mã đơn hàng',
    'Mã sản phẩm',
    'Tên sản phẩm',
    'Thời gian bắt đầu',
    'Thời gian kết thúc',
    'Sản lượng kế hoạch',
    'Tổng số lượng nhập kho',
    'Tỷ lệ hoàn thành',
    'Trạng thái',
  ];

  for (int colIndex = 0; colIndex < headers.length; colIndex++) {
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: colIndex, rowIndex: 4))
        .value = TextCellValue(headers[colIndex]);
    sheet
        .cell(CellIndex.indexByColumnRow(columnIndex: colIndex, rowIndex: 4))
        .cellStyle = CellStyle(
      bold: true,
      fontSize: 11,
      backgroundColorHex: ExcelColor.blue100, // Màu nền xanh
      horizontalAlign: HorizontalAlign.Center,
      fontColorHex: ExcelColor.black,
      textWrapping: TextWrapping.WrapText,
    );

    sheet.setColumnWidth(colIndex, colIndex < 2 ? 10 : 15);
  }

  // Đặt chiều cao cho các hàng có khả năng chứa tối đa 2 dòng
  for (int rowIndex = 0; rowIndex <= 8; rowIndex++) {
    sheet.setRowHeight(rowIndex, 30); // Điều chỉnh chiều cao hàng nếu cần
  }
  var sellOrderController = Get.find<SellOrderController>();
  for (int index = 0; index < list.length; index++) {
    final item = list[index];
    final row = index + 5;

    // Tính toán STT và các trường dữ liệu
    final stt = index + 1;
    final woQuantity = item.woquantity ?? 1; // Sản lượng kế hoạch
    final totalQuantity = item.totalQuantity ?? 0; // Tổng số lượng nhập kho
    final completionRate = woQuantity == 0
        ? '0.00'
        : ((totalQuantity / woQuantity) * 100).toStringAsFixed(2);

    // Thêm dữ liệu vào từng cột
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
      ..value = TextCellValue('$stt'); // STT
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
      ..value = TextCellValue(
          item.workOrderModel?.workOrderCode ?? ''); // Mã đơn hàng
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row))
      ..value = TextCellValue(sellOrderController
              .sellOrderList[item.workOrderModel?.id ?? 1].soCode ??
          '');
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row))
      ..value = TextCellValue(
          item.workOrderModel?.productId?.toString() ?? ''); // Mã sản phẩm
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row))
      ..value =
          TextCellValue(item.workOrderModel?.productName ?? ''); // Tên sản phẩm
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row))
      ..value = TextCellValue(
          item.workOrderModel?.startDate?.formatDateTime() ??
              ''); // Thời gian bắt đầu
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row))
      ..value = TextCellValue(item.workOrderModel?.dueDate?.formatDateTime() ??
          ''); // Thời gian kết thúc
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row))
      ..value = TextCellValue('$woQuantity'); // Sản lượng kế hoạch
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row))
      ..value = TextCellValue('$totalQuantity'); // Tổng số lượng nhập kho
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: row))
      ..value = TextCellValue('$completionRate%'); // Tỷ lệ hoàn thành
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: row))
      ..value = TextCellValue(item.workOrderModel?.isActive == 1
          ? 'Mới tạo'
          : 'Đã gửi QMS'); // Trạng thái
  }

  // Phần "Người tạo" và "Người phê duyệt"
  sheet.cell(CellIndex.indexByString('B${list.length + 8}')).value =
      TextCellValue('Người tạo');
  sheet.cell(CellIndex.indexByString('B${list.length + 9}')).value =
      TextCellValue('${LoginSession().getUser()?.name ?? ''}');
  sheet.cell(CellIndex.indexByString('I${list.length + 8}')).value =
      TextCellValue('Người phê duyệt');

  // Lưu file
  String outputFile = "C:/Users/Victory/Downloads/wo_report.xlsx";
  List<int>? fileBytes = excel.save();
  if (fileBytes != null) {
    File(join(outputFile))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
    Get.snackbar('Xuất Excel thành công ', 'File đã được lưu tại: $outputFile',
        backgroundColor: Colors.green);
    print('File đã được lưu tại: $outputFile');
  } else {
    Get.snackbar('Xuất file thất bại', '', backgroundColor: Colors.red);
    print('Không thể lưu file.');
  }
}
