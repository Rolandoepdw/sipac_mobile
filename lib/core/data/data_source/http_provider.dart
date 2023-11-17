import 'package:http/http.dart' as http;
import 'dart:convert';

//------------------------------- SingUp & Singin ------------------------------

Future<int> login(String user, String password) async {
  var client = http.Client();
  try {
    var response = await client.post(
        Uri.parse('https://10.128.60.73/v1/seguridad/api-token-auth/'),
        body: {
          "username": "movil",
          "password": base64.encode(utf8.encode('Xipac*-123.'))
        });
    print(response.statusCode);
    return response.statusCode;
  } catch (e) {
    print(e.toString());
  }
  return -1;
}

// //------------------------------- SingUp & Singin ------------------------------
//
// Future<ApiResponse?> signIn(String phone, String password) async {
//   UserPreferences userPreferences = UserPreferences();
//   ApiResponse? apiResponse;
//
//   http.Response response = await http.post(
//     Uri.parse("http://localhost:3000/api/auth/signin"),
//     body: {"phone": phone, "password": password},
//   );
//   apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
//   if (apiResponse.statusCode == 1) {
//     userPreferences.userData = jsonEncode(apiResponse.data);
//   }
//   return apiResponse;
// }
//
// Future<ApiResponse?> signUp(String name, String phone, String password) async {
//   UserPreferences userPreferences = UserPreferences();
//   ApiResponse? apiResponse;
//
//   http.Response response = await http.post(
//     Uri.parse("http://localhost:3000/api/auth/signup"),
//     body: {
//       "displayname": name,
//       "phone": phone,
//       "password": password,
//       "photo": "photo"
//     },
//   );
//   apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
//   if (apiResponse.statusCode == 1) {
//     userPreferences.userData = jsonEncode(apiResponse.data);
//   }
//   return apiResponse;
// }
