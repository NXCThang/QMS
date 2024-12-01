import 'package:flutter/material.dart';
import 'package:qms_app/common/color.dart';
import 'package:qms_app/common/components/paginated_c.dart';

class BuildPaginationControls<T> extends StatelessWidget {
  const BuildPaginationControls({
    super.key,
    required this.paginatedController,
  });

  final PaginatedController<T> paginatedController; // Type is generic

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 33),
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              size: 14,
              color: paginatedController.currentPage.value + 1 == 1
                  ? QMSColor.maingrey
                  : QMSColor.mainorange,
            ),
            onPressed: paginatedController.currentPage.value == 0
                ? null // Vô hiệu hóa nếu đang ở trang đầu tiên
                : paginatedController.previousPage,
          ),
          const SizedBox(width: 24),
          Text(
            '${paginatedController.currentPage.value + 1} / ${paginatedController.totalPages}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: QMSColor.mainorange,
            ),
          ),
          const SizedBox(width: 24),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 14,
              color: paginatedController.currentPage.value + 1 ==
                      paginatedController.totalPages
                  ? QMSColor.maingrey
                  : QMSColor.mainorange,
            ),
            onPressed: paginatedController.currentPage.value + 1 ==
                    paginatedController.totalPages
                ? null // Vô hiệu hóa nếu đang ở trang cuối cùng
                : paginatedController.nextPage,
          ),
        ],
      ),
    );
  }
}
