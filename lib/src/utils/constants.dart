class AppConstant {
  static String apiKeyGoldApi = 'goldapi-3tb8419m9smmq9f-io';
  static String apiKeyAlphaVantage = '5SM9SOK9DEAJY7GR';
  static String baseUrlAlpha = 'https://www.alphavantage.co/';
  static String baseUrlGold = 'https://www.goldapi.io/';
  static String baseUrlDoji = 'https://giavang365.io.vn/';
  static String languageAssetsFolder = 'assets/langs';
  static String timeSeries = 'TIME_SERIES_DAILY';
  static String gold24k = 'vang24k';
  static double usdToVnd = 26000; // TODO: Example conversion rate, may use API to get real-time rate
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
