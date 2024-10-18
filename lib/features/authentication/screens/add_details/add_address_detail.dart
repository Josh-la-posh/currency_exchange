import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/features/authentication/controllers/address_controller.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/validators/validation.dart';

class AddAddressDetail extends StatelessWidget {
  AddressFormController controller = Get.put(AddressFormController());
  final formKey = GlobalKey<FormState>();

  AddAddressDetail({
    Key? key,
    required String email,
    required String password,
    required bool rememberMe,
  }) : super(key: key) {
    controller.email.text = email;
    controller.password.text = password;
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required Function(String) onSaved,
    required String? Function(String?) validator,
    Widget? suffix,
    bool isReadOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Get.textTheme.labelMedium),
        SizedBox(
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: onSaved,
            validator: validator,
            decoration: InputDecoration(suffixIcon: suffix),
            readOnly: isReadOnly,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: TSizes.defaultSpace,
            right: TSizes.defaultSpace,
            top: 30,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Address Details',
                    style: Get.textTheme.bodyLarge!.copyWith(
                      fontWeight: TSizes.fontWeightLg,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    text: 'Enter your address details',
                    style: Get.textTheme.labelMedium,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Post Code',
                  controller: controller.postCode,
                  keyboardType: TextInputType.number,
                  onSaved: (val) {
                    controller.postCode.text = val;
                    if (val.length > 4) {
                      controller.fetchAddress(controller.postCode.text);
                    }
                  },
                  validator: TValidator.emptyFieldValidator,
                  suffix: Container(
                    margin: EdgeInsets.only(right: 1),
                    decoration: BoxDecoration(
                      color: TColors.primary,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5)
                      )
                    ),
                    child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        if (controller.postCode.text.isNotEmpty) {
                          controller.fetchAddress(controller.postCode.text);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() => _buildTextField(
                  label: 'Address',
                  controller: controller.generatedAddress,
                  keyboardType: TextInputType.text,
                  onSaved: (val) => controller.generatedAddress.text = val,
                  validator: TValidator.emptyFieldValidator,
                  isReadOnly: controller.isAddressEdited.isTrue ? false : true,
                )),
                const SizedBox(height: TSizes.defaultSpace * 3),
                Obx(() {
                  if (controller.isUpdatingAddress.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return TElevatedButton(
                      onTap: () => controller.submitAddressForm(formKey: formKey),
                      buttonText: 'Submit',
                    );
                  }
                }),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      controller.isAddressEdited.value = !controller.isAddressEdited.value;
                      print('The new is ${controller.isAddressEdited.value}');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.zero
                    ),
                    child: Text(
                      'Enter your address manually',
                      style: Get.textTheme.labelMedium?.copyWith(
                        color: TColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: TColors.primary,
                        decorationThickness: 1.5,
                      )
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
