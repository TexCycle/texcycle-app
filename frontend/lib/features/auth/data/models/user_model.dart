class UserModel {
  final String id;
  final String nome;
  final String? cpf;
  final String email;
  final String? telefone;
  final String? endereco;
  final String? tipoConta;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.nome,
    this.cpf,
    required this.email,
    this.telefone,
    this.endereco,
    this.tipoConta,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      nome: json['nome'] ?? '',
      cpf: json['cpf'],
      email: json['email'] ?? '',
      telefone: json['telefone'],
      endereco: json['endereco'],
      tipoConta: json['tipo_perfil'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
      'tipo_perfil': tipoConta,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}

class AuthResponse {
  final String token;
  final UserModel user;

  AuthResponse({
    required this.token,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] ?? '',
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }
}

class SignUpRequest {
  final String nome;
  final String? cpf;
  final String email;
  final String? telefone;
  final String? endereco;
  final String password;
  final String? tipoConta;

  SignUpRequest({
    required this.nome,
    this.cpf,
    required this.email,
    this.telefone,
    this.endereco,
    required this.password,
    this.tipoConta,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      if (cpf != null && cpf!.isNotEmpty) 'cpf': cpf,
      'email': email,
      if (telefone != null && telefone!.isNotEmpty) 'telefone': telefone,
      if (endereco != null && endereco!.isNotEmpty) 'endereco': endereco,
      'password': password,
      if (tipoConta != null) 'tipo_perfil': tipoConta,
    };
  }
}