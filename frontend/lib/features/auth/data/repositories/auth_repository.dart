import 'package:dio/dio.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/config/api_config.dart';
import '../models/user_model.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  
  ApiException(this.message, {this.statusCode});
  
  @override
  String toString() => message;
}

class AuthRepository {
  final ApiClient _apiClient = ApiClient();

  Future<AuthResponse> signUp(SignUpRequest request) async {
    try {
      final response = await _apiClient.post(
        ApiConfig.signUp,
        data: request.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AuthResponse.fromJson(response.data);
      } else {
        throw ApiException(
          'Erro ao criar conta',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;
        final message = data is Map 
            ? (data['message'] ?? data['error'] ?? 'Erro ao criar conta')
            : 'Erro ao criar conta';
        throw ApiException(message, statusCode: e.response!.statusCode);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ApiException('Tempo de conexão esgotado. Verifique sua internet.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw ApiException('Não foi possível conectar ao servidor. Verifique se a API está rodando.');
      } else {
        throw ApiException('Erro de conexão: ${e.message}');
      }
    } catch (e) {
      throw ApiException('Erro inesperado: $e');
    }
  }

  Future<AuthResponse> signIn(String email, String senha) async {
    try {
      final response = await _apiClient.post(
        ApiConfig.signIn,
        data: {
          'email': email,
          'password': senha,  
        },
      );

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(response.data);
      } else {
        throw ApiException(
          'Erro ao fazer login',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final data = e.response!.data;
        final message = data is Map 
            ? (data['message'] ?? data['error'] ?? 'Credenciais inválidas')
            : 'Credenciais inválidas';
        throw ApiException(message, statusCode: e.response!.statusCode);
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ApiException('Tempo de conexão esgotado');
      } else if (e.type == DioExceptionType.connectionError) {
        throw ApiException('Não foi possível conectar ao servidor');
      } else {
        throw ApiException('Erro de conexão');
      }
    } catch (e) {
      throw ApiException('Erro inesperado: $e');
    }
  }

  Future<UserModel> getUserProfile(String token) async {
    try {
      _apiClient.setAuthToken(token);
      
      final response = await _apiClient.get(ApiConfig.getUserProfile);

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ApiException(
          'Erro ao buscar perfil',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ApiException('Sessão expirada. Faça login novamente.');
      }
      throw ApiException('Erro ao buscar perfil');
    } catch (e) {
      throw ApiException('Erro inesperado: $e');
    }
  }
}