import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turbbbites_flutter_app/core/api/controllers/auth_controller.dart';
import 'package:turbbbites_flutter_app/views/user/user_logged.dart';
import 'package:turbbbites_flutter_app/views/user/user_not_logged.dart';

class UserBody extends StatelessWidget {
  const UserBody({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthApiController authController = AuthApiController.controller;

    return Obx(() {
      if (authController.authModel.value == null) {
        return UserNotLogged();
      }
      return UserLogged();
    });
  }
}
