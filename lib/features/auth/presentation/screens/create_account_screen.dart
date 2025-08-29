import 'dart:io';

import 'package:facebook_clone/features/auth/presentation/widget/birthday_picker.dart';
import 'package:facebook_clone/features/auth/presentation/widget/gender_picker.dart';
import 'package:facebook_clone/features/auth/providers/auth_provider.dart';
import 'package:facebook_clone/features/auth/utils/utils.dart';
import 'package:facebook_clone/core/constants/app_colors.dart';
import 'package:facebook_clone/core/constants/constants.dart';
import 'package:facebook_clone/core/widgets/pick_image_widget.dart';
import 'package:facebook_clone/core/widgets/round_button.dart';
import 'package:facebook_clone/core/widgets/round_text_field.dart';
import 'package:facebook_clone/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _formKey = GlobalKey<FormState>();

class CreateAccountScreen extends ConsumerStatefulWidget {
  const CreateAccountScreen({super.key});

  static const String routeName = '/create-account';

  @override
  ConsumerState<CreateAccountScreen> createState() =>
      _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  File? image;
  DateTime? birthday;
  String gender = 'male';
  bool isLoading = false;

  // controllers
  late final TextEditingController _fnameController;
  late final TextEditingController _lnameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _fnameController = TextEditingController();
    _lnameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _fnameController.dispose();
    _lnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> createAccount() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      ref
          .read(authProvider)
          .createAccount(
            fullName: '${_fnameController.text} ${_lnameController.text}',
            email: _emailController.text,
            password: _passwordController.text,
            birthday: birthday ?? DateTime.now(),
            gender: gender,
            image: image,
          )
          .then((credential) {
            if (credential!.user!.emailVerified) {
              Navigator.pop(context);
            }
          })
          .catchError((_) {
            setState(() {
              isLoading = false;
            });
          });
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.realWhiteColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: Constants.defaultPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    image = await pickImage();
                    setState(() {
                      // Update the state to reflect the new image
                      image = image;
                    });
                  },
                  child: PickImageWidget(image: image),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: RoundTextField(
                        controller: _fnameController,
                        hintText: 'First Name',
                        validator: validateName,
                        textInputAction: TextInputAction.next,
                        isPassword: false,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Expanded(
                      child: RoundTextField(
                        controller: _lnameController,
                        hintText: 'Last Name',
                        validator: validateName,
                        textInputAction: TextInputAction.next,
                        isPassword: false,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    const SizedBox(width: 20),
                    BirthdayPicker(
                      dateTime: birthday ?? DateTime.now(),
                      onPressed: () async {
                        birthday = await pickSimpleDate(
                          context: context,
                          date: birthday,
                        );
                        setState(() {
                          // Update the state to reflect the new birthday
                          birthday = birthday;
                        });
                      },
                    ),
                    const SizedBox(width: 20),
                    GenderPicker(
                      gender: gender,
                      onChanged: (value) {
                        gender = value ?? 'male';
                        setState(() {
                          gender = gender;
                        });
                      },
                    ),
                    const SizedBox(width: 20),
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
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : RoundButton(
                            onPressed: createAccount,
                            label: 'Create Account',
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
