import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_back_button.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/app_input_feild.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  static const String routeName = '/add-card';

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _cardNumber = TextEditingController();
  final TextEditingController _ccv = TextEditingController();
  final TextEditingController _exp = TextEditingController();
  final TextEditingController _cardholderName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Row(
          children: [
            AppBackButton(),
            Expanded(child: Center(child: TextMedium('Add Card'))),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // street address
                AppInputFeild(
                  controller: _cardholderName,
                  hintText: 'Cardholder Name',
                ),
                16.verticalSpace,
                //   city
                AppInputFeild(controller: _cardNumber, hintText: 'Card Number'),
                16.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child:
                          //   city
                          AppInputFeild(controller: _ccv, hintText: 'CCV'),
                    ),
                    24.horizontalSpace,
                    Expanded(
                      child:
                          //   city
                          AppInputFeild(controller: _exp, hintText: 'Exp'),
                    ),
                  ],
                ),

                Spacer(),

                AppButton(text: 'Save', onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
