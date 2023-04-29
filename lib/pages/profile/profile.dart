import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:augmented_anatomy/widgets/appbar.dart';
import 'package:augmented_anatomy/widgets/button.dart';
import 'package:augmented_anatomy/widgets/error.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AAColors.backgroundGrayView,
        appBar: AAAppBar(context, back: true, title: 'Perfil'),
        body: FutureBuilder(
          future: _calculation,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
                  child: Column(children: [
                    const Avatar(),
                    const SizedBox(height: 10),
                    Text(
                      'Gino Quispe Calixto',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 10),
                    MainActionButton(
                      onPressed: () {},
                      text: 'Editar Perfil',
                      width: 170,
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 20, 20, 20),
                      thickness: 1,
                    ),
                    const SizedBox(height: 5),
                    const TitleLabel(
                      title: 'correo electrónico:',
                      label: 'quispecalixtogino@gmail.com',
                    ),
                    const TitleLabel(
                      title: 'teléfono:',
                      label: '+51 999 999 999',
                    ),
                    const TitleLabel(
                      title: 'cumpleaños:',
                      label: '-- -- / -- -- / -- --',
                    ),
                    const SizedBox(height: 5),
                    const Divider(
                      color: Color.fromARGB(255, 20, 20, 20),
                      thickness: 1,
                    ),
                    ListTile(
                      onTap: () {},
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

class TitleLabel extends StatelessWidget {
  final String title;
  final String label;
  const TitleLabel({super.key, required this.title, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              label,
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
              ),
              onPressed: () {},
            ),
          ),
        )
      ],
    );
  }
}
