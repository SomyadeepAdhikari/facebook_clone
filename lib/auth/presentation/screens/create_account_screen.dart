import 'dart:io';

import 'package:facebook_clone/core/constants/app_colors.dart';
import 'package:facebook_clone/core/constants/constants.dart';
import 'package:facebook_clone/core/widgets/pick_image_widget.dart';
import 'package:facebook_clone/core/widgets/round_text_field.dart';
import 'package:facebook_clone/utils/utils.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  File? image;

  // controllers
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
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
            child: Column(children: [
              GestureDetector(
                onTap: () async{
                  image = await pickImage();
                  setState(() {
                    // Update the state to reflect the new image
                    image = image;
                  });
                },
                child: PickImageWidget(image: image)),
                const SizedBox(height: 20),
                Row(children: [
                  Expanded(child: RoundTextField(controller: _fnameController, hintText: 'First Name',validator: validateName,  textInputAction: TextInputAction.next)),
                  Expanded(child: RoundTextField(controller: _lnameController, hintText: 'Last Name',validator: validateName,  textInputAction: TextInputAction.next)),
                ],)
              ]),
          ),
        ),
      ),
    );
  }
}
