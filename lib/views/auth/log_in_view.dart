import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/auth_controller.dart';
import 'package:turbbbites_flutter_app/views/home/home_view.dart';

import 'register_view.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final _formKey = GlobalKey<FormState>();
  AuthApiController authApiController = AuthApiController.controller;

  String _password = "";
  String _email = "";

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var response = await authApiController.login(_email, _password);
      if(response != null) {
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text("Login"),
              SizedBox(
                height: 8,
              ),
              Text("Hey enter your details to get started"),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email",
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      !value.contains("@")) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter password",
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.length < 8) {
                    return "Please enter a valid password, at least 8 characters";
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() => FilledButton(
                  onPressed:
                  authApiController.isLoading.value == false ? _onSubmit : null,
                  child: Text("Login")),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() => Text(authApiController.error.value)),
              Obx(() => Text(authApiController.message.value)),


              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  SizedBox(
                    width: 4,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.offNamed("/auth/register");
                      },
                      child: Text("Register")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
