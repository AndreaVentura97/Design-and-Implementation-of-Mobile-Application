import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'tabLogin.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../services/userService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../controllerRegistration.dart' as ControllerRegistration;

class TabRegister extends StatefulWidget {
  TabRegisterState createState() => TabRegisterState();
}

class TabRegisterState extends State<TabRegister> {
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var _error;
  bool _secText = true;

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
    return Scaffold(
      //backgroundColor: Colors.green,
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage("assets/background.jpg"),
            //   fit: BoxFit.cover,
            // )
            color: Colors.black,
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
                  child: Stack(children: [
                    showAlert(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //Box Logo
                      Container(
                      height: 200,
                      width: 160,
                      child: FittedBox(
                        child: Image.asset(
                          'assets/Logo_MeMiQ_2.png',
                        ),
                      ),
                    ),

                        Text(
                          'Registration',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                          ),
                        ),

                        Card(
                          color: Colors.white,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          margin: const EdgeInsets.symmetric(horizontal: 300.0),
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                              //color: Colors.grey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                                    //color: Colors.grey[400],
                                    child: TextFormField(
                                      controller: _displayName,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        contentPadding: EdgeInsets.zero,
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.blue[900],
                                          size: 30,
                                        ),
                                        labelText: 'Full Name',
                                        labelStyle: TextStyle(
                                          color: Colors.blue[900],
                                          fontSize: 20.0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue[900], width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue[900],
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                                    //color: Colors.grey[400],
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        contentPadding: EdgeInsets.zero,
                                        prefixIcon: Icon(
                                          Icons.mail,
                                          color: Colors.blue[900],
                                          size: 30,
                                        ),
                                        labelText: 'Email',
                                        labelStyle: TextStyle(
                                          color: Colors.blue[900],
                                          fontSize: 20.0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue[900], width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue[900],
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                                    //color: Colors.grey[400],
                                    child: TextFormField(
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        contentPadding: EdgeInsets.zero,
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.blue[900],
                                          size: 30,
                                        ),
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
                                              color: Colors.blue[900], width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.blue[900],
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      obscureText: _secText,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      alignment: Alignment.center,
                                      child: FlatButton(
                                        color: Colors.blue[900],
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("Register",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                                  height: 40,
                                                  child: Icon(Icons.check,size: 30, color: Colors.white,))
                                            ],
                                          ),
                                          onPressed: () async {
                                            // if (_formKey.currentState.validate()) {
                                            ControllerRegistration
                                                    .registerAccount(
                                                        _displayName.text,
                                                        _emailController.text,
                                                        _passwordController
                                                            .text,
                                                        context)
                                                .then((result) => setState(() {
                                                      _error = result;
                                                    }));
                                            showAlert();
                                          })),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: RichText(
                            text: TextSpan(
                                text: "Go back to ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Login',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration:
                                      TextDecoration.underline,
                                      fontSize: 22.0,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        Navigator.pop(context);
                                      },
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  ])),
            ),
          ),
        ),
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
