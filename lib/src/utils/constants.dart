class AppConstant {
  static String apiKeyGoldApi = 'goldapi-3tb8419m9smmq9f-io';
  static String apiKeyAlphaVantage = '5SM9SOK9DEAJY7GR';
  static String apiKeyNews = 'a57b127d55a2436b961f095268ac5100';
  static String apiKeyExRate = '85adf0c8d61525d4318a82b30c37e09f';
  static String baseUrlAlpha = 'https://www.alphavantage.co/';
  static String baseUrlGold = 'https://www.goldapi.io/';
  static String baseUrlDoji = 'https://giavang365.io.vn/';
  static String baseUrlNews = 'https://newsapi.org/v2/';
  static String baseUrlExRate = 'https://api.exchangerate.host/';
  static String languageAssetsFolder = 'assets/langs';
  static String timeSeries = 'TIME_SERIES_DAILY';
  static String gold24k = 'vang24k';
  // static double sampleXRate = 26000;
}

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String dashboard = '/dashboard';
  static const String settings = '/settings';
  static const String forgotPassword = '/forgotPassword';
  static const String changePassword = '/changePassword';
}

class SharedKey {
  static const String exchangeRate = 'exchangeRate';
  static const String firstRun = 'firstRun';
}
