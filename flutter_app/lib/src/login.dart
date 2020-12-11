import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'profile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'checkLogin.dart';
import 'register.dart';
import 'userService.dart';
import 'checkLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'checkLogin.dart';
import 'profile.dart';
import 'adminScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  bool isLogged = false;
  bool _secText = true;
  var _error;

  Map userProfile;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();
  final facebookLogin = FacebookLogin();
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

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

  _loginWithFB() async {
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        //print(profile);
        setState(() {
          userProfile = profile;
          isLogged = true;
        });
        insertUser(profile['email'], profile['name']);
        checkSession(profile['name'], profile['email'],
            profile["picture"]["data"]["url"]);
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() => isLogged = false);
        break;
      case FacebookLoginStatus.error:
        setState(() => isLogged = false);
        break;
    }
  }

  _loginWithGoogle() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        isLogged = true;
      });
      insertUser(_googleSignIn.currentUser.email,
          _googleSignIn.currentUser.displayName);
      checkSession(_googleSignIn.currentUser.displayName,
          _googleSignIn.currentUser.email, _googleSignIn.currentUser.photoUrl);
    } catch (err) {
      print(err);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      //if (!user.emailVerified) {
      //await user.sendEmailVerification();
      //}
      if (_emailController.text == "admin@live.it" &&
          _passwordController.text == "adminadmin") {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return AdminScreen();
        }));
      } else {
        checkSession(user.displayName, user.email, null);
        insertUser(user.email, user.displayName);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return Profile();
        }));
      }
    } catch (e) {
      await setLogged(false);
      isLogged = false;
      setState(() {
        _error = e.message;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var _blankFocusNode = new FocusNode();

    return MaterialApp(
      key: _scaffoldKey,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        //backgroundColor: Colors.green,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.jpg")
            )
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(_blankFocusNode);
            },
            child: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25.0),
                //color: Colors.red,
                child: Center(
                    child: (!isLogged)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                                showAlert(),
                                //Box Logo
                                Container(
                                  color: Colors.black,
                                  width: 200.0,
                                  height: 200.0,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 100.0,
                                          height: 100.0,
                                          color: Colors.grey,
                                        ),
                                        Text('Nome applicazione',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.grey,
                                            )),
                                      ]),
                                ),

                                //LogIn
                                Card(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  color: Colors.white,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Center(child: withEmailPassword()),
                                ),

                                Container(
                                  //color: Colors.black,
                                  margin: EdgeInsets.symmetric(horizontal: 25.0),
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
                                              fontSize: 16.0,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: RaisedButton(
                                                elevation: 5.0,
                                                color: Colors.white,
                                                child: Text("Google",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.0,
                                                    )),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0)),
                                                onPressed: () {
                                                  _loginWithGoogle();
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 25.0),
                                            Expanded(
                                              child: RaisedButton(
                                                elevation: 5.0,
                                                color: Color.fromRGBO(
                                                    59, 89, 152, 1),
                                                child: Text("Facebook",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0,
                                                    )),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0)),
                                                onPressed: () {
                                                  _loginWithFB();
                                                },
                                              ),
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
                                          fontSize: 16.0,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Register now',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 16.0,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () async {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Register()),
                                                );
                                              },
                                          )
                                        ]),
                                  ),
                                )
                              ])
                        : Profile()),
              ),
            ),
          ),
        ),
      ),
    );
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
              //margin: EdgeInsets.symmetric(horizontal: 40.0),
              //color: Colors.grey[400],
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _emailController,
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.blue[900],
                    //size: 25.0,
                  ),
                  hintText: 'Email',
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 16.0,
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
                  //style of the text when typing
                  fontSize: 16.0,
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
            //SizedBox(height: 15.0),

            Container(
              margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
              color: Colors.grey[400],
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                    //size: 25.0,
                  ),
                  hintText: 'Password',
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_secText
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined),
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
                    borderRadius: BorderRadius.circular(15.0),
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
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
                obscureText: _secText,
                validator: (value) {
                  if (value.isEmpty) return 'Please enter some text';
                  return null;
                },
              ),
            ),

            //SizedBox(height: 15.0),
            TextButton(
              child: Text('Sign In',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                  )),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _signInWithEmailAndPassword();
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
