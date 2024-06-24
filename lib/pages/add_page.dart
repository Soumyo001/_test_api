// ignore_for_file: use_build_context_synchronously

import 'package:basic_crud_operations/api/user_api.dart';
import 'package:basic_crud_operations/controller/user_controller.dart';
import 'package:basic_crud_operations/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  late final TextEditingController _nameController, _addressController;
  late final UserApi _userApi;
  late final UserController _userController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _userApi = UserApi();
    _userController = Get.put(UserController());
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
            child: Column(
              children: [
                SizedBox(
                  width: 550,
                  child: FormBuilderTextField(
                    name: 'name',
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()],
                    ),
                    controller: _nameController,
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
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required()],
                    ),
                    controller: _addressController,
                    decoration: const InputDecoration(
                      label: Text('Address'),
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
                ElevatedButton(
                  onPressed: () async {
                    final user = User(
                      userId: 0,
                      name: _nameController.text,
                      address: _addressController.text,
                    );
                    await _userApi.addUser(user);
                    _userController.addUser(user);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text(
                    'Add User',
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
