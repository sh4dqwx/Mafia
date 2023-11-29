import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/registerViewModel.dart';

class Register extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Register> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _loginController = TextEditingController();
  bool _isRegistered = false;
  bool _showErrorMessage = false;
  bool _passwordsMismatch = false;

  @override
  Widget build(BuildContext context) {
    final RegisterViewModel = Provider.of<registerViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _loginController,
              decoration: InputDecoration(labelText: 'Login'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirm Password'),
            ),
            SizedBox(height: 16.0),
            if (_showErrorMessage || _passwordsMismatch)
              Text(
                _passwordsMismatch
                    ? 'Please make sure your password match.'
                    : 'Add login, password and email',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18.0,
                ),
              ),
            ElevatedButton(
              onPressed: () async {
                String login = _loginController.text;
                String email = _emailController.text;
                String password = _passwordController.text;
                String confirmPassword = _confirmPasswordController.text;

                if (email.isEmpty || password.isEmpty || login.isEmpty || confirmPassword.isEmpty) {
                  setState(() {
                    _showErrorMessage = true;
                    _passwordsMismatch = false; // Reset password mismatch error
                  });
                } else if (password == confirmPassword) {
                  await RegisterViewModel.createAccount(login, email, password, context);
                  
                  setState(() {
                    _showErrorMessage = false; // Reset error message
                    _passwordsMismatch = false; // Reset password mismatch error
                  });
                } else {
                  setState(() {
                    _passwordsMismatch = true;
                    _showErrorMessage = false; // Reset error message
                  });
                  print('Password mismatch');
                }
              },
              child: Text('Confirm'),
            ),
            SizedBox(height: 16.0),
            if (RegisterViewModel.isRegistered)
              Text(
                'Registered!',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}