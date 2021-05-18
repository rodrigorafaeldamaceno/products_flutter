import 'package:flutter/material.dart';
import 'package:products_flutter/db/database.dart';
import 'package:products_flutter/pages/home/home_page.dart';
import 'package:products_flutter/stores/user_store.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  final controller = UserStore();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBody: true,
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Icon(
                      Icons.person,
                      size: MediaQuery.of(context).size.width * 0.35,
                    ),
                  ),
                  Text(
                    'Faça seu login',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _loginController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value.isEmpty) return 'Required field';

                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Your user',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Your password',
                    ),
                    validator: (value) {
                      if (value.isEmpty) return 'Required field';

                      if (value.length < 6)
                        return 'This field must have six characters';

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState.validate()) return;

                        final user = await controller.addUser(
                          User(
                            name: _loginController.text,
                            password: _passwordController.text,
                          ),
                        );

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Text('Login'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
