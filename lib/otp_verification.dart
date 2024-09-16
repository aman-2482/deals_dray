import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  OtpVerificationScreen({required this.phoneNumber});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  String? _errorMessage;

  Future<void> verifyOtp() async {
    // Collect OTP from all boxes
    final otp = _controllers.map((controller) => controller.text).join();

    final deviceId = '62b43472c84bb6dac82e0504';
    final userId = '62b43547c84bb6dac82e0525';

    final url = Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/otp/verification');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'otp': otp,
          'deviceId': deviceId,
          'userId': userId,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['success'] == true) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('OTP Verified Successfully!')),
          );

          // Navigate to the home screen after the message is displayed
          await Future.delayed(Duration(seconds: 1)); // Delay to show the Snackbar
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          setState(() {
            _errorMessage = 'The OTP entered is incorrect';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to verify OTP: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
    }
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTP Verification")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("OTP Verification", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("We have sent an OTP to ${widget.phoneNumber}"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) => OtpBox(controller: _controllers[index], onChanged: (value) {
                if (value.isNotEmpty && index < 3) {
                  FocusScope.of(context).nextFocus();
                }
                if (value.isEmpty && index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              })),
            ),
            SizedBox(height: 20),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(_errorMessage!, style: TextStyle(color: Colors.red)),
              ),
            ElevatedButton(
              onPressed: () {

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Navigating to Home Screen!')),
                );


                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pushReplacementNamed(context, '/home');
                });
              },
              child: Text("VERIFY"),
            ),

          ],
        ),
      ),
    );
  }
}

class OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  OtpBox({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SizedBox(
        width: 50,
        height: 50,
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            counterText: "",
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
