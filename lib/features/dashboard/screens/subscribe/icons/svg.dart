import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget NgnIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="18" height="10" viewBox="0 0 18 10" fill="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
      <mask id="mask0_1633_2351" style="mask-type:alpha" maskUnits="userSpaceOnUse" x="0" y="0" width="18" height="10">
      <rect width="18" height="10" fill="#C4C4C4"/>
      </mask>
      <g mask="url(#mask0_1633_2351)">
      <rect x="-1" width="20" height="10" fill="url(#pattern0)"/>
      </g>
      <defs>
      <pattern id="pattern0" patternContentUnits="objectBoundingBox" width="1" height="1">
      <use xlink:href="#image0_1633_2351" transform="matrix(0.00363636 0 0 0.00727273 0 -0.165455)"/>
      </pattern>
      <image id="image0_1633_2351" width="275" height="183" xlink:href="data:image/png;base64,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"/>
      </defs>
      </svg>

    ''',
    width: width,
    height: height,
  );
}
Widget GbpIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="18" height="10" viewBox="0 0 18 10" fill="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
      <rect x="-1" width="20" height="10" fill="url(#pattern0)"/>
      <defs>
      <pattern id="pattern0" patternContentUnits="objectBoundingBox" width="1" height="1">
      <use xlink:href="#image0_1633_2370" transform="matrix(0.00333333 0 0 0.00666667 0 -0.166667)"/>
      </pattern>
      <image id="image0_1633_2370" width="300" height="200" xlink:href="data:image/png;base64,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"/>
      </defs>
      </svg>
    ''',
    width: width,
    height: height,
  );
}

Widget DeleteIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="16" height="18" viewBox="0 0 16 18" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M5 0V1H0V3H1V16C1 16.5304 1.21071 17.0391 1.58579 17.4142C1.96086 17.7893 2.46957 18 3 18H13C13.5304 18 14.0391 17.7893 14.4142 17.4142C14.7893 17.0391 15 16.5304 15 16V3H16V1H11V0H5ZM5 5H7V14H5V5ZM9 5H11V14H9V5Z" fill="white"/>
      </svg>
    ''',
    width: width,
    height: height,
  );
}


