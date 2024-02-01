class AppUrls {
  /// Base url
  static const _baseUrl = 'http://159.65.94.152:8080';
  static const signUpApi = '$_baseUrl/api/auth/signup/user';
  static const signInApi = '$_baseUrl/api/auth/signin';
  static const verifyOtp = '$_baseUrl/api/auth/verify-mobile-otp';
  static const updatePassword = '$_baseUrl/api/user/update-password';
  static const sendOtp = '$_baseUrl/api/auth/send-mobile-otp';
  static const forgotPassword = '$_baseUrl/api/auth/forgot-password';
  static const sellerSearch = '$_baseUrl/api/seller/search?';
  static const updateUser = '$_baseUrl/api/user';
}
