import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

class Utils {
  static DeviceType getDeviceType(context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1024) {
      return DeviceType.desktop;
    } else if (width >= 500) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }
}
