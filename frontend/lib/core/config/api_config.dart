class ApiConfig {
  static const String baseUrlAndroid = 'http://10.0.2.2:3000';
  
  static const String baseUrlIOS = 'http://localhost:3000';
  
  static const String baseUrlPhysical = 'http://192.168.0.104:3000'; 
  
  static const String baseUrlProduction = 'http://192.168.0.104:3000';
  
  static String get baseUrl {
    // return baseUrlAndroid; // Para Android Emulator
    // return baseUrlIOS; // Para iOS Simulator
    return baseUrlPhysical; 
  }
  
  static const String signUp = '/api/auth/register';
  static const String signIn = '/api/auth/login';
  static const String getUserProfile = '/api/users/profile';
  
  static const Duration timeout = Duration(seconds: 30);
}