import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:urban_escape/main.dart';
import 'package:urban_escape/shared.dart';

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

class AuthGate extends StatelessWidget {
  AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            styles: <FlutterFireUIStyle> {},
            providerConfigs: const [
              EmailProviderConfiguration(),
              /*GoogleProviderConfiguration(
                  clientId:
                      '708215483312-dk8kfdeqc4iku979eid6mle2eoohau7j.apps.googleusercontent.com'),*/
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/logo_spin.gif'),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text(
                        'Welcome to FlutterFire, please sign in!',
                      )
                    : const Text(
                        'Welcome to Flutterfire, please sign up!',
                      ),
              );
            },
            /*footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            sideBuilder: (context, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/images/flutterfire_300x.png'),
                ),
              );
            },*/
          );
        }

        loggedInFirstTime = true;

        /*if (firstPassAuthGate && themeChanged) {
          print("FIRST PASS");
          firstPassAuthGate = false;
        } else if (!firstPassAuthGate) {
          print("SECOND PASS");
          themeChanged = true;
          firstPassAuthGate = true;
        }*/

        if (currentPassAuthGate == 0 && themeChanged) {
          print("FIRST PASS");
          currentPassAuthGate++;
        } else if (currentPassAuthGate != 0 &&
            currentPassAuthGate < requiredPassesAuthGate) {
          print(currentPassAuthGate.toString() + " PASS");
          themeChanged = true;
          currentPassAuthGate++;
        }

        if (currentPassAuthGate == requiredPassesAuthGate)
          currentPassAuthGate = 0;

        if (themeChanged) {
          themeChanged = false;
          print("THEME CHANGED");
        } else {
          setBoolToSharedPrefs("isLoggedIn", true);
          print("LOGGED IN");
          loggedInCount++;
          requiredPassesAuthGate = loggedInCount * 2;
        }
        print("AUTH GATE");

        return const HomeScreen();
      },
    );
  }
}
