import 'package:flutter/material.dart';

class PaymentOptionScreen extends StatelessWidget {
  final Map<String, String> product;

  const PaymentOptionScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Payment Option'),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a payment option for "${product['name']}"',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Option 1 - Online Payment
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Redirecting to Online Payment Gateway...')),
                );
              },
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue),
                ),
                child: Row(
                  children: [
                    Icon(Icons.payment, size: screenWidth * 0.08, color: Colors.blue),
                    SizedBox(width: screenWidth * 0.04),
                    Expanded(
                      child: Text(
                        'Pay Online (UPI / Wallets)',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Option 2 - Meet-up & Decide
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Meet-up request sent to owner.')),
                );
              },
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green),
                ),
                child: Row(
                  children: [
                    Icon(Icons.handshake, size: screenWidth * 0.08, color: Colors.green),
                    SizedBox(width: screenWidth * 0.04),
                    Expanded(
                      child: Text(
                        'Meet-up & Decide (for same hostel/locality)',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
