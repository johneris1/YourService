import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  String message = '';
  Future register(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      message = userCredential.additionalUserInfo.username;
      User user = auth.currentUser;
      if (!isEmailVerified()) {
        await user.sendEmailVerification();
      }
      return message ?? 'Cadastro feito com sucesso!';
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        message = 'Por favor,digite uma senha segura.';
      } else if (e.code == 'email-already-in-use') {
        message = 'E-mail já existente';
      }

      return message;
    } catch (e) {
      print(e);
      return e;
    }
  }

  bool isEmailVerified() {
    User user = auth.currentUser;
    return user.emailVerified;
  }
}
