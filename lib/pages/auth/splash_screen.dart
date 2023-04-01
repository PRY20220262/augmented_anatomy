import 'package:augmented_anatomy/utils/augmented_anatomy_colors.dart';
import 'package:flutter/material.dart';
import '../../services/auth/session_active_local_service.dart';
import '../../utils/connection_validator.dart';
import '../../widgets/widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin, InternetConnectionMixin {

  // Properties

  final sessionManager = SessionManager();
  late AnimationController _animationController;
  late Animation<double> _animation;
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
      checkInternetConnection();
    });
  }

  // Functions

  @override
  Future<void> checkInternetConnection() async {
    bool isConnected = await ConnectionValidator.checkInternetConnection();
    setState(() {
      hasInternet = isConnected;
    });
    if (isConnected) {
      setState(() {
        isLoading = true;
      });
      if(sessionActive) {
        // TODO: Implement navigate to HomePage
        print("tengo una sesion iniciada");
      } else {
        Navigator.pushNamed(context, '/logIn');
      }
    }
  }

  Future<void> _loadSession() async {
    bool isLoggedIn = await sessionManager.isLoggedIn();
    setState(() {
      sessionActive = isLoggedIn;
    });
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
                    !hasInternet ? Text(
                      "No se ha encontrado una conexión a internet :(",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall,
                      maxLines: 2,
                    ) : isLoading?  const Center(
                      child: SpinKitFadingCircle(
                        color: AAColors.red,
                        size: 50.0,
                      ),
                    ) : Container(),
                    !hasInternet ? Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: MainActionButton(onPressed: checkInternetConnection, text: "Reintentar", width: 200, height: 40)
                    ) : isLoading? Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          'Cargando datos, espere unos segundos.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                    ) : Container(),
                  ],
              ),
          ),
        ],
      ),
    );
  }
}
