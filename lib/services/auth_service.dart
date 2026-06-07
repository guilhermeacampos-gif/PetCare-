import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get usuarioLogado => _auth.currentUser;

  static Future<String?> fazerLogin(String email, String senha) async {
    try {
      var resultado = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: senha,
      );
      if (resultado.user?.email?.endsWith('@souunit.com.br') != true) {
        await _auth.signOut();
        return 'Apenas contas @souunit.com.br podem acessar o app';
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') return 'Usuário não encontrado';
      if (e.code == 'wrong-password') return 'Senha incorreta';
      return 'Erro ao fazer login';
    }
  }

  static Future<String?> criarConta(String email, String senha) async {
    if (!email.trim().endsWith('@souunit.com.br')) {
      return 'Apenas e-mails @souunit.com.br podem se cadastrar';
    }
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: senha,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') return 'E-mail já cadastrado';
      return 'Erro ao criar conta';
    }
  }

  static Future<void> redefinirSenha(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  static Future<void> sair() async {
    await _auth.signOut();
  }
}