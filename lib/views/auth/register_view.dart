import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/auth_controller.dart';
import 'package:turbbbites_flutter_app/views/auth/log_in_view.dart';
import 'package:turbbbites_flutter_app/views/home/home_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  AuthApiController controller = AuthApiController();

  String _password = "";
  String _email = "";
  String _fullname = "";

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var response = await controller.register(_fullname, _email, _password);
      if(response != null) {
        Get.back();
      } else {
        Get.snackbar("Error", "Failed to register");
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
              Text("Register"),
              SizedBox(
                height: 8,
              ),
              Text("Hey enter your details to get started"),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your full name";
                  }
                  return null;
                },
                onSaved: (value) {
                  _fullname = value!;
                },
                decoration: InputDecoration(
                  labelText: "Full name",
                  hintText: "Enter your full name",
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email",
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
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
              FilledButton(
                  onPressed:
                      controller.isLoading.value == false ? _onSubmit : null,
                  child: Text("Register")),
              SizedBox(
                height: 20,
              ),
              Obx(() => Text(controller.message.value)),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  SizedBox(
                    width: 4,
                  ),
                  TextButton(
                      onPressed: () {
                        Get.offNamed("/auth/login");
                      },
                      child: Text("Log in")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
