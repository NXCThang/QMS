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
      return 'NO';
    }
  }
}
