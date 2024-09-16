import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'otp_verification.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isPhoneSelected = true;
  bool isLoading = false;

  // Static mobile number and deviceId for API call
  final String staticMobileNumber = "9011470243";
  final String staticDeviceId = "62b341aeb0ab5ebe28a758a3";
  final String staticotp = "9879";




  Future<void> sendOtp() async {
    setState(() {
      isLoading = true;
    });

    final url = 'http://devapiv4.dealsdray.com/api/v2/user/otp';

    final otpData = {
      "mobileNumber": staticMobileNumber,
      "deviceId": staticDeviceId,
      "otp":staticotp,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(otpData),
      );

      if (response.statusCode == 200) {
        print('OTP sent to $staticMobileNumber');
        // Navigate to OTP verification screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreen(
              phoneNumber: staticMobileNumber,
            ),
          ),
        );
      } else {
        // Handle error
        print('Failed to send OTP: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send OTP, please try again')),
        );
      }
    } catch (e) {
      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void loginWithEmail() {
    String email = emailController.text.trim();
    print('Logging in with Email: $email');
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo at the top
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'images/logo.png',
                    height: 150,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // App welcome text
              Text(
                "Glad to see you!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPhoneSelected = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        color: isPhoneSelected ? Colors.red : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Phone",
                        style: TextStyle(
                          color: isPhoneSelected ? Colors.white : Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPhoneSelected = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        color: isPhoneSelected ? Colors.grey[300] : Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Email",
                        style: TextStyle(
                          color: isPhoneSelected ? Colors.black : Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              Text(
                "Please provide your ${isPhoneSelected ? 'phone number' : 'email address'}",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              SizedBox(height: 20),

              if (isPhoneSelected)
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone",
                    border: OutlineInputBorder(),
                  ),
                )
              else
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              SizedBox(height: 40),

              ElevatedButton(
                onPressed: isPhoneSelected ? (isLoading ? null : sendOtp) : (isLoading ? null : loginWithEmail),
                child: isLoading
                    ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : Text(isPhoneSelected ? "Send OTP" : "Login with Email"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 40),

              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(
                    color: Colors.blue, // Link color
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
