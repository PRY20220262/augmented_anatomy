import 'package:augmented_anatomy/models/user.dart';
import 'package:augmented_anatomy/services/user_service.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/utils/enums.dart';
import 'package:augmented_anatomy/utils/utils.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:augmented_anatomy/widgets/error.dart';
import 'package:augmented_anatomy/widgets/input.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserService userService = UserService();
  bool isEditing = false;
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  DateTime birthday = DateTime.now();

  Future<User>? _user;

  @override
  void initState() {
    super.initState();

    // initial load
    _user = getUser();
    _user?.then((value) {
      emailController.text = value.email!;
      phoneController.text = value.profile!.phone!;
      birthday = value.profile!.birthDate != null
          ? DateTime.parse(value.profile!.birthDate!)
          : DateTime.now();
    });
  }

  Future<User> getUser() async {
    // return the list here
    return await userService.getUser();
  }

  void updateProfile() async {
    await userService.updateProfile(
        email: emailController.text,
        phone: phoneController.text,
        birthday: dateToString2(birthday));
    refresh();
  }

  void refresh() {
    // reload
    setState(() {
      _user = getUser();
      _user?.then((value) {
        emailController.text = value.email!;
        phoneController.text = value.profile!.phone!;
        birthday = value.profile!.birthDate != null
            ? DateTime.parse(value.profile!.birthDate!)
            : DateTime.now();
      });
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: birthday,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != birthday) {
      setState(() {
        birthday = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AAColors.backgroundGrayView,
        appBar: AAAppBar(context, back: true, title: 'Perfil'),
        body: FutureBuilder(
          future: _user,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              User user = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                  child: Column(children: [
                    const Avatar(),
                    const SizedBox(height: 10),
                    Text(
                      user.profile!.fullName!,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: isEditing == true
                          ? MainAxisAlignment.spaceAround
                          : MainAxisAlignment.center,
                      children: [
                        MainActionButton(
                          onPressed: () {
                            if (isEditing) {
                              updateProfile();

                              setState(() {
                                isEditing = !isEditing;
                              });
                            } else {
                              setState(() {
                                isEditing = !isEditing;
                              });
                            }
                          },
                          text: isEditing ? 'guardar' : 'editar perfil',
                          width: 150,
                        ),
                        isEditing == true
                            ? MainActionButton(
                                text: 'cancelar',
                                type: ButtonType.secondary,
                                height: 40,
                                width: 150,
                                onPressed: () {
                                  setState(() {
                                    isEditing = false;
                                  });
                                })
                            : const SizedBox(
                                width: 0,
                              ),
                      ],
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 20, 20, 20),
                      thickness: 1,
                    ),
                    const SizedBox(height: 5),
                    TitleLabel(
                      title: 'correo electrónico:',
                      label: user.email!,
                      isEditing: isEditing,
                      controller: emailController,
                    ),
                    TitleLabel(
                      title: 'teléfono:',
                      label: user.profile!.phone!,
                      isEditing: isEditing,
                      controller: phoneController,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: isEditing ? 3 : 4,
                            child: const Text(
                              'cumpleaños',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            flex: isEditing ? 7 : 6,
                            child: isEditing
                                ? GestureDetector(
                                    onTap: () => _selectDate(context),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              size.width - size.width * 0.90),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.black45)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            dateToString(birthday),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Text(
                                    dateToString(birthday) ?? '--',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Divider(
                      color: Color.fromARGB(255, 20, 20, 20),
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/notes');
                      },
                      leading: const Icon(Icons.file_copy_outlined,
                          color: Colors.black),
                      title: Text('Mis apuntes',
                          style: Theme.of(context).textTheme.titleSmall),
                      trailing: const Icon(
                        Icons.chevron_right_outlined,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading:
                          const Icon(Icons.edit_square, color: Colors.black),
                      title: Text('Mis cuestionarios',
                          style: Theme.of(context).textTheme.titleSmall),
                      trailing: const Icon(
                        Icons.chevron_right_outlined,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 20, 20, 20),
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {},
                      leading:
                          const Icon(Icons.info_outline, color: Colors.black),
                      title: Text('Información',
                          style: Theme.of(context).textTheme.titleSmall),
                      trailing: const Icon(
                        Icons.chevron_right_outlined,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.logout, color: Colors.black),
                      title: Text('Cerrar Sesión',
                          style: Theme.of(context).textTheme.titleSmall),
                      trailing: const Icon(
                        Icons.chevron_right_outlined,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                ),
              );
            } else if (snapshot.hasError) {
              return ErrorMessage(onRefresh: () {});
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
    );
  }
}

class TitleLabel extends StatefulWidget {
  final String title;
  final String? label;
  final bool isEditing;
  final TextEditingController? controller;
  TitleLabel(
      {super.key,
      required this.title,
      required this.label,
      required this.isEditing,
      this.controller});

  @override
  State<TitleLabel> createState() => _TitleLabelState();
}

class _TitleLabelState extends State<TitleLabel> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: widget.isEditing ? 3 : 4,
            child: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: widget.isEditing ? 7 : 6,
            child: widget.isEditing
                ? InputLabel(controller: widget.controller!)
                : Text(
                    widget.label ?? '--',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
        ],
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            'https://augmentedanatomystorage.blob.core.windows.net/users/gino_profile.jpg',
          ),
        ),
        Positioned(
          bottom: 0,
          right: 5,
          child: CircleAvatar(
            backgroundColor: AAColors.black,
            radius: 14,
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: const Icon(
                Icons.camera_alt_rounded,
                size: 19,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        )
      ],
    );
  }
}
