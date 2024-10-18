import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pouch/common/styles/spacing_styles.dart';
import 'package:pouch/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/buttons/elevated_button.dart';
import '../../../../data/modules/interceptor.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/validators/validation.dart';
import '../../../authentication/controllers/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  final AppInterceptor appInterceptor = AppInterceptor();
  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChangePasswordController controller = Get.put(ChangePasswordController());
    final formKey = GlobalKey<FormState>();
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: darkMode ? TColors.black.withOpacity(0.4) : TColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(
            foregroundColor: Colors.grey,
            iconSize: TSizes.iconBackSize,
          ),
          hoverColor: Colors.transparent,
        ),
        title: Text(
          'Change Password',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: TSizes.lg),

                // Old Password
                _buildPasswordField(
                  context,
                  label: 'Old Password',
                  isObscure: controller.obscureOldPassword,
                  onToggle: controller.toggleObscureOldPassword,
                  onChanged: (value) => controller.oldPassword.text = value,
                  validator: TValidator.validatePassword,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // New Password
                _buildPasswordField(
                  context,
                  label: 'New Password',
                  isObscure: controller.obscurePassword,
                  onToggle: controller.toggleObscurePassword,
                  onChanged: (value) => controller.password.text = value,
                  validator: TValidator.validatePassword,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Confirm Password
                _buildPasswordField(
                  context,
                  label: 'Confirm Password',
                  isObscure: controller.obscureConPassword,
                  onToggle: controller.toggleObscureConPassword,
                  onChanged: (value) => controller.confirmPass.text = value,
                  validator: (value) =>
                      TValidator.validateConfirmPassword(value, controller.password.text),
                ),

                const SizedBox(height: TSizes.spaceBtwSections * 2),

                // Submit Button
                Obx(() => TElevatedButton(
                  onTap: () => controller.isPasswordChanging.value ? null : controller.submitChangePasswordForm(formKey: formKey),
                  buttonText: controller.isPasswordChanging.value ? 'Updating ...' : 'Proceed',
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
      BuildContext context, {
        required String label,
        required RxBool isObscure,
        required Function() onToggle,
        required Function(String) onChanged,
        required String? Function(String?) validator,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 10),
        Obx(
              () => TextFormField(
            style: Theme.of(context).textTheme.labelMedium,
            onChanged: onChanged,
            validator: validator,
            obscureText: isObscure.value,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: onToggle,
                icon: Icon(isObscure.value ? Iconsax.eye_slash : Iconsax.eye),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
