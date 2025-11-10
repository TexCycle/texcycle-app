import 'dart:io';
import 'package:flutter/foundation.dart';

class ApiConfig {
  // android emulator (acessa localhost do host)
  static const String baseUrlAndroid = 'http://10.0.2.2:3000'; 
  
  // ios simulator
  static const String baseUrlIOS = 'http://localhost:3000'; 

  // desktop/web
  static const String baseUrlLocalhost = 'http://localhost:3000'; 

  // dispositivo físico (atualize o IP se necessário)
  static const String baseUrlPhysical = 'http://192.168.0.104:3000'; 
  static const String baseUrlProduction = 'http://192.168.0.104:3000';
  
  // configuração do ambiente atual
  // opções: 'auto', 'android', 'ios', 'localhost', 'physical', 'production'
  // 'auto' = detecta automaticamente baseado na plataforma
  static const String currentEnvironment = 'auto';
  
  static String get baseUrl {
    if (currentEnvironment != 'auto') {
      switch (currentEnvironment) {
        case 'android':
          return baseUrlAndroid;
        case 'ios':
          return baseUrlIOS;
        case 'localhost':
          return baseUrlLocalhost;
        case 'physical':
          return baseUrlPhysical;
        case 'production':
          return baseUrlProduction;
        default:
          break;
      }
    }
    
    // detecção automática
    if (kIsWeb) {
      return baseUrlLocalhost;
    } else if (Platform.isAndroid) {
      return baseUrlAndroid;
    } else if (Platform.isIOS) {
      return baseUrlIOS;
    } else {
      return baseUrlLocalhost;
    }
  }
  
  static const String signUp = '/api/auth/register';
  static const String signIn = '/api/auth/login';
  static const String getUserProfile = '/api/users/profile';
  
  static const Duration timeout = Duration(seconds: 30);
}