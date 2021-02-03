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
                  child: Stack(
                  children: [
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(height: 2,),

                      Container(
                        height: 200,
                        width: 160,
                        child: FittedBox(
                          child: Image.asset(
                            'assets/Logo_MeMiQ_2.png',
                          ),
                        ),
                      ),

                      SizedBox(height: 5,),
                      Text(
                        'Registration',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
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
                                        color: Colors.blue[900],
                                      ),
                                      labelText: 'Full Name',
                                      labelStyle: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 18.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue[900], width: 2.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue[900],
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
                                        color: Colors.blue[900],
                                      ),
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 18.0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue[900], width: 2.0),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue[900],
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
                                        color: Colors.blue[900],
                                      ),
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 18.0,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: (_secText) ?
                                          Icon(Icons.remove_red_eye,
                                            size: 25,
                                            color: Colors.blue[900],
                                          )
                                          : Icon(Icons.remove_red_eye_outlined,
                                              size: 25,
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
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue[900],
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
                                               fontSize: 18
                                           ),
                                         ),
                                         SizedBox(
                                             width: 20,
                                             height: 40,
                                             child: Icon(Icons.check,size: 25, color: Colors.white,))
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
                    ],
                  ),
                    showAlert(),
                  ],
                  )
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
        height: 50,
        color: Colors.amber,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(Icons.error_outline),
            SizedBox(width: 5,),
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

