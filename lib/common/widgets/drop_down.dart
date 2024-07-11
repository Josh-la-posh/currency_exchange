import 'package:flutter/material.dart';
import 'package:pouch/utils/constants/colors.dart';
import 'package:pouch/utils/constants/sizes.dart';

class TDropdownWidget extends StatefulWidget {
  const TDropdownWidget({super.key});

  @override
  State<TDropdownWidget> createState() => _TDropdownWidgetState();
}

class _TDropdownWidgetState extends State<TDropdownWidget> {

  String? _selectedItems;
  List items = ['select', 'Lab Test', 'Radiology'];
  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: TSizes.textInputFieldHeight,
      decoration: BoxDecoration(
        color: TColors.textFieldBackground,
        border: Border.all(
          color: TColors.secondaryBorder30),
        borderRadius: const BorderRadius.all(Radius.circular(TSizes.borderRadiusSm))
      ),
      child: DropdownButton(
        dropdownColor: Colors.white,
        focusColor: Colors.white,
        autofocus: false,
        isExpanded: true,
        value: _selectedItems,
        underline: const SizedBox(),
        icon: const RotatedBox(
          quarterTurns: 3,
          child: Padding(
            padding: EdgeInsets.all(14.8),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        onChanged: (String? newValue) {
          setState(() {
            _selectedItems = newValue!;
            if (newValue == 'Lab Test') {
              current = 1;
            } else if (newValue == 'Radiology') {
              current = 2;
            } else {current = 0;}
          });
        },
        items: [
          for (final item in items)
            DropdownMenuItem<String>(
              value: item,
              child: SizedBox(
                // height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontFamily: 'Avenir',
                      color: Color.fromRGBO(107, 111, 128, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.25,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
