import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget ApproximateIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="8" height="5" viewBox="0 0 8 5" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M7.45 1.60001C7.05 2.05001 6.3 2.50001 5.5 2.50001C4.75 2.50001 4.3 2.25001 3.9 2.05001C3.5 1.90001 3.1 1.65001 2.45 1.65001C1.85 1.65001 1.3 2.00001 1 2.30001L0.5 1.55001C0.95 1.10001 1.65 0.600006 2.45 0.600006C3.2 0.600006 3.65 0.900006 4.05 1.05001C4.45 1.20001 4.85 1.50001 5.5 1.50001C6.1 1.50001 6.65 1.10001 6.95 0.800006L7.45 1.60001ZM7.5 4.05001C7.05 4.50001 6.35 5.00001 5.55 5.00001C4.8 5.00001 4.35 4.75001 3.95 4.55001C3.55 4.40001 3.15 4.10001 2.5 4.10001C1.9 4.10001 1.35 4.50001 1.05 4.80001L0.55 4.00001C1 3.55001 1.7 3.05001 2.5 3.05001C3.25 3.05001 3.7 3.30001 4.1 3.50001C4.5 3.65001 4.9 3.90001 5.55 3.90001C6.15 3.90001 6.7 3.50001 7 3.20001L7.5 4.05001Z" fill="black"/>
      </svg>
    ''',
    width: width,
    height: height,
  );
}

Widget WorldRemitIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="67" height="15" viewBox="0 0 67 15" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M17.981 4.19778H19.796L20.8118 8.31319L21.9872 4.19778H23.3134L24.4888 8.31319L25.5143 4.19778H27.3208L25.487 10.7302H23.7088L22.6553 7.04367L21.6019 10.7302H19.8242L17.981 4.19778ZM26.7143 8.39695C26.7143 7.00597 27.8334 5.93273 29.2255 5.93273C30.6271 5.93273 31.7366 7.00597 31.7366 8.39667C31.7366 9.78709 30.6268 10.8603 29.2255 10.8603C27.8429 10.8603 26.7143 9.78737 26.7143 8.39667V8.39695ZM30.1753 8.39695C30.1753 7.81817 29.771 7.42617 29.2255 7.42617C28.6894 7.42617 28.2848 7.81817 28.2848 8.39667C28.2848 8.97517 28.6891 9.36717 29.2255 9.36717C29.7708 9.36717 30.1753 8.97545 30.1753 8.39667V8.39695ZM35.1669 5.97014V7.68722C34.5462 7.59425 33.7563 7.87429 33.7563 8.79816V10.7299H32.195V6.06339H33.7563V6.93143C33.9442 6.2968 34.537 5.97014 35.1671 5.97014H35.1669ZM35.6069 3.9169H37.1682V10.7291H35.6069V3.9169ZM42.6254 4.19778V10.7305H41.0641V10.3011C40.7632 10.6557 40.3304 10.8612 39.7284 10.8612C38.4681 10.8612 37.5183 9.79742 37.5183 8.39723C37.5183 6.99732 38.4681 5.93329 39.7284 5.93329C40.3304 5.93329 40.7632 6.13878 41.0641 6.49336V4.19778H42.6254ZM41.0641 8.39695C41.0641 7.79053 40.6598 7.37954 40.0766 7.37954C39.4931 7.37954 39.0891 7.79025 39.0891 8.39695C39.0891 9.00393 39.4933 9.41436 40.0766 9.41436C40.6598 9.41436 41.0641 9.00309 41.0641 8.39639V8.39695ZM45.9647 8.62059H45.3627V10.7297H43.68V4.19778H46.3125C47.6482 4.19778 48.6827 5.14036 48.6827 6.45651C48.6827 7.25893 48.2407 7.94018 47.5636 8.31431L48.9178 10.7313H47.1124L45.9647 8.62087V8.62059ZM45.3627 7.20281H46.2936C46.7076 7.21202 46.9991 6.91356 46.9991 6.47493C46.9991 6.04552 46.7076 5.73757 46.2936 5.73757H45.3627V7.20281Z" fill="#604684"/>
      <path d="M51.3718 9.53525C51.7104 9.53525 52.0019 9.42329 52.2275 9.20914L53.3563 9.99342C52.8861 10.5814 52.1711 10.8612 51.3341 10.8612C49.7069 10.8612 48.7006 9.78793 48.7006 8.407C48.7006 7.00681 49.7351 5.93357 51.2023 5.93357C52.6131 5.93357 53.6288 6.98811 53.6288 8.38802C53.6302 8.58279 53.6082 8.77702 53.5632 8.96652H50.3183C50.5065 9.41408 50.9203 9.53525 51.3718 9.53525ZM52.1049 7.89272C51.9639 7.40747 51.5968 7.23939 51.221 7.23939C50.7695 7.23939 50.4309 7.46358 50.2991 7.89272H52.1049ZM61.33 7.87401V10.7299H59.7595V8.0513C59.7595 7.65009 59.5713 7.39797 59.1765 7.39797C58.7346 7.39797 58.5274 7.71542 58.5274 8.18197V10.7299H56.9664V8.0513C56.9664 7.65009 56.7693 7.39797 56.3736 7.39797C55.9412 7.39797 55.7248 7.71542 55.7248 8.18197V10.7299H54.1638V6.0634H55.7248V6.50202C55.9788 6.16614 56.3926 5.93273 56.9946 5.93273C57.5496 5.93273 57.9444 6.14743 58.1985 6.53022C58.49 6.17563 58.9132 5.93273 59.5615 5.93273C60.6434 5.93273 61.33 6.66088 61.33 7.87401ZM61.8002 5.10909C61.5159 4.37144 62.2636 3.66618 62.9991 3.97107C63.2168 4.06153 63.3888 4.23435 63.4779 4.45129C63.775 5.18838 63.0161 5.92687 62.2734 5.60216C62.0567 5.50681 61.8866 5.32953 61.8002 5.10909ZM61.8608 6.0634H63.4221V10.7297H61.8605V6.0634H61.8608ZM66.022 7.54734V8.90007C66.022 9.33842 66.3699 9.36661 67 9.32948V10.7294C65.0813 10.9625 64.4607 10.3748 64.4607 8.93665V7.54734H63.9174V6.0634H64.4607V5.2244L66.022 4.75785V6.06451H67V7.54818L66.022 7.54734ZM8.3601 0L2.8269 1.52304L0 6.48275L1.53504 11.9729L6.53301 14.7784L12.0662 13.255L14.8934 8.2956L13.3581 2.80513L8.3601 0Z" fill="#604684"/>
      <path opacity="0.7" d="M6.53921 4.9301L6.4965 4.92815L5.777 7.02243L5.68989 7.27678C5.66197 7.35719 5.66197 7.4443 5.68989 7.52499L6.39068 9.56511C6.42725 9.67232 6.5099 9.75776 6.61627 9.79908L6.75168 9.84794L7.47426 7.74556L7.57281 7.45882C7.60015 7.37959 7.60015 7.29348 7.57281 7.21424L6.87286 5.18445C6.84828 5.11406 6.80355 5.05244 6.74423 5.00727C6.6849 4.96209 6.61361 4.93536 6.53921 4.93038V4.9301ZM11.4973 4.79022H9.98231C9.93995 4.79011 9.89861 4.80323 9.86407 4.82776C9.82953 4.85229 9.80351 4.887 9.78966 4.92703L9.08608 6.97497L9.02828 7.14416C8.98613 7.26673 8.98613 7.39963 9.02828 7.52192L9.78687 9.73039C9.80031 9.76916 9.82612 9.80243 9.86033 9.82508C9.89453 9.84773 9.93524 9.85851 9.97617 9.85576C9.99823 9.85436 10.0214 9.85073 10.044 9.84905L11.6899 5.05798C11.7004 5.02752 11.7035 4.99497 11.6987 4.96309C11.694 4.93121 11.6817 4.90093 11.6628 4.87482C11.6439 4.8486 11.619 4.82725 11.5902 4.81254C11.5615 4.79783 11.5296 4.79018 11.4973 4.79022Z" fill="white"/>
      <path d="M6.55749 9.98785H5.04283C5.00046 9.98796 4.95912 9.97484 4.92458 9.95031C4.89004 9.92578 4.86403 9.89108 4.85018 9.85104L3.20374 5.05745C3.19331 5.02707 3.19033 4.99463 3.19504 4.96285C3.19976 4.93108 3.21202 4.9009 3.23082 4.87485C3.24973 4.84863 3.2746 4.82728 3.30339 4.81257C3.33218 4.79786 3.36405 4.79021 3.39638 4.79025H4.91105C4.99816 4.79025 5.07577 4.84526 5.10369 4.92706L6.75014 9.72093C6.77136 9.78236 6.76131 9.85048 6.72306 9.90325C6.70415 9.92947 6.67927 9.95082 6.65048 9.96553C6.62169 9.98024 6.58982 9.98789 6.55749 9.98785ZM9.85066 9.98785H8.33628C8.29391 9.98796 8.25257 9.97484 8.21803 9.95031C8.18349 9.92578 8.15748 9.89108 8.14363 9.85104L6.4969 5.05745C6.48648 5.02707 6.4835 4.99463 6.48821 4.96285C6.49292 4.93108 6.50519 4.9009 6.52399 4.87485C6.5429 4.84863 6.56777 4.82728 6.59656 4.81257C6.62535 4.79786 6.65722 4.79021 6.68955 4.79025H8.20505C8.29216 4.79025 8.36978 4.84526 8.3977 4.92706L10.0441 9.72093C10.0545 9.75134 10.0575 9.78379 10.0527 9.81556C10.0479 9.84734 10.0356 9.8775 10.0168 9.90353C9.99779 9.92978 9.97281 9.95112 9.94392 9.96578C9.91503 9.98044 9.88306 9.98801 9.85066 9.98785Z" fill="white"/>
      </svg>
    ''',
    width: width,
    height: height,
  );
}

