import 'package:clot/core/presentation/ui/extension/app_spacing_extension.dart';
import 'package:clot/core/presentation/ui/widgets/app_back_button.dart';
import 'package:clot/core/presentation/ui/widgets/app_button.dart';
import 'package:clot/core/presentation/ui/widgets/app_input_feild.dart';
import 'package:clot/core/presentation/ui/widgets/text_styles.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  static const String routeName = '/add-address';

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _streetAddress = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _zipCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        title: Row(
          children: [
            AppBackButton(),
            Expanded(child: Center(child: TextMedium('Add Address'))),
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
                  controller: _streetAddress,
                  hintText: 'Street Address',
                ),
                16.verticalSpace,
                //   city
                AppInputFeild(controller: _city, hintText: 'City'),
                16.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child:
                          //   city
                          AppInputFeild(controller: _state, hintText: 'State'),
                    ),
                    24.horizontalSpace,
                    Expanded(
                      child:
                          //   city
                          AppInputFeild(
                            controller: _zipCode,
                            hintText: 'Zip Code',
                          ),
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
