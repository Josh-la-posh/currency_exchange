import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget Logo({double? width, double? height, Color? color}) {
  return SvgPicture.string(
    '''<svg width="78" height="90" viewBox="0 0 78 90" fill="none" xmlns="http://www.w3.org/2000/svg">
        <g filter="url(#filter0_d_1633_2)">
        <rect x="4" width="70" height="70" rx="35" fill="white"/>
        </g>
        <path fill-rule="evenodd" clip-rule="evenodd" d="M26.8594 48.2907C24.928 48.2907 23.1692 47.1783 22.3416 45.4331L20.9981 42.5998C19.4249 39.2824 21.8443 35.4574 25.5158 35.4574H40.8866C40.8866 35.4574 44.5536 36.162 46.0924 39.4634C47.6313 42.7647 46.9722 48.2907 46.9722 48.2907H26.8594ZM53.085 21.7778C55.0165 21.7778 56.7752 22.8902 57.6028 24.6354L58.9464 27.4687C60.5195 30.7861 58.1001 34.6111 54.4286 34.6111H39.0578C39.0578 34.6111 35.3908 33.9065 33.852 30.6052C32.3132 27.3038 32.9722 21.7778 32.9722 21.7778H53.085Z" fill="#664C89"/>
        <path fill-rule="evenodd" clip-rule="evenodd" d="M40.7469 35.4071H38.3732C39.4034 35.4071 40.409 35.7218 41.2554 36.3091C43.5493 37.9009 44.1185 41.0508 42.5268 43.3448L38.7326 48.8126C37.7082 50.289 37.5548 52.2015 38.3308 53.8223L39.5946 56.4621C41.2278 59.8731 45.9104 60.3062 48.1416 57.2526L50.324 54.2657C51.8081 52.2345 52.608 49.7839 52.608 47.2682C52.608 40.7175 47.2976 35.4071 40.7469 35.4071ZM39.198 34.6614H41.5717C40.5415 34.6614 39.5359 34.3467 38.6895 33.7594C36.3956 32.1677 35.8264 29.0177 37.4181 26.7237L41.2123 21.2559C42.2368 19.7795 42.3902 17.867 41.6142 16.2462L40.3503 13.6065C38.7171 10.1954 34.0345 9.76227 31.8034 12.8159L29.621 15.8028C28.1368 17.8341 27.3369 20.2846 27.3369 22.8003C27.3369 29.351 32.6473 34.6614 39.198 34.6614Z" fill="#8160AD"/>
        <defs>
        <filter id="filter0_d_1633_2" x="0" y="0" width="78" height="90" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
        <feFlood flood-opacity="0" result="BackgroundImageFix"/>
        <feColorMatrix in="SourceAlpha" type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0" result="hardAlpha"/>
        <feOffset dy="16"/>
        <feGaussianBlur stdDeviation="2"/>
        <feColorMatrix type="matrix" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.202005 0"/>
        <feBlend mode="normal" in2="BackgroundImageFix" result="effect1_dropShadow_1633_2"/>
        <feBlend mode="normal" in="SourceGraphic" in2="effect1_dropShadow_1633_2" result="shape"/>
        </filter>
        </defs>
        </svg>

    ''',
    width: width,
    height: height,
    color: color,
  );
}