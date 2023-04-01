import 'package:augmented_anatomy/widgets/connectionErrorDialog.dart';
import 'package:flutter/material.dart';

import '../../utils/connectionValidator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin, InternetConnectionMixin {

  // Properties

  late AnimationController _animationController;
  late Animation<double> _animation;
  bool hasInternet = true;
  bool sessionActive = false;

  // Life Cycle

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
    checkInternetConnection();
  }

  // Functions

  @override
  Future<void> checkInternetConnection() async {
    bool isConnected = await ConnectionValidator.checkInternetConnection();
    setState(() {
      hasInternet = isConnected;
    });
    if (isConnected) {
      if(sessionActive) {
        // TODO: Implement navigate to HomePage
      } else {
        // TODO: Implement navigate to LoginPage
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ConnectionErrorDialog();
          }
      );
    }
  }

  // User Interface

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: _animation,
            child: Image.asset(
              'assets/icon.png',
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
          ),
          !hasInternet ? const Text(
            "No se ha encontrado una conexión a internet :(",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none
            ),
            maxLines: 2,
          ) : Container(),
          !hasInternet ? Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: () {
                checkInternetConnection();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                minimumSize: const Size(100, 50),
                textStyle: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold
                )
              ),
              child: const Text("Intentar nuevamente"),
            )
          ) : Container(),
        ],
      ),
    );
  }
}
