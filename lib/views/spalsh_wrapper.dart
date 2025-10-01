import 'package:flutter/material.dart';

class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  @override
  void initState() {
    super.initState();
    // Delay of 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to Login Screen
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/splash.png',width: double.infinity,height: double.infinity,fit: BoxFit.cover,),
      ),
    );
  }
}






















// class SpalshWrapper extends StatefulWidget  {
//   const SpalshWrapper({super.key});

//   @override
//   State<SpalshWrapper> createState() => _SpalshWrapperState();
// }

// class _SpalshWrapperState extends State<SpalshWrapper> with WidgetsBindingObserver{
//   bool _initialized = false;
//   late StreamSubscription<List<ConnectivityResult>> _subscription;

//   @override
//   void initState() {
//     super.initState();
//      WidgetsBinding.instance.addObserver(this);
//     _listenForInternet();
//     _initializeApp(); // Try on first launch
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       // App is in foreground again
//        NotificationService.audioPlayer.stop(); // stop custom sound
      
//     }
//   }
//    @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this); // 👈 ADD THIS
//     _subscription.cancel();
//     super.dispose();
//   }

//   void _listenForInternet() {
//     _subscription = Connectivity()
//         .onConnectivityChanged
//         .listen((List<ConnectivityResult> result) async {
//       final hasInternet = result.any((res) =>
//           res == ConnectivityResult.mobile || res == ConnectivityResult.wifi);

//       if (hasInternet && !_initialized) {
//         await _initializeApp();
//       }
//     });
//   }

//   Future<void> _initializeApp() async {

//     bool isConnected = await ConnectionChecker.checkConnection(context);
//     if (!isConnected) return;
//     setState(() => _initialized = true);

//     // Show splash for a few seconds
//     await Future.delayed(const Duration(seconds: 1));

    
//     // Initialize foreground service
//   await requestPermissions(); 
//   await startService(); 

//     // Start background location tracking via LocationProvider
//     final locationProvider =
//         Provider.of<LocationProvider>(context, listen: false);
//     await locationProvider.startLocationUpdates();



//     // Check login status from SharedPreferences
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('jwtToken');

//     if (token != null && token.isNotEmpty) {
//       // Navigate to home if logged in
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       // Navigate to signIn if not logged in
//       Navigator.pushReplacementNamed(context, '/signIn');
//     }
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Image.asset('assets/images/logo.png'),
//       ),
//     );
//   }
// }