Widget TransferWiseIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="62" height="11" viewBox="0 0 62 11" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M1.02937 0L2.40187 2.2963L0 4.5662H4.1175L4.51341 3.6688H2.24351L3.61601 2.2963L2.82418 0.923798H6.57216L3.27288 8.73649H4.40784L8.10303 0H1.02937Z" fill="#00B9FF"/>
      <path d="M52.102 5.35803H51.1519V10.3465H52.102V5.35803Z" fill="#37517E"/>
      <path d="M52.1549 3.66882H51.1255V4.6718H52.1549V3.66882Z" fill="#37517E"/>
      <path d="M49.542 3.66882L48.3806 8.86848H48.3278L47.1137 5.35805H46.2691L44.8966 8.86848H44.8438L43.92 3.66882H42.8906L44.1839 10.3466H45.1077L46.6122 6.65137H46.665L47.9583 10.3466H48.9085L50.5186 3.66882H49.542Z" fill="#37517E"/>
      <path d="M36.4503 9.60752C35.5265 9.60752 34.9195 8.89487 34.9195 7.83911C34.9195 6.86252 35.4737 6.0443 36.3447 6.0443C37.3477 6.0443 37.6381 6.88891 37.6645 7.4168H35.896L35.5793 8.18223H38.6146C38.641 7.97108 38.641 7.91829 38.641 7.83911C38.641 6.41382 37.902 5.25247 36.3447 5.25247C34.9986 5.25247 33.9429 6.36103 33.9429 7.8655C33.9429 9.42276 34.9459 10.4521 36.3711 10.4521C37.163 10.4785 37.902 10.1618 38.4299 9.60752L37.8492 9.05324C37.4797 9.39636 36.9782 9.63391 36.4503 9.60752Z" fill="#37517E"/>
      <path d="M32.7023 5.25245C32.7023 4.64538 32.9926 4.27587 33.5733 4.27587C33.8636 4.27587 34.1276 4.32865 34.3915 4.43423L34.6818 3.74798C34.3123 3.58962 33.9164 3.48404 33.5205 3.48404C32.5703 3.48404 31.7257 3.95914 31.7257 5.25245V5.41082H31.145V6.20264H31.7785V10.3465H32.7287V6.20264H33.6789L33.9956 5.41082H32.7023V5.25245Z" fill="#37517E"/>
      <path d="M24.2037 5.25244C23.623 5.19965 23.0423 5.48999 22.7256 5.96509H22.6728V5.33162H21.7754V10.3201H22.7256V7.65432C22.7256 6.67773 23.2271 6.07066 24.0189 6.07066C24.7579 6.07066 25.2066 6.46658 25.2066 7.39037V10.3465H26.1304V7.20561C26.1304 5.93869 25.3914 5.25244 24.2037 5.25244Z" fill="#37517E"/>
      <path d="M19.7427 8.41978C19.7427 9.15882 19.1356 9.63391 18.2646 9.63391C17.7632 9.63391 17.3144 9.39636 17.3144 8.7893C17.3144 8.23502 17.7632 7.8655 18.4758 7.8655C19.1093 7.8655 19.5052 7.97108 19.7427 8.15584V8.41978ZM18.423 5.25247C17.9215 5.25247 17.42 5.33165 16.9449 5.49002L17.1033 6.25545C17.4992 6.12348 17.8951 6.07069 18.291 6.0443C19.0829 6.0443 19.7427 6.41382 19.7427 7.23204V7.3904C19.3468 7.23204 18.9245 7.15286 18.5022 7.17925C17.2089 7.17925 16.3643 7.81271 16.3643 8.86848C16.3643 9.97704 17.1825 10.4521 18.1063 10.4521C18.7133 10.5049 19.294 10.241 19.6899 9.76588H19.7427V10.3466H20.6665V7.23204C20.6665 5.85954 19.7955 5.25247 18.423 5.25247Z" fill="#37517E"/>
      <path d="M8.10303 3.66882V4.56623H10.2146V10.3466H11.2175V4.56623H13.3027V3.66882H8.10303Z" fill="#37517E"/>
      <path d="M16.4173 5.43719C16.1533 5.33161 15.8894 5.27882 15.599 5.30522C15.0975 5.27882 14.5961 5.48998 14.2793 5.88589H14.2265V5.33161H13.3027V10.3201H14.2529V7.62791C14.2529 6.57214 14.7544 6.14983 15.5198 6.14983C15.731 6.14983 15.9685 6.17623 16.1797 6.22902L16.4173 5.43719Z" fill="#37517E"/>
      <path d="M42.6531 5.46361C42.3892 5.35804 42.1253 5.30525 41.8349 5.30525C41.307 5.27885 40.8056 5.49001 40.4624 5.88592H40.4096V5.33164H39.4858V10.3201H40.436V7.62794C40.436 6.57217 41.0167 6.14986 41.7557 6.14986C41.9669 6.14986 42.2044 6.17626 42.4156 6.22905L42.6531 5.46361Z" fill="#37517E"/>
      <path d="M59.8092 9.60752C58.8854 9.60752 58.2783 8.89487 58.2783 7.83911C58.2783 6.86252 58.8326 6.0443 59.7036 6.0443C60.7066 6.0443 60.9969 6.88891 61.0233 7.4168H59.2813L58.9646 8.18223H61.9999C61.9999 7.97108 61.9999 7.91829 61.9999 7.83911C61.9999 6.41382 61.2609 5.25247 59.7036 5.25247C58.3575 5.25247 57.3018 6.36103 57.3018 7.8655C57.3018 9.42276 58.3047 10.4521 59.73 10.4521C60.5219 10.4785 61.2609 10.1618 61.7888 9.60752L61.2081 9.05324C60.865 9.39636 60.3635 9.63391 59.8092 9.60752Z" fill="#37517E"/>
      <path d="M29.0071 7.46956C28.2681 7.36399 27.8458 7.23202 27.8458 6.75692C27.8458 6.30822 28.2681 6.04428 28.7959 6.04428C29.271 6.04428 29.7197 6.20264 30.1157 6.46658L30.5644 5.78033C30.0629 5.41082 29.4294 5.22606 28.8223 5.25245C27.7138 5.25245 26.922 5.91231 26.922 6.78332C26.922 7.7863 27.5554 8.10303 28.664 8.28779C29.271 8.39336 29.7989 8.44615 29.7989 8.97404C29.7989 9.42274 29.3766 9.66028 28.7959 9.66028C28.2417 9.66028 27.6874 9.47553 27.2651 9.1324L26.8428 9.87144C27.2123 10.1882 27.9513 10.4521 28.7696 10.4521C29.9045 10.4521 30.7491 9.79226 30.7491 8.89485C30.7227 7.83908 29.8781 7.57514 29.0071 7.46956Z" fill="#37517E"/>
      <path d="M55.0848 7.46956C54.3457 7.36399 53.9234 7.23202 53.9234 6.75692C53.9234 6.30822 54.3457 6.04428 54.8736 6.04428C55.3487 6.04428 55.7974 6.20264 56.1933 6.46658L56.642 5.78033C56.1405 5.41082 55.5071 5.22606 54.9 5.25245C53.7914 5.25245 52.9996 5.91231 52.9996 6.78332C52.9996 7.7863 53.6331 8.10303 54.7152 8.28779C55.3223 8.39336 55.8502 8.44615 55.8502 8.97404C55.8502 9.42274 55.4279 9.66028 54.8472 9.66028C54.2929 9.66028 53.7387 9.47553 53.3164 9.1324L52.894 9.87144C53.2636 10.1882 54.0026 10.4521 54.8208 10.4521C55.9558 10.4521 56.8004 9.79226 56.8004 8.89485C56.8004 7.83908 55.9294 7.57514 55.0848 7.46956Z" fill="#37517E"/>
      </svg>
    ''',
    width: width,
    height: height,
  );
}

Widget AzimoIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="46" height="14" viewBox="0 0 46 14" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M44.4775 0H1.23549C0.553146 0 0 0.522335 0 1.16667V12.8333C0 13.4777 0.553146 14 1.23549 14H44.4775C45.1599 14 45.713 13.4777 45.713 12.8333V1.16667C45.713 0.522335 45.1599 0 44.4775 0Z" fill="#1FD3C6"/>
      <path d="M13.0132 10.4548C12.502 10.4548 12.2152 10.1194 12.2152 10.1194C11.4302 9.2957 12.7053 8.07215 12.7053 8.07215L15.0442 5.4965C15.1513 5.37595 15.2506 5.26347 15.3349 5.16646L12.6029 5.16667C12.1499 5.16667 11.7808 4.80111 11.7808 4.35146C11.7808 3.90181 12.1499 3.53577 12.6029 3.53577H14.9421C14.9974 3.54708 15.0503 3.5597 15.1004 3.57357C15.0483 3.55894 14.9954 3.54632 14.9421 3.53577H16.5333C17.0445 3.53577 17.3314 3.87118 17.3314 3.87118C18.1165 4.69441 16.8414 5.91868 16.8414 5.91868L14.2512 8.7792C14.1848 8.85552 14.1251 8.92358 14.0775 8.98045C14.1161 8.93525 14.1611 8.88226 14.2129 8.82417L16.9448 8.82344C17.3979 8.82344 17.7659 9.18972 17.7659 9.63938C17.7659 10.089 17.3979 10.4546 16.9448 10.4548H13.0132Z" fill="white"/>
      <path d="M21.1219 7.46109L21.1231 9.59074C21.122 10.0684 20.7111 10.4549 20.2053 10.4541C19.9622 10.4547 19.7289 10.3641 19.5567 10.2021C19.3845 10.0402 19.2875 9.82024 19.2872 9.59074C19.2871 9.58559 19.2871 9.58046 19.2871 9.57533L19.2874 4.39883C19.2878 4.16939 19.3848 3.9495 19.5569 3.78758C19.7291 3.62566 19.9623 3.53498 20.2053 3.53549C20.7034 3.53498 21.1107 3.91056 21.1219 4.38084V7.46109Z" fill="white"/>
      <path d="M28.8158 3.87421C29.485 3.53137 30.1859 3.53144 30.2645 3.5338C31.9659 3.53428 33.3512 4.83414 33.3556 6.43345C33.3556 6.43661 33.3563 6.43928 33.3563 6.44171V9.5781C33.3552 10.0633 32.9381 10.4558 32.4243 10.4553H32.4202C32.1743 10.4553 31.9384 10.363 31.7645 10.1988C31.5907 10.0345 31.493 9.81179 31.4931 9.57956V9.51393L31.4941 6.44171C31.4941 6.43904 31.4931 6.43661 31.4931 6.43345L31.4935 6.43785L31.4938 6.44171C31.4918 5.80588 30.942 5.28768 30.2653 5.28768C29.5899 5.28768 29.0401 5.80442 29.0386 6.43977V6.43772V6.43345C29.0373 6.05765 28.9586 5.68975 28.8112 5.34864L28.8438 5.42785C28.9701 5.74642 29.0371 6.08657 29.0383 6.43345V9.5781C29.0383 9.63935 29.0321 9.69938 29.0195 9.75674C28.9293 10.1645 28.5482 10.4563 28.1071 10.4553C27.9802 10.4553 27.8587 10.431 27.749 10.3877H27.7475C27.7472 10.3872 27.7462 10.3872 27.7462 10.3872C27.4077 10.2546 27.1838 9.94596 27.175 9.59997L27.1753 9.52974C27.1761 9.06413 27.1763 6.44171 27.1763 6.44171H27.1738C27.1738 5.80564 26.6234 5.28793 25.9475 5.28793C25.2703 5.28793 24.7203 5.80588 24.7203 6.44171V9.5781C24.7193 10.0634 24.3019 10.4561 23.788 10.4553C23.2741 10.456 22.8567 10.0634 22.8555 9.5781V6.44171C22.8555 5.35525 23.4943 4.40636 24.4359 3.90737C24.4359 3.90737 24.7628 3.7156 25.2487 3.60939C25.982 3.44873 27.1524 3.48932 28.1058 4.36334H28.106L28.1906 4.28872C28.3626 4.14249 28.5512 4.01458 28.7531 3.90737L28.8158 3.87421Z" fill="white"/>
      <path d="M38.4218 3.5C40.4706 3.5 42.1367 5.06747 42.1367 6.99441C42.1367 7.09941 42.1316 7.20247 42.1231 7.30504C42.119 7.34125 42.1149 7.37625 42.1102 7.41101C42.11 7.41207 42.1098 7.41313 42.1096 7.41419C41.8897 9.1443 40.3195 10.4903 38.4218 10.4903C36.3732 10.4903 34.7061 8.92208 34.7061 6.99514C34.7061 6.90399 34.7112 6.81406 34.7189 6.72413C34.7194 6.72064 34.7198 6.71715 34.7203 6.71366C34.8717 4.9177 36.4734 3.5 38.4218 3.5ZM40.2327 6.57371L40.2444 6.64101C40.063 5.82716 39.3025 5.24465 38.4218 5.2449C37.3945 5.2449 36.5601 6.02924 36.5601 6.99514C36.56 7.17497 36.5895 7.35373 36.6476 7.525C36.6922 7.70748 36.7563 7.88184 36.8375 8.04629C36.7563 7.88178 36.6922 7.70734 36.6476 7.52476C36.8953 8.25257 37.6122 8.74613 38.4218 8.74611C39.4478 8.74611 40.2833 7.9608 40.2833 6.99441C40.2833 6.87385 40.2701 6.75524 40.2444 6.64101L40.2327 6.57371Z" fill="white"/>
      <path d="M6.00051 3.97504C5.95648 4.00011 5.92447 4.02858 5.9055 4.04785C5.95209 3.98781 6.26817 3.5 7.2285 3.5C7.71755 3.5 8.34559 3.6349 8.64159 4.22406L8.69487 4.33271L10.8078 9.42254C10.8346 9.50761 10.8547 9.56132 10.8572 9.68747C10.865 10.1405 10.4426 10.4959 9.98853 10.4883C9.42947 10.4784 9.2287 10.0598 9.2287 10.0598L9.18151 9.94583L9.22793 10.0579C9.18495 9.98643 8.97517 9.55403 8.24855 9.17972C7.60558 8.84844 6.77292 8.88806 6.17113 9.19042C5.59102 9.48134 5.41925 9.78115 5.20545 10.0839L5.20411 10.0868C5.19767 10.1028 5.15906 10.1485 5.15906 10.1485C5.02496 10.3323 4.80437 10.4453 4.56423 10.4815C4.53248 10.4863 4.50129 10.489 4.47083 10.4899L4.42563 10.4899C4.1584 10.4824 3.95832 10.3447 3.95832 10.3447C3.34341 9.91059 3.67133 9.33285 3.67133 9.33285L5.75956 4.30767C5.8445 4.10472 5.9055 4.04809 5.9055 4.04809C5.9221 4.03118 5.94868 4.00724 5.98456 3.98469L6.00051 3.97504ZM6.87885 4.43661L6.91073 4.49462L6.94666 4.56677L7.22181 5.2291L6.27308 7.51319C7.22277 7.30348 8.02483 7.47939 8.17082 7.51358L9.03866 9.6024L6.94691 4.56677C6.92417 4.51895 6.90154 4.47601 6.87885 4.43661Z" fill="white"/>
      </svg>
    ''',
    width: width,
    height: height,
  );
}

