import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:flutter/material.dart';
import '../../utils/connection_validator.dart';
import '../../widgets/button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:augmented_anatomy/services/session_active_local_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin, InternetConnectionMixin {
  // PARA IR POR EL LOGIN SI TIENES SECION GUARDADA
  //final storage = FlutterSecureStorage();

  // Properties

  final sessionManager = SessionManager();
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool hasConnection = true;
  bool hasInternet = true;
  bool sessionActive = false;
  bool isLoading = false;
  String? token;
  String? userId;

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
    _loadSession();
    Future.delayed(const Duration(seconds: 3), () {
      checkConnectionDevice();
      checkInternetConnection();
    });
  }

  // Functions

  Future<void> _loadSession() async {
    // PARA IR POR EL LOGIN SI TIENES SECION GUARDADA
    // await storage.delete(key: 'token');
    bool isLoggedIn = await sessionManager.isLoggedIn();
    setState(() {
      sessionActive = isLoggedIn;
    });
  }

  @override
  Future<void> checkConnectionDevice() async {
    bool isConnected = await InternetValidator.validateConnectionDevice();
    setState(() {
      hasConnection = isConnected;
    });
    if (isConnected) {
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Future<void> checkInternetConnection() async {
    bool hasInternetValidated =
        await InternetValidator.validateInternetDevice();
    setState(() {
      hasInternet = hasInternetValidated;
    });
    if (hasInternet) {
      if (sessionActive) {
        // TODO: Implement navigate to HomePage
        print("Session is active in backup");
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      setState(() {
        isLoading = false;
        hasConnection = false;
      });
    }
  }

  // User Interface

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                !hasConnection
                    ? Text(
                        "No se ha encontrado una conexión a internet :(",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall,
                        maxLines: 2,
                      )
                    : isLoading
                        ? const Center(
                            child: SpinKitFadingCircle(
                              color: AAColors.red,
                              size: 50.0,
                            ),
                          )
                        : Container(),
                !hasConnection
                    ? Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: MainActionButton(
                            onPressed: checkInternetConnection,
                            text: "Reintentar",
                            width: 200,
                            height: 40))
                    : isLoading
                        ? Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              'Cargando datos, espere unos segundos.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelSmall,
                            ))
                        : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
