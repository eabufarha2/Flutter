import 'package:flutter/material.dart';

class OutputScreen extends StatelessWidget {
  final String? username;
  final String? password;
  final String? email;
  final bool? rememberMe;
  final String? gender;
  final String? country;
  final double? age;
  final DateTime? selectedDate;

  const OutputScreen({
    super.key,
    this.username,
    this.password,
    this.email,
    this.rememberMe,
    this.gender,
    this.country,
    this.age,
    this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Output'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Username: $username'),
            Text('Password: $password'),
            Text('Email: $email'),
            Text('Remember Me: $rememberMe'),
            Text('Gender: $gender'),
            Text('Country: $country'),
            Text('Age: ${age?.round()}'),
            Text('Selected Date: ${selectedDate?.toLocal().toString().split(' ')[0] ?? 'Not selected'}'),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the form screen
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}