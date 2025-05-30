// lib/main.dart
import 'package:flutter/material.dart';
import 'package:auth_project/OutputScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == OutputScreen.routeName) {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder:
                (ctx) => OutputScreen(
                  username: args['username'] as String?,
                  password: args['password'] as String?,
                  email: args['email'] as String?,
                  rememberMe: args['rememberMe'] as bool?,
                  gender: args['gender'] as String?,
                  country: args['country'] as String?,
                  age: args['age'] as double?,
                  selectedDate: args['selectedDate'] as DateTime?,
                ),
          );
        }
        // Fallback to home screen:
        return MaterialPageRoute(builder: (_) => const MyFormScreen());
      },
    );
  }
}

class MyFormScreen extends StatefulWidget {
  const MyFormScreen({super.key});

  @override
  State<MyFormScreen> createState() => _MyFormScreenState();
}

class _MyFormScreenState extends State<MyFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;
  String? _email;
  bool _rememberMe = false;
  String? _gender;
  String? _country;
  double _age = 18;
  DateTime? _selectedDate;

  final List<String> _countries = [
    'Palestine',
    'Jordan',
    'Egypt',
    'Syria',
    'Iraq',
  ];
  final List<String> _genders = ['Male', 'Female'];
 

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pushNamed(
        context,
        OutputScreen.routeName,
        arguments: {
          'username': _username,
          'password': _password,
          'email': _email,
          'rememberMe': _rememberMe,
          'gender': _gender,
          'country': _country,
          'age': _age,
          'selectedDate': _selectedDate,
        },
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Form Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (v) =>
                        (v == null || v.isEmpty)
                            ? 'Please enter your username'
                            : null,
                onSaved: (v) => _username = v,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (v.length < 6) return 'Password must be ≥ 6 characters';
                  return null;
                },
                onSaved: (v) => _password = v,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please enter your email';
                  if (!v.contains('@')) return 'Please enter a valid email';
                  return null;
                },
                onSaved: (v) => _email = v,
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Remember me'),
                value: _rememberMe,
                onChanged: (val) => setState(() => _rememberMe = val ?? false),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Gender:'),
                  const SizedBox(width: 10),
                  ..._genders.map(
                    (g) => Row(
                      children: [
                        Radio<String>(
                          value: g.toLowerCase(),
                          groupValue: _gender,
                          onChanged: (val) => setState(() => _gender = val),
                        ),
                        Text(g),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
                value: _country,
                items:
                    _countries
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                onChanged: (val) => setState(() => _country = val),
                validator:
                    (v) =>
                        (v == null || v.isEmpty)
                            ? 'Please select a country'
                            : null,
                onSaved: (v) => _country = v,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Age: '),
                  Expanded(
                    child: Slider(
                      value: _age,
                      min: 18,
                      max: 99,
                      divisions: 81,
                      label: _age.round().toString(),
                      onChanged: (v) => setState(() => _age = v),
                    ),
                  ),
                  Text(_age.round().toString()),
                ],
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Select Date',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'No date selected'
                            : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
