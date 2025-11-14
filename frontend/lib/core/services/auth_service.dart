import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/data/models/user_model.dart';

class AuthService {
  static const _tokenKey = 'auth_token';
  static const _userIdKey = 'user_id';
  static const _userNameKey = 'user_name';
  static const _userEmailKey = 'user_email';
  static const _userCpfKey = 'user_cpf';
  static const _userTelefoneKey = 'user_telefone';
  static const _userEnderecoKey = 'user_endereco';
  static const _tipoPerfilKey = 'tipo_perfil';

  Future<void> saveAuthData({
    required String token,
    required UserModel user,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userIdKey, user.id);
    await prefs.setString(_userNameKey, user.nome);
    await prefs.setString(_userEmailKey, user.email);
    if (user.cpf != null) {
      await prefs.setString(_userCpfKey, user.cpf!);
    }
    if (user.telefone != null) {
      await prefs.setString(_userTelefoneKey, user.telefone!);
    }
    if (user.endereco != null) {
      await prefs.setString(_userEnderecoKey, user.endereco!);
    }
    if (user.tipoConta != null) {
      await prefs.setString(_tipoPerfilKey, user.tipoConta!);
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'id': prefs.getString(_userIdKey),
      'nome': prefs.getString(_userNameKey),
      'email': prefs.getString(_userEmailKey),
      'cpf': prefs.getString(_userCpfKey),
      'telefone': prefs.getString(_userTelefoneKey),
      'endereco': prefs.getString(_userEnderecoKey),
      'tipoPerfil': prefs.getString(_tipoPerfilKey),
    };
  }

  Future<String?> getTipoPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tipoPerfilKey);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Atualizar dados do usuário
  Future<void> updateUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, user.nome);
    await prefs.setString(_userEmailKey, user.email);
    if (user.tipoConta != null) {
      await prefs.setString(_tipoPerfilKey, user.tipoConta!);
    }
  }
}