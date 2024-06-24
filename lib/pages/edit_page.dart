// ignore_for_file: use_build_context_synchronously

import 'package:basic_crud_operations/api/user_api.dart';
import 'package:basic_crud_operations/controller/user_controller.dart';
import 'package:basic_crud_operations/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class EditPage extends StatefulWidget {
  final User user;
  const EditPage({
    super.key,
    required this.user,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late final TextEditingController _nameEditingController;
  late final TextEditingController _addressEditingController;
  late final UserApi _userapi;
  late final UserController _userController;
  late final http.Response response;

  @override
  void initState() {
    super.initState();
    _nameEditingController = TextEditingController(text: widget.user.name);
    _addressEditingController =
        TextEditingController(text: widget.user.address);
    _userapi = UserApi();
    _userController = Get.put(UserController());
  }

  void _updateData() async {
    final user = User(
      userId: widget.user.userId,
      name: _nameEditingController.text,
      address: _addressEditingController.text,
    );
    response = await _userapi.updateUser(widget.user.userId, user);
    _userController.updateUser(user);
    dev.log(response.statusCode.toString());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C# core web api crud operations'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FormBuilder(
            initialValue: {
              'name': widget.user.name,
              'address': widget.user.address,
            },
            child: Column(
              children: [
                SizedBox(
                  width: 550,
                  child: FormBuilderTextField(
                    name: 'name',
                    controller: _nameEditingController,
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()],
                    ),
                    decoration: const InputDecoration(
                      label: Text('Name'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                const Gap(30),
                SizedBox(
                  width: 550,
                  child: FormBuilderTextField(
                    name: 'address',
                    controller: _addressEditingController,
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()],
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      label: Text('Address'),
                    ),
                  ),
                ),
                const Gap(30),
                ElevatedButton(
                  onPressed: _updateData,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
