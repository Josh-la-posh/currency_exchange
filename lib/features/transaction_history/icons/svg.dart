import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget TransactionIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="9" height="12" viewBox="0 0 9 12" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M2.33492 0.666504L0.0356445 3.03687H1.7601V7.18502H2.90974V3.03687H4.6342L2.33492 0.666504ZM6.35866 8.9628V4.81465H5.20902V8.9628H3.48456L5.78384 11.3332L8.08312 8.9628H6.35866Z" fill="#664C89"/>
      </svg>
    ''',
    width: width,
    height: height,
  );
}