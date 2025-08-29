import 'package:facebook_clone/features/auth/presentation/screens/create_account_screen.dart';
import 'package:facebook_clone/features/auth/providers/auth_provider.dart';
import 'package:facebook_clone/features/auth/utils/utils.dart';
import 'package:facebook_clone/core/constants/constants.dart';
import 'package:facebook_clone/core/widgets/round_button.dart';
import 'package:facebook_clone/core/widgets/round_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _formkey = GlobalKey<FormState>();

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isLoading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      await ref.read(authProvider).signIn(
            email: _emailController.text,
            password: _passwordController.text,
          );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: Constants.defaultPadding,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/icons/fb_logo.png', height: 60),
            const SizedBox(height: 20),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  RoundTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    validator: validateEmail,
                    textInputAction: TextInputAction.next,
                    isPassword: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(width: 20),
                  RoundTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    validator: validatePassword,
                    textInputAction: TextInputAction.done,
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 20),
                  RoundButton(onPressed: login, label: 'Login'),
                  const SizedBox(height: 20),
                  Text('Forget Password?', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            Column(
              children: [
                RoundButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamed(CreateAccountScreen.routeName);
                  },
                  label: 'Create New Account',
                  color: Colors.transparent,
                ),
                Image.asset('assets/icons/meta.png', height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
