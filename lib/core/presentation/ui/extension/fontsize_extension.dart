import 'package:clot/core/presentation/constants/font_manager.dart';

extension FontsizeExtension on num {
  double get fs => AppFontSize.fsValidate(toDouble());
}
