// import 'package:flutter/material.dart';
// import 'package:flutter_login/flutter_login.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   Duration get loginTime => const Duration(milliseconds: 1250);
//
//   Future<String?> _authUser(LoginData data, BuildContext context) async {
//     return Future.delayed(loginTime).then((_) {
//       return "Kullanıcı Bulunamadı";
//     });
//   }
//
//   Future<String?> _signupUser(var data) {
//     debugPrint('Kullanıcı Adı: ${data.name!}, Şifri: ${data.password}');
//     return Future.delayed(loginTime).then((_) {
//       return null;
//     });
//   }
//
//   Future<String?> _recoverPassword(String name) {
//     debugPrint('Ad: $name');
//     return Future.delayed(loginTime).then((_) {
//       return null;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FlutterLogin(
//       title: "BlanK",
//       // logo: AssetImage('assets/images/ecorp-lightblue.png'),
//       logo: null,
//       userType: LoginUserType.name,
//       userValidator: (value) {
//         return null; // no need to set rules, the username will be provided
//       },
//       passwordValidator: (value) {
//         return null; // no need to set rules, the passwords will be provided
//       },
//
//       onLogin: (data) {},
//       onSignup: _signupUser,
//       onRecoverPassword: _recoverPassword,
//
//       messages: LoginMessages(
//           userHint: "Kullanıcı Adı",
//           passwordHint: "Şifre",
//           loginButton: "Giriş Yap",
//           forgotPasswordButton: 'Şifreni mi unuttun? Bizimle iletişime geç',
//           recoverPasswordDescription:
//               "Kullanıcı adını yazarsan, sana bir email yollayacağız",
//           recoverPasswordButton: "Kurtar",
//           recoverPasswordIntro: "Şifreni tazele",
//           flushbarTitleError: "Hata",
//           flushbarTitleSuccess: "Tamamdır",
//           goBackButton: "Geri",
//           recoverPasswordSuccess:
//               "Bildirimin tarafımıza ulaştı. En kısa sürede seninle iletişime geçeceğiz"),
//       hideForgotPasswordButton: false,
//       // hideSignUpButton: true, chaned it in the source code
//       theme: LoginTheme(
//           // buttonTheme: LoginButtonTheme(),
//           // titleStyle: const TextStyle(color: AppColors.white, fontSize: 30),
//           // cardTheme: const CardTheme(color: AppColors.primaryBlue),
//           // pageColorDark: AppColors.primaryBlue,
//           // buttonStyle: const TextStyle(color: AppColors.primaryBlue)
//       ),
//       onSubmitAnimationCompleted: () {
//         // Navigator.of(context).pushReplacementNamed(ROUTE_MAIN);
//       },
//     );
//   }
// }
