import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/constants/icon_size_manager.dart';
import 'package:clot/core/presentation/ui/widgets/icon_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBackButton extends StatefulWidget {
  const AppBackButton({super.key});

  @override
  State<AppBackButton> createState() => _AppBackButtonState();
}

class _AppBackButtonState extends State<AppBackButton> {
  @override
  Widget build(BuildContext context) {
    return IconContainer(
      child: SvgPicture.asset(
        AppSvgs.kArrowLeft,
        fit: BoxFit.cover,
        width: IconSize.s24,
        height: IconSize.s24,
      ),
    );
  }
}
