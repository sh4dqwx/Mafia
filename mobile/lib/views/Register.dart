import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:mobile/viewModels/RegisterViewModel.dart';
import 'Menu.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> with RouteAware {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  bool _showErrorMessage = false;
  bool _passwordsMismatch = false;

  @override
  void didChangeDependencies() {
    context.read<RegisterViewModel>().reset();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _loginController.clear();
    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    context.read<RegisterViewModel>().reset();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _loginController.clear();
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(labelText: 'Login'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
            ),
            const SizedBox(height: 16.0),
            if (_showErrorMessage || _passwordsMismatch)
              Text(
                _passwordsMismatch
                    ? 'Please make sure your password match.'
                    : 'Add login, password and email',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 18.0,
                ),
              ),
            Consumer<RegisterViewModel>(
              builder: (context, viewModel, child) {
                return ElevatedButton(
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
                      bool isRegistered = await viewModel.register(login, email, password);
                      if(isRegistered) {
                        Fluttertoast.showToast(
                          msg: "Successful registration",
                          toastLength: Toast.LENGTH_SHORT
                        );
                        if(!context.mounted) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MenuPage())
                        );
                      }
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
                  child: const Text('Confirm'),
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
