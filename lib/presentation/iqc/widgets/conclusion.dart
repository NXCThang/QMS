import 'package:flutter/material.dart';
import 'package:qms_app/common/color.dart';

class ConclusionWidget extends StatefulWidget {
  ConclusionWidget({super.key, this.value, this.enable = true, this.onChanged});
  int? value;
  bool? enable;
  final Function(int?)? onChanged;

  @override
  _ConclusionWidgetState createState() => _ConclusionWidgetState();
}

class _ConclusionWidgetState extends State<ConclusionWidget> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value == 1
        ? 'Đạt'
        : widget.value == 0
            ? 'Không đạt'
            : null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Kết luận',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '*',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              // Tùy chọn "Đạt"
              Row(
                children: [
                  Radio<String>(
                    activeColor: QMSColor.mainorange,
                    value: 'Đạt',
                    groupValue: _selectedValue,
                    onChanged: (widget.enable ?? false)
                        ? (value) {
                            setState(() {
                              _selectedValue = value;
                              widget.onChanged?.call(value == 'Đạt' ? 1 : 0);
                            });
                          }
                        : null,
                  ),
                  Text('Đạt'),
                ],
              ),
              SizedBox(width: 300),
              Row(
                children: [
                  Radio<String>(
                    activeColor: QMSColor.mainorange,
                    value: 'Không đạt',
                    groupValue: _selectedValue,
                    onChanged: (widget.enable ?? false)
                        ? (value) {
                            setState(() {
                              _selectedValue = value;
                              widget.onChanged
                                  ?.call(value == 'Không đạt' ? 0 : 1);
                            });
                          }
                        : null,
                  ),
                  Text('Không đạt'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
