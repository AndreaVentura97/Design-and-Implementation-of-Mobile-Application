import 'package:delayed_display/delayed_display.dart';
import 'package:flutter_app/redux/model/AppState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_app/src/view/viewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'tabProfilePage.dart';
import '../handleLogin.dart' as handle;
import '../checkLogin.dart';
import 'tabRegister.dart';

class TabLogin extends StatefulWidget {
  TabLoginState createState()=> TabLoginState();
  }


class TabLoginState extends State<TabLogin> {
  bool isLogged = false;
  bool _secText = true;
  var _error;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();

  getprefs() async {
    getLogged().then((log) => setState(() {
      if (log != null) {
        isLogged = log;
      } else {
        isLogged = false;
      }
    }));
  }

  void initState() {
    super.initState();
    getprefs();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _blankFocusNode = new FocusNode();
    var height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    return new StoreConnector<AppState, ViewModel>(
        converter: (store) => createViewModel(store),
        builder: (context, _viewModel) {
    return DelayedDisplay(
      delay: Duration(seconds: 1),
      child: (!isLogged)
          ? Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.green,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage("assets/background.jpg"),
                //   fit: BoxFit.cover,
                // )
              color: Colors.black
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(_blankFocusNode);
              },
              child: SafeArea(
                child: Container(
                  height: height - padding.top - padding.bottom,
                  margin: EdgeInsets.symmetric(horizontal: 25.0),
                  //color: Colors.red,
                  child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            showAlert(),

                            Container(
                                height: 300,
                                width: 200,
                                child: FittedBox(
                                  child: Image.asset(
                                    'assets/Logo_MeMiQ_2.png',
                                  ),
                                ),
                            ),

                            //LogIn
                            Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              color: Colors.white,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 300.0),
                              child: Center(child: withEmailPassword()),
                            ),

                            Container(
                              //color: Colors.black,
                              margin: EdgeInsets.symmetric(horizontal: 300.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                          child: Divider(
                                            color: Colors.white,
                                            height: 2.0,
                                          )),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        'or',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Expanded(
                                          child: Divider(
                                            color: Colors.white,
                                            height: 2.0,
                                          )),
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: RaisedButton(
                                            elevation: 5.0,
                                            color: Colors.white,
                                            child: Text("Google",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20.0,
                                                )),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    15.0)),
                                            onPressed: () {
                                              handle
                                                  .loginWithGoogle(context)
                                                  .then(
                                                      (value) => setState(() {
                                                    isLogged = value;
                                                  }));
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 100.0),
                                        Expanded(
                                          child: RaisedButton(
                                              elevation: 5.0,
                                              color: Color.fromRGBO(
                                                  59, 89, 152, 1),
                                              child: Text("Facebook",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                  )),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      15.0)),
                                              onPressed: () {
                                                handle
                                                    .loginWithFB(context)
                                                    .then((value) =>
                                                    setState(() {
                                                      isLogged = value;
                                                    }));
                                              }),
                                        ),
                                      ]),
                                ],
                              ),
                            ),

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: RichText(
                                text: TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Register now',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          decoration:
                                          TextDecoration.underline,
                                          fontSize: 20.0,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TabRegister()),
                                            );
                                          },
                                      )
                                    ]),
                              ),
                            )
                          ])),
                ),
              ),
            ),
          ),
        ),
      ) : TabProfile(email: _viewModel.c.email),
    );
  });
  }

  Widget withEmailPassword() {
    bool _autoValidate = false;

    return Container(
      margin: EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,

        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.blue[900],
                    size: 30.0,
                  ),
                  hintText: 'Email',
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 20.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue[900],
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue,
                ),
                validator: (value) {
                  if (value.isEmpty) return 'Please, enter some text';
                  if (!value.contains('@')) return 'Please, insert an email';
                  return null;
                },
                // onTap: (){
                //
                // },
                textInputAction: TextInputAction.next,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.blue[900],
                    size: 30.0,
                  ),
                  hintText: 'Password',
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 20.0,
                  ),
                  suffixIcon: IconButton(
                    icon: (_secText) ?
                      Icon(Icons.remove_red_eye,
                        size: 30,
                        color: Colors.blue[900],
                      )
                        : Icon(Icons.remove_red_eye_outlined,
                      size: 30,
                      color: Colors.blue[900],
                    ),
                    onPressed: () {
                      setState(() {
                        _secText = !_secText;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue[900],
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue,
                ),
                obscureText: _secText,
                validator: (value) {
                  if (value.isEmpty) return 'Please enter some text';
                  return null;
                },
              ),
            ),
            TextButton(
              child: Text('Sign In',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
                    decoration: TextDecoration.underline,
                  )),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  handle
                      .signInWithEmailAndPassword(context,
                      _emailController.text, _passwordController.text)
                      .then((value) => setState(() {
                    _error = value;
                  isLogged = true;
                      }));
                }
              },
            ),
          ],
        ),
        //)
      ),
    );
  }

  Widget showAlert() {
    if (_error != null)
      return Container(
        color: Colors.amber,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                "$_error",
                maxLines: 3,
              ),
            ),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                })
          ],
        ),
      );
    return SizedBox(
      height: 0.0,
    );
  }
}