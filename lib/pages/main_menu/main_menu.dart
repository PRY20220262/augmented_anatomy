import 'package:augmented_anatomy/pages/main_menu/organs.dart';
import 'package:augmented_anatomy/pages/main_menu/systems.dart';
import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  int _selectedIndex = 0;
  final tabs = [
    Home(),
    Systems(),
    Organs()
  ];
  final List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.house),
      label: 'Inicio',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.person),
      label: 'Sistemas',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.lungs),
      label: 'Organos',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Acción al presionar el botón
          },
          icon: const Icon(Icons.add),
          backgroundColor: AAColors.red,
          label: Text(
            'Crear apunte',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AAColors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: Center(
          child: tabs[_selectedIndex],
        ),
        bottomNavigationBar: Container(
            height: 75,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5), topLeft: Radius.circular(5)
              ),
              boxShadow: [
                BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
              child: BottomNavigationBar(
                items: _bottomNavigationBarItems,
                currentIndex: _selectedIndex,
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  },
                selectedItemColor: AAColors.blue,
              ),
            )
        )
    );
  }
}
