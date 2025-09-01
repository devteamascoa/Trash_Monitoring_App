import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Login Successful', 'Welcome back!');
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User cancelled the sign-in
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      Get.snackbar('Login Successful', 'Logged in with Google!');
    } catch (e) {
      Get.snackbar('Google Login Failed', e.toString());
    }
  }

  Future<void> loginWithFacebook() async {
    // TODO: Implement Facebook sign-in logic using flutter_facebook_auth package
    Get.snackbar('Facebook Login', 'Facebook login not yet implemented.');
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
