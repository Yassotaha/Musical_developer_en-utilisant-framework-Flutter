import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

/*/* CSS HEX */
--russian-violet: #3c1642ff;
--lavender-blush: #f5e6e8ff;
--languid-lavender: #d5c6e0ff;
--blue-bell: #aaa1c8ff;
--purple-mountain-majesty: #967aa1ff;

/* CSS HSL */
--russian-violet: hsla(292, 50%, 17%, 1);
--lavender-blush: hsla(352, 43%, 93%, 1);
--languid-lavender: hsla(275, 30%, 83%, 1);
--blue-bell: hsla(254, 26%, 71%, 1);
--purple-mountain-majesty: hsla(283, 17%, 55%, 1);

/* SCSS HEX */
$russian-violet: #3c1642ff;
$lavender-blush: #f5e6e8ff;
$languid-lavender: #d5c6e0ff;
$blue-bell: #aaa1c8ff;
$purple-mountain-majesty: #967aa1ff;

/* SCSS HSL */
$russian-violet: hsla(292, 50%, 17%, 1);
$lavender-blush: hsla(352, 43%, 93%, 1);
$languid-lavender: hsla(275, 30%, 83%, 1);
$blue-bell: hsla(254, 26%, 71%, 1);
$purple-mountain-majesty: hsla(283, 17%, 55%, 1);

/* SCSS RGB */
$russian-violet: rgba(60, 22, 66, 1);
$lavender-blush: rgba(245, 230, 232, 1);
$languid-lavender: rgba(213, 198, 224, 1);
$blue-bell: rgba(170, 161, 200, 1);
$purple-mountain-majesty: rgba(150, 122, 161, 1);

/* SCSS Gradient */
$gradient-top: linear-gradient(0deg, #3c1642ff, #f5e6e8ff, #d5c6e0ff, #aaa1c8ff, #967aa1ff);
$gradient-right: linear-gradient(90deg, #3c1642ff, #f5e6e8ff, #d5c6e0ff, #aaa1c8ff, #967aa1ff);
$gradient-bottom: linear-gradient(180deg, #3c1642ff, #f5e6e8ff, #d5c6e0ff, #aaa1c8ff, #967aa1ff);
$gradient-left: linear-gradient(270deg, #3c1642ff, #f5e6e8ff, #d5c6e0ff, #aaa1c8ff, #967aa1ff);
$gradient-top-right: linear-gradient(45deg, #3c1642ff, #f5e6e8ff, #d5c6e0ff, #aaa1c8ff, #967aa1ff);
$gradient-bottom-right: linear-gradient(135deg, #3c1642ff, #f5e6e8ff, #d5c6e0ff, #aaa1c8ff, #967aa1ff);
$gradient-top-left: linear-gradient(225deg, #3c1642ff, #f5e6e8ff, #d5c6e0ff, #aaa1c8ff, #967aa1ff);
$gradient-bottom-left: linear-gradient(315deg, #3c1642ff, #f5e6e8ff, #d5c6e0ff, #aaa1c8ff, #967aa1ff);
$gradient-radial: radial-gradient(#3c1642ff, #f5e6e8ff, #d5c6e0ff, #aaa1c8ff, #967aa1ff);
*/

mixin MusicalColors {
  static const Color russianCioletColor = Color(0x3c1642ff);
  static const Color lavenderBlush = Color(0xf5e6e8ff);
  static const Color languidLavender = Color(0xd5c6e0ff);
  static const Color blueBell = Color(0xaaa1c8ff);
  static const Color purpleMountainMajesty = Color(0x967aa1ff);
}
