import 'package:clot/core/presentation/constants/app_colors.dart';
import 'package:clot/core/presentation/constants/app_svgs.dart';
import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_back_button.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  static const String routeName = '/payment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Row(
          children: [
            AppBackButton(),
            Expanded(child: Center(child: TextMedium('Payment'))),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // card column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextRegular('Cards'),
                  16.verticalSpace,
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.kLightGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextRegular('**** 4187'),
                        SvgPicture.asset(
                          AppSvgs.kArrowRight,
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              32.verticalSpace,

              // payment type column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextRegular('Paypal'),
                  16.verticalSpace,
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.kLightGrey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextRegular('Cloth@gmail.com'),
                        SvgPicture.asset(
                          AppSvgs.kArrowRight,
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed('add-card'),
        elevation: 0,
        child: SvgPicture.asset(
          AppSvgs.kAddIcon,
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
