import 'package:backg/screens/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  String _username, _email, _password;
  bool _isSubmitting, _obscureText = true;

  void _submit() {
    final form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      _registerUser();
    }
  }

  void _registerUser() async {
    setState(() => _isSubmitting = true);
    http.Response response = await http.post(
        'http://serviceslikeme.herokuapp.com/auth/local',
        body: { "identifier": _email, "password": _password});
    final responseData = json.decode(response.body);
    if (response.statusCode == 200) { 
    setState(() => _isSubmitting = false);
    _storeUserData(responseData);
    _showSuccessSnack();
    _redirectUser();
    print(responseData);
    } else {
     setState(() => _isSubmitting = false);
     final List<dynamic> errorMsg = responseData['message'];
     final String cool = (errorMsg[0]["messages"][0]["message"]);
     _showErrorSnack(cool);

  }
  }
  void _storeUserData(responseData) async{
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> user = responseData['user'];
    user.putIfAbsent('Jwt', () => responseData['jwt']);
    json.encode(user);
    prefs.setString('user', json.encode(user));
  }
 void _showErrorSnack(String cool) {
   final snackbar = SnackBar(
     content: Text('$cool', style: kLabelStyle ,),
   );
   _scaffoldkey.currentState.showSnackBar(snackbar);
 }


  void _showSuccessSnack() {
    final snackbar = SnackBar(
      content: Text(
        'User  successfully Logged In',
        style: TextStyle(color: Colors.green),
      ),
    );
    _scaffoldkey.currentState.showSnackBar(snackbar);
    _formkey.currentState.reset();
  }



  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/products');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Stack(
        children: <Widget>[
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF73AEF5),
                          Color(0xFF61A4F1),
                          Color(0xFF478DE0),
                          Color(0xFF398AE5),
                        ],
                        stops: [0.1, 0.4, 0.7, 0.9],
                      ),
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 80.0),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Email address',
                                    style: kLabelStyle,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: kBoxDecorationStyle,
                                    height: 60.0,
                                    child: TextFormField(
                                      onSaved: (val) => _email = val,
                                      autofocus: true,
                                      validator: (val) => !val.contains('@')
                                          ? 'Invalid email'
                                          : null,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'OpenSans'),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding:
                                              EdgeInsets.only(top: 14.0),
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Colors.white,
                                          ),
                                          hintText: 'Enter Email address',
                                          hintStyle: kHintTextStyle),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Enter Your Password',
                                    style: kLabelStyle,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    decoration: kBoxDecorationStyle,
                                    height: 60.0,
                                    child: TextFormField(
                                      obscureText: _obscureText,
                                      onSaved: (val) => _password = val,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'OpenSans'),
                                      decoration: InputDecoration(
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() =>
                                                  _obscureText = !_obscureText);
                                            },
                                            child: Icon(
                                              _obscureText
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.white,
                                            ),
                                          ),
                                          border: InputBorder.none,
                                          contentPadding:
                                              EdgeInsets.only(top: 14.0),
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Colors.white,
                                          ),
                                          hintText: 'Enter your Password',
                                          hintStyle: kHintTextStyle),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      children: <Widget>[
                                        FlatButton(
                                          onPressed: () =>
                                              Navigator.pushReplacementNamed(
                                                  context, '/signup'),
                                          padding: EdgeInsets.only(right: 0.0),
                                          child: Text(
                                            'Sign Up',
                                            style: kLabelStyle,
                                          ),
                                        ),
                                        FlatButton(
                                          onPressed: () => print('fuckoff'),
                                          padding: EdgeInsets.only(left: 120.0),
                                          child: Text(
                                            'Forgot Password',
                                            style: kLabelStyle,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        _isSubmitting == true
                                            ? CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Theme.of(context)
                                                            .primaryColor),
                                              )
                                            : RaisedButton(
                                                elevation: 5.0,
                                                onPressed: _submit,
                                                padding: EdgeInsets.all(15.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                color: Colors.white,
                                                child: Text(
                                                  'Login',
                                                  style: TextStyle(
                                                      color: Color(0xFF527DAA),
                                                      letterSpacing: 1.5,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'OpenSans'),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Center(
                                        child: Text(
                                          '- OR - ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        'Sign Up With',
                                        style: kLabelStyle,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 30.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        _buildsocialbtn(
                                            () => print("hello dude00"),
                                            AssetImage(
                                                'assets/images/facebook.jpg')),
                                        _buildsocialbtn(
                                            () => print("fuckoff"),
                                            AssetImage(
                                                'assets/images/google.jpg'))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildsocialbtn(Function onTap, AssetImage logo) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
        image: DecorationImage(
          image: logo,
        ),
      ),
    ),
  );
}