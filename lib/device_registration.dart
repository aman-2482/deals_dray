// device_registration.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeviceRegistration {
  Future<void> registerDevice() async {
    final url = 'http://devapiv4.dealsdray.com/api/v2/user/device/add';

    final deviceData = {
      "deviceType": "android",
      "deviceId": "C6179909526098",
      "deviceName": "Samsung-MT200",
      "deviceOSVersion": "2.3.6",
      "deviceIPAddress": "11.433.445.66",
      "lat": 9.9312,
      "long": 76.2673,
      "buyer_gcmid": "",
      "buyer_pemid": "",
      "app": {
        "version": "1.20.5",
        "installTimeStamp": "2022-02-10T12:33:30.696Z",
        "uninstallTimeStamp": "2022-02-10T12:33:30.696Z",
        "downloadTimeStamp": "2022-02-10T12:33:30.696Z"
      }
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(deviceData),
    );

    if (response.statusCode == 200) {
      print('Device registered successfully');
    } else {
      print('Failed to register device: ${response.body}');
    }
  }
}
