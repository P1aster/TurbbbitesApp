import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserNotLogged extends StatelessWidget {
  const UserNotLogged({super.key});

  void _loginNavigate(BuildContext context) {
    Get.toNamed('/auth/login');
  }

  void _registerNavigate(BuildContext context) {
    Get.toNamed('/auth/register');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("You are not logged in yet"),
          SizedBox(height: 8,),
          Text("Please login or register"),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(onPressed: () {
                _loginNavigate(context);
              },
              icon: Icon(Icons.arrow_circle_right_outlined),
              label: Text("Login"),
              ),
              SizedBox(width: 16,),
              FilledButton.icon(
                onPressed: () {
                  _registerNavigate(context);
                },
                icon: Icon(Icons.person_outline_rounded),
                label: Text("Register"),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