Widget FilterIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="12" height="8" viewBox="0 0 12 8" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M2 4.66667H10V3.33333H2V4.66667ZM0 0V1.33333H12V0H0ZM4.66667 8H7.33333V6.66667H4.66667V8Z" fill="#303030" fill-opacity="0.8"/>
      </svg>
    ''',
    width: width,
    height: height,
  );
}

Widget OfferEyeIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="17" height="11" viewBox="0 0 17 11" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M8.50016 3.375C7.93658 3.375 7.39608 3.59888 6.99756 3.9974C6.59905 4.39591 6.37516 4.93641 6.37516 5.5C6.37516 6.06358 6.59905 6.60409 6.99756 7.0026C7.39608 7.40112 7.93658 7.625 8.50016 7.625C9.06375 7.625 9.60425 7.40112 10.0028 7.0026C10.4013 6.60409 10.6252 6.06358 10.6252 5.5C10.6252 4.93641 10.4013 4.39591 10.0028 3.9974C9.60425 3.59888 9.06375 3.375 8.50016 3.375ZM8.50016 9.04167C7.56085 9.04167 6.66002 8.66853 5.99583 8.00434C5.33163 7.34015 4.9585 6.43931 4.9585 5.5C4.9585 4.56069 5.33163 3.65985 5.99583 2.99566C6.66002 2.33147 7.56085 1.95833 8.50016 1.95833C9.43947 1.95833 10.3403 2.33147 11.0045 2.99566C11.6687 3.65985 12.0418 4.56069 12.0418 5.5C12.0418 6.43931 11.6687 7.34015 11.0045 8.00434C10.3403 8.66853 9.43947 9.04167 8.50016 9.04167ZM8.50016 0.1875C4.9585 0.1875 1.93391 2.39042 0.708496 5.5C1.93391 8.60958 4.9585 10.8125 8.50016 10.8125C12.0418 10.8125 15.0664 8.60958 16.2918 5.5C15.0664 2.39042 12.0418 0.1875 8.50016 0.1875Z" fill="#303030" fill-opacity="0.8"/>
      </svg>
    ''',
    width: width,
    height: height,
  );
}

