import 'package:flutter/material.dart';
import 'package:sipac_mobile_4/core/data/entities/credential.dart';
import 'package:sipac_mobile_4/core/data/user_preferences.dart';
import 'package:sipac_mobile_4/core/presentation/components/my_text_form_field.dart';
import 'package:sipac_mobile_4/core/presentation/components/server_input.dart';
import 'package:sipac_mobile_4/core/styles/colors.dart';
import 'package:sipac_mobile_4/core/styles/constants.dart';
import 'package:sipac_mobile_4/core/styles/decoration.dart';
import 'package:sipac_mobile_4/core/utils/validators.dart';

import '../../../styles/text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formLoginKey = GlobalKey<FormState>();
  late TextEditingController _userController;
  final TextEditingController _passwordController = TextEditingController();
  late TextEditingController _serverController;

  @override
  void initState() {
    super.initState();
    _userController = TextEditingController()
      ..text = (UserPreferences().userData != 'userData null')
          ? credentialFromJson(UserPreferences().userData).name
          : '';
    _serverController = TextEditingController()
      ..text = (UserPreferences().userData != 'userData null')
          ? credentialFromJson(UserPreferences().userData).server
          : '';
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(children: [
        _buildBackground(screenSize),
        _buildLoginForm(screenSize)
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.dns_rounded,
        ),
        onPressed: () async {
          return await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return ServerInput(_serverController);
            },
          );
        },
      ),
    );
  }

  Widget _buildLoginForm(Size screenSize) {
    return Form(
        key: _formLoginKey,
        child: SingleChildScrollView(
            child: Center(
                child: Column(children: [
          SizedBox(height: screenSize.height * 0.3),
          Container(
              padding: const EdgeInsets.all(highPadding),
              width: 300,
              decoration: containerDecorationS,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Iniciar', style: h1PrimaryC),
                    const SizedBox(height: mediumPadding),
                    _buildUserField(),
                    _buildPasswordField(),
                    const SizedBox(height: lowPadding),
                    _buildRegisterButton()
                  ]))
        ]))));
  }

  Widget _buildUserField() {
    return MyTextFormField.name(
        _userController,
        'Usuario',
        TextCapitalization.words,
        TextInputType.name,
        false,
        (value) => nameValidator(value, 'usuario'));
  }

  Widget _buildPasswordField() {
    return MyTextFormField.name(
        _passwordController,
        'Contraseña',
        TextCapitalization.none,
        TextInputType.name,
        true,
        (value) => passwordValidator(value, 'contraseña'));
  }

  Widget _buildRegisterButton() {
    return Center(
      child: SizedBox(
        width: 160,
        child: ElevatedButton(
            onPressed: () async {
              // login(_userController.text, _passwordController.text);

              if (_formLoginKey.currentState!.validate()) {
                if (_serverController.text != '') {
                  UserPreferences userPreferences = UserPreferences();
                  userPreferences.userData = credentialToJson(Credential(
                      token: '',
                      server: _serverController.text,
                      name: _userController.text,
                      password: _passwordController.text));
                  Navigator.pushNamed(context, 'entryPoint');
                }
              }
            },
            child: const Text('Acceder')),
      ),
    );
  }

  Widget _buildBackground(Size screenSize) {
    //background circles
    final circle = Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            gradient: const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.white10, Colors.white38])));

    return Stack(children: [
      //In order of appearance on the screen from left to right, top to bottom
      Positioned(top: -20, left: -10, child: circle),
      Positioned(top: -40, right: -30, child: circle),
      Positioned(top: 190, left: 70, child: circle),
      Positioned(top: 500, right: 10, child: circle),
      Positioned(bottom: -30, left: -40, child: circle),
      Positioned(bottom: -30, right: -10, child: circle),
      const Center(
          child: Column(
              //La columna con el icono y el texto
              children: [
            SizedBox(height: 60),
            ImageIcon(AssetImage('assets/xedro_logo.png'),
                color: Colors.white, size: 100)
          ]))
    ]);
  }
}
