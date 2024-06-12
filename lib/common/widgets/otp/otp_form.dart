import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swappr/utils/constants/colors.dart';
import 'package:swappr/utils/constants/sizes.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    String _otp1 = '';
    String _otp2 = '';
    String _otp3 = '';
    String _otp4 = '';
    String _otp5 = '';
    String _otp6 = '';

    String otpValue;
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  _otp1 = value;
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (value) {
                _otp1 = value as String;
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                fillColor: TColors.grey.withOpacity(0.5),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: TColors.primary),
                    borderRadius: BorderRadius.circular(8)
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          const SizedBox(width: TSizes.md,),
          SizedBox(
            height: 40,
            width: 40,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  _otp2 = value;
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (value) {
                _otp2 = value as String;
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                fillColor: TColors.grey.withOpacity(0.5),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: TColors.primary),
                    borderRadius: BorderRadius.circular(8)
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          const SizedBox(width: TSizes.md,),
          SizedBox(
            height: 40,
            width: 40,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  _otp3 = value;
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (value) {
                _otp3 = value as String;
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                fillColor: TColors.grey.withOpacity(0.5),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: TColors.primary),
                    borderRadius: BorderRadius.circular(8)
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          const SizedBox(width: TSizes.md,),
          SizedBox(
            height: 40,
            width: 40,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  _otp4 = value;
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (value) {
                _otp4 = value as String;
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                fillColor: TColors.grey.withOpacity(0.5),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: TColors.primary),
                    borderRadius: BorderRadius.circular(8)
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          const SizedBox(width: TSizes.md,),
          SizedBox(
            height: 40,
            width: 40,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  _otp5 = value;
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (value) {
                _otp5 = value as String;
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                fillColor: TColors.grey.withOpacity(0.5),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: TColors.primary),
                    borderRadius: BorderRadius.circular(8)
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          const SizedBox(width: TSizes.md,),
          SizedBox(
            height: 40,
            width: 40,
            child: TextFormField(
              onChanged: (value) {
                if (value.length == 1) {
                  _otp6 = value;
                  FocusScope.of(context).nextFocus();
                }
              },
              onSaved: (value) {
                _otp6 = value as String;
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                fillColor: TColors.grey.withOpacity(0.5),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: TColors.primary),
                    borderRadius: BorderRadius.circular(8)
                ),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          const SizedBox(width: TSizes.md,),
        ],
      ),
    );
  }
}