Widget AppoxIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="14" height="9" viewBox="0 0 14 9" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M13.9 2.19995C13.1 3.09995 11.6 3.99995 10 3.99995C8.5 3.99995 7.6 3.49995 6.8 3.09995C6 2.79995 5.2 2.29995 3.9 2.29995C2.7 2.29995 1.6 2.99995 1 3.59995L0 2.09995C0.9 1.19995 2.3 0.199951 3.9 0.199951C5.4 0.199951 6.3 0.799952 7.1 1.09995C7.9 1.39995 8.7 1.99995 10 1.99995C11.2 1.99995 12.3 1.19995 12.9 0.599951L13.9 2.19995ZM14 7.09995C13.1 7.99995 11.7 8.99995 10.1 8.99995C8.6 8.99995 7.7 8.49995 6.9 8.09995C6.1 7.79995 5.3 7.19995 4 7.19995C2.8 7.19995 1.7 7.99995 1.1 8.59995L0.0999999 6.99995C1 6.09995 2.4 5.09995 4 5.09995C5.5 5.09995 6.4 5.59995 7.2 5.99995C8 6.29995 8.8 6.79995 10.1 6.79995C11.3 6.79995 12.4 5.99995 13 5.39995L14 7.09995Z" fill="#303030" fill-opacity="0.8"/>
      </svg>
    ''',
    width: width,
    height: height,
  );
}

Widget ClockIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="13" height="14" viewBox="0 0 13 14" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M6.50004 1.58337C5.78871 1.58337 5.08435 1.72348 4.42717 1.99569C3.76999 2.26791 3.17286 2.6669 2.66988 3.16988C1.65406 4.1857 1.08337 5.56345 1.08337 7.00004C1.08337 8.43663 1.65406 9.81438 2.66988 10.8302C3.17286 11.3332 3.76999 11.7322 4.42717 12.0044C5.08435 12.2766 5.78871 12.4167 6.50004 12.4167C7.93663 12.4167 9.31438 11.846 10.3302 10.8302C11.346 9.81438 11.9167 8.43663 11.9167 7.00004C11.9167 6.28871 11.7766 5.58435 11.5044 4.92717C11.2322 4.26999 10.8332 3.67286 10.3302 3.16988C9.82722 2.6669 9.23009 2.26791 8.57291 1.99569C7.91573 1.72348 7.21137 1.58337 6.50004 1.58337ZM8.77504 9.27504L5.95837 7.54171V4.29171H6.77087V7.10837L9.20837 8.57087L8.77504 9.27504Z" fill="#303030" fill-opacity="0.5"/>
      </svg>
    ''',
    width: width,
    height: height,
  );
}

