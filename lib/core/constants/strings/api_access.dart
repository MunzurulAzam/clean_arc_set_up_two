
class ApiAccess {
  //BASE URL
  // static String baseUrl = "https://microfin.grapestl.com";
  static String baseUrl = 'https://easy.umoja-international.com/';
  // static String baseUrl2 = "https://scky.umoja-international.com/";

  //API URL
  static String refreshTokenUrl = "${baseUrl}api/auth/token/refresh/";
  static String checkUserUrl = "${baseUrl}api/auth/check";
  static String logInUrl = "${baseUrl}api/auth/login";
  static String signUpUrl = "${baseUrl}api/auth/register";
  static String applyLoanUrl = "${baseUrl}api/LoanApplication/create";

}
