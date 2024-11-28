import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pouch/common/widgets/buttons/elevated_button.dart';
import 'package:pouch/features/authentication/controllers/address_controller.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';
import 'package:pouch/utils/validators/validation.dart';

class AddAddressDetail extends StatelessWidget {
  final AddressFormController controller = Get.put(AddressFormController());
  final formKey = GlobalKey<FormState>();

  AddAddressDetail({
    Key? key,
    required String email,
    required String password,
  }) : super(key: key) {
    controller.email.value = email;
    controller.password.value = password;
  }

  Widget _buildTextField({
    required String label,
    required TextInputType keyboardType,
    TextEditingController? controller,
    required Function(String) onChanged,
    required String? Function(String?)? validator,
    Widget? suffix,
    bool isReadOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Get.textTheme.labelMedium),
        SizedBox(height: 5),
        SizedBox(
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            textDirection: TextDirection.ltr,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: onChanged,
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
                    text: 'Residential Address Details',
                    style: Get.textTheme.bodyLarge!.copyWith(
                      fontWeight: TSizes.fontWeightLg,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    text: 'Please, Select your region',
                    style: Get.textTheme.labelMedium,
                  ),
                ),
                SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    fillColor: Get.isDarkMode ? TColors.timeLineBorder : TColors.textFieldBackground,
                  ),
                  autofocus: false,
                  isExpanded: true,
                  value: controller.selectedRegion.value,
                  icon: Icon(Icons.arrow_drop_down, size: 20, color: TColors.textPrimary),
                  onChanged: (val) {
                    controller.updateSelectedRegion(val!);
                    if (controller.selectedRegion.value == 'Africa' || controller.selectedRegion.value == 'Others') {
                      controller.isAddressEdited.value = true;
                    } else {
                      controller.isAddressEdited.value = false;
                    }
                  },
                  items: [
                    for (final item in controller.countryList)
                      DropdownMenuItem<String>(
                        value: item,
                        child: SizedBox(
                          child: Row(
                            children: [
                              Text(
                                item,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Number & Street name',
                  keyboardType: TextInputType.text,
                  controller: controller.address,
                  onChanged: (val) => controller.address.text = val,
                  validator: TValidator.emptyFieldValidator,
                  suffix: IconButton(
                    onPressed: () => controller.address.clear(),
                    icon: Icon(Icons.clear, color: TColors.primary, size: 15),
                  ),
                  isReadOnly: false,
                ),
                const SizedBox(height: 20),
                Obx(() => controller.selectedRegion.value == 'Africa' || controller.selectedRegion.value == 'Others'
                    ? _buildTextField(
                  label: 'Zip or Postal Code (optional)',
                  keyboardType: TextInputType.text,
                  onChanged: (val) => controller.postCode.value = val,
                  validator: null,
                )
                    : _buildTextField(
                  label: 'Zip or Postal Code',
                  keyboardType: TextInputType.text,
                  onChanged: (val) {
                    controller.postCode.value = val;
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
                        if (controller.postCode.value.isNotEmpty) {
                          controller.fetchAddress(controller.postCode.value);
                        }
                      },
                    ),
                  ),
                )),
                const SizedBox(height: 20),
                Obx(() => controller.selectedRegion.value == 'Africa' || controller.selectedRegion.value == 'Others'
                    ? _buildTextField(
                  label: 'Town or City',
                  keyboardType: TextInputType.text,
                  onChanged: (val) => controller.city.value = val,
                  validator: TValidator.emptyFieldValidator,
                  isReadOnly: false,
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Town or City', style: Get.textTheme.labelMedium),
                        SizedBox(height: 5),
                        Container(
                        height: 48,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: TColors.textFieldBackground,
                          borderRadius: BorderRadius.circular(TSizes.buttonRadius),
                          border: Border.all(
                              width: 1,
                              color: controller.cityIsEmpty.isTrue ? TColors.danger :  TColors.secondaryBorder30
                          ),
                        ),
                        child: Text(controller.city.value,
                        style: Get.theme.textTheme.bodyLarge?.copyWith(color: TColors.textPrimary),),
                      ),
                      ],
                    )
                ),
                const SizedBox(height: 20),
                Obx(() => controller.selectedRegion.value == 'Africa' || controller.selectedRegion.value == 'Others'
                    ? _buildTextField(
                  label: 'State or Province',
                  keyboardType: TextInputType.text,
                  onChanged: (val) => controller.state.value = val,
                  validator: TValidator.emptyFieldValidator,
                  isReadOnly: false,
                )
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('State or Province', style: Get.textTheme.labelMedium),
                    SizedBox(height: 5),
                    Container(
                      height: 48,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: TColors.textFieldBackground,
                        borderRadius: BorderRadius.circular(TSizes.buttonRadius),
                        border: Border.all(
                            width: 1,
                            color: controller.cityIsEmpty.isTrue ? TColors.danger : TColors.secondaryBorder30
                        ),
                      ),
                      child: Text(controller.state.value,
                        style: Get.theme.textTheme.bodyLarge?.copyWith(color: TColors.textPrimary),),
                    ),
                  ],
                )
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Country', style: Get.textTheme.labelLarge),
                    SizedBox(height: 5),
                    Obx(() => controller.selectedRegion.value == 'Africa' || controller.selectedRegion.value == 'Others'

                        ? SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: TColors.textFieldBackground,
                              side: BorderSide(
                                  width: 1,
                                  color: controller.cityIsEmpty.isTrue ? TColors.danger : TColors.secondaryBorder30
                              )
                          ),
                          onPressed: (){
                            controller.isCountrySelected.value = false;
                            showCountryPicker(
                                context: context,
                                favorite: <String>['NG'],
                                countryListTheme: CountryListThemeData(
                                    flagSize: 18,
                                    backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)
                                    ),
                                    inputDecoration: InputDecoration(
                                      labelText: 'Search Country...',
                                      hintText: 'Start typing to search',
                                      prefixIcon: const Icon(Icons.search),
                                    )
                                ),
                                onSelect: (Country country) {
                                  controller.country.value = country.name;
                                  controller.isCountrySelected.value = true;
                                }
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                controller.isCountrySelected.isFalse ? 'Select Country' : controller.country.value,
                                style: Get.theme.textTheme.bodyLarge?.copyWith(color: TColors.textPrimary),
                              ),
                              ),
                            ],
                          )
                      ),
                    )
                        : Container(
                          height: 48,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: TColors.textFieldBackground,
                            borderRadius: BorderRadius.circular(TSizes.buttonRadius),
                            border: Border.all(
                                width: 1,
                                color: controller.cityIsEmpty.isTrue ? TColors.danger : TColors.secondaryBorder30
                            ),
                          ),
                          child: Text(controller.country.value,
                            style: Get.theme.textTheme.bodyLarge?.copyWith(color: TColors.textPrimary),),
                        )
                    ),
                  ],
                ),
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
                // TextButton(
                //     onPressed: () {
                //       controller.isAddressEdited.value = !controller.isAddressEdited.value;
                //       print('The new is ${controller.isAddressEdited.value}');
                //     },
                //     style: TextButton.styleFrom(
                //       backgroundColor: Colors.transparent,
                //       padding: EdgeInsets.zero
                //     ),
                //     child: Text(
                //       'Enter your address manually',
                //       style: Get.textTheme.labelMedium?.copyWith(
                //         color: TColors.primary,
                //         decoration: TextDecoration.underline,
                //         decorationColor: TColors.primary,
                //         decorationThickness: 1.5,
                //       )
                //     )
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