Widget NotiIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M6.58329 4.24996H5.41663V3.08329H6.58329V4.24996ZM6.58329 8.91663H5.41663V5.41663H6.58329V8.91663ZM5.99996 0.166626C5.23392 0.166626 4.47537 0.31751 3.76764 0.610662C3.05991 0.903815 2.41685 1.33349 1.87517 1.87517C0.781208 2.96913 0.166626 4.45286 0.166626 5.99996C0.166626 7.54706 0.781208 9.03079 1.87517 10.1247C2.41685 10.6664 3.05991 11.0961 3.76764 11.3893C4.47537 11.6824 5.23392 11.8333 5.99996 11.8333C7.54706 11.8333 9.03079 11.2187 10.1247 10.1247C11.2187 9.03079 11.8333 7.54706 11.8333 5.99996C11.8333 5.23392 11.6824 4.47537 11.3893 3.76764C11.0961 3.05991 10.6664 2.41685 10.1247 1.87517C9.58307 1.33349 8.94001 0.903815 8.23228 0.610662C7.52455 0.31751 6.766 0.166626 5.99996 0.166626Z" fill="#303030" fill-opacity="0.8"/>
      </svg>
    ''',
    width: width,
    height: height,
  );
}

Widget EllipseIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg">
      <circle cx="6" cy="6" r="4" fill="white"/>
      <circle cx="6" cy="6" r="5" stroke="#303030" stroke-opacity="0.8" stroke-width="2"/>
      </svg>
    ''',
    width: width,
    height: height,
  );
}

