import 'package:ecom_user_app/auth/firebase_auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showMessage(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

void showEmailVerificationWarningDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Email Not Verified'),
            content: Text('You are using an unverified email address.'
                ' Please click send button to get a confirmation link in your email inbox'),
            actions: [
              TextButton(
                child: Text('cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: Text('Send'),
                onPressed: () async {
                  await FirebaseAuthService.sendVerificationMail();
                  showMessage(context, 'Email Sent.');
                  Navigator.pop(context);
                },
              )
            ],
          ));
}
