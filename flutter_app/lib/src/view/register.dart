import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../services/userService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../controllerRegistration.dart' as ControllerRegistration;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  var _error;
  bool _isSuccess;
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

    return MaterialApp(
      key: _formKey,
      //backgroundColor: Colors.green,
      home: Scaffold(
        //backgroundColor: Colors.green,
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background.jpg"),
                  fit: BoxFit.cover,
                )
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                FocusScope.of(context).requestFocus(_blankFocusNode);
              },
              child: SafeArea(
                child: Container(
                  height: height - padding.top - padding.bottom,
                  margin: EdgeInsets.symmetric(horizontal: 25.0),
                  //color: Colors.red,
                  child: Column(
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
                        //margin: EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                      Text(
                        'Registration',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 25.0),
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            //color: Colors.grey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                                  //color: Colors.grey[400],
                                  child: TextFormField(
                                    controller: _displayName,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      contentPadding: EdgeInsets.zero,
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.blue,
                                      ),
                                      labelText: 'Full Name',
                                      labelStyle: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
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
                                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                                  //color: Colors.grey[400],
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      contentPadding: EdgeInsets.zero,
                                      prefixIcon: Icon(
                                        Icons.mail,
                                        color: Colors.blue,
                                      ),
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 2.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
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
                                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                                  //color: Colors.grey[400],
                                  child: TextFormField(
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      contentPadding: EdgeInsets.zero,
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.blue,
                                      ),
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        color: Colors.blue,
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
                                            color: Colors.blue, width: 2.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10.0),
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
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                alignment: Alignment.center,
                                child: OutlineButton(
                                  child: Text("Register"),
                                  onPressed: () async {
                                    // if (_formKey.currentState.validate()) {
                                    ControllerRegistration.registerAccount(_displayName.text,_emailController.text,_passwordController.text,context)
                                            .then((result) => setState(() {
                                                _error=result;
                                        }));
                                    showAlert();
                                        }
                                )),


                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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

