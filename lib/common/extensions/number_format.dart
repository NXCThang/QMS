extension NumberExtensions on num {
  double formatPercent() {
    return this * 100;
  }

  String formatConclusion() {
    if (this == 1) {
      return 'Đạt';
    } else {
      return 'Không đạt';
    }
  }

  String formatIsActive() {
    if (this == 1) {
      return 'CREATE';
    } else {
      return 'SENT';
    }
  }

  String displayIsActive() {
    if (this == 1) {
      return 'Đang sản xuất';
    } else {
      return 'Ngưng sản xuất';
    }
  }

  String displayWOReport() {
    if (this == 1) {
      return 'Mới tạo';
    } else {
      return 'Đã gửi QMS';
    }
  }

  String displayTemplate() {
    if (this == 1) {
      return 'Đang hoạt động';
    } else {
      return 'Tạm dừng';
    }
  }
}
