// ignore_for_file: use_build_context_synchronously

import 'package:basic_crud_operations/api/user_api.dart';
import 'package:basic_crud_operations/controller/user_controller.dart';
import 'package:basic_crud_operations/models/user.dart';
import 'package:basic_crud_operations/pages/add_page.dart';
import 'package:basic_crud_operations/pages/edit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final UserApi _userapi;
  late final UserController _userController;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _userapi = UserApi();
    _userController = Get.put(UserController());
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C# core web api crud operations'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddUser(),
          ),
        ),
        child: const Icon(CupertinoIcons.add),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SearchBar(
                    leading: IconButton(
                        icon: const Icon(
                          Icons.search,
                        ),
                        splashRadius: 1,
                        onPressed: () async {
                          final user = await _userapi.getUserByID(
                            int.parse(_searchController.text),
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditPage(user: user),
                            ),
                          );
                        }),
                    controller: _searchController,
                    hintText: 'Search by ID',
                    hintStyle: MaterialStatePropertyAll(
                      TextStyle(color: Colors.grey.shade400),
                    ),
                    textStyle: const MaterialStatePropertyAll(
                      TextStyle(fontSize: 17),
                    ),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const Gap(5),
                FutureBuilder(
                  future: _userapi.getAllUserData(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          _userController
                              .setUserList(snapshot.data as List<User>);
                          return Column(
                            children: [
                              Obx(
                                () => ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _userController.users.length,
                                  itemBuilder: (context, index) {
                                    final user = _userController.users[index];

                                    return ListTile(
                                      onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => EditPage(
                                          user: user,
                                        ),
                                      )),
                                      leading: Text(user.userId.toString()),
                                      title: Text(user.name),
                                      subtitle: Text(user.address),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        splashRadius: 25,
                                        onPressed: () async {
                                          await _userapi
                                              .deleteUser(user.userId);
                                          _userController.deleteUser(user);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      default:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