Widget RectIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="2" height="18" viewBox="0 0 2 18" fill="none" xmlns="http://www.w3.org/2000/svg">
      <rect width="2" height="18" rx="1" fill="#303030" fill-opacity="0.8"/>
      </svg>
    ''',
    width: width,
    height: height,
  );
}

Widget CurrencyIcon({double? width, double? height}) {
  return SvgPicture.string(
    '''
      <svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M12.9072 7C14.1613 5.4991 14.2044 4.30336 13.6929 3.5C13.3519 2.96625 12.426 2.11285 10.0575 2.35484C9.38627 0.954024 8.36376 0 7 0C5.63624 0 4.61373 0.954024 3.94247 2.35484C1.57589 2.11477 0.647753 2.96625 0.307125 3.5C-0.204755 4.30391 -0.161629 5.49855 1.09276 7C-0.161317 8.5009 -0.204442 9.69664 0.307125 10.5C1.21995 11.9312 3.48465 11.6916 3.94247 11.6452C4.61342 13.0457 5.63624 14 7 14C8.36376 14 9.38659 13.0457 10.0575 11.6452C10.515 11.6916 12.7797 11.9312 13.6929 10.5C14.2048 9.69609 14.1616 8.50145 12.9072 7ZM1.98058 9.625C1.85464 9.42785 1.97464 8.94687 2.44777 8.30457C2.66527 8.48312 2.89152 8.65703 3.13121 8.82902C3.18465 9.20391 3.25621 9.56949 3.34247 9.92496C2.57496 9.9493 2.09589 9.80547 1.98058 9.625ZM3.13121 5.17125C2.89184 5.34324 2.66558 5.51715 2.44777 5.6957C1.97495 5.05312 1.85495 4.57215 1.98058 4.375C2.08714 4.20711 2.49277 4.06137 3.16559 4.06137C3.21903 4.06137 3.28653 4.06957 3.3434 4.07148C3.2546 4.43523 3.18381 4.80216 3.13121 5.17125ZM7 1.75C7.29594 1.75 7.69376 2.11969 8.05814 2.76883C7.70844 2.87 7.35688 2.98758 7 3.12047C6.64312 2.98758 6.29156 2.87 5.94186 2.76883C6.30624 2.11969 6.70406 1.75 7 1.75ZM7 12.25C6.70406 12.25 6.30624 11.8803 5.94186 11.2312C6.29156 11.13 6.64312 11.0124 7 10.8795C7.35688 11.0124 7.70844 11.13 8.05814 11.2312C7.69376 11.8803 7.29594 12.25 7 12.25ZM8.95314 7.94801C8.11876 8.46973 7.51125 8.75 7 8.97285C6.48906 8.75027 5.88124 8.46945 5.04686 7.94801C4.98467 7.18813 4.98467 6.81215 5.04686 6.05227C5.8803 5.53137 6.48843 5.25055 7 5.02742C7.51219 5.25082 8.12064 5.53164 8.95314 6.05227C9.01502 6.81187 9.01533 7.18785 8.95314 7.94801ZM12.0194 9.625C11.9047 9.80602 11.4257 9.9482 10.6575 9.92441C10.7438 9.56895 10.8153 9.20336 10.8688 8.82902C11.1082 8.65703 11.3344 8.48312 11.5522 8.30457C12.025 8.94687 12.145 9.42785 12.0194 9.625ZM11.5522 5.69543C11.3347 5.51687 11.1085 5.34297 10.8688 5.17098C10.8161 4.80189 10.7453 4.43496 10.6566 4.07121C10.7135 4.0693 10.7807 4.06109 10.8344 4.06109C11.5069 4.06109 11.9129 4.20711 12.0194 4.37473C12.145 4.57215 12.025 5.05312 11.5522 5.69543ZM7 6.125C6.44781 6.125 5.99999 6.51684 5.99999 7C5.99999 7.48316 6.44781 7.875 7 7.875C7.55219 7.875 8.00001 7.48316 8.00001 7C8.00001 6.51684 7.55219 6.125 7 6.125Z" fill="#C4C4C4"/>
      </svg>
    ''',
    width: width,
    height: height,
  );
}




