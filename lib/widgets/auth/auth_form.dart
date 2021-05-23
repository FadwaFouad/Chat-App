import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:Chat/utils/constants.dart' as cons;

class AuthForm extends StatefulWidget {
  final Function saveForm;
  final isLoading;
  AuthForm(this.saveForm, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isLogin = true;
  final _fomKey = GlobalKey<FormState>();
  var _password = '';
  var _userName = '';
  var _email = '';
  File _profileImage;

  void chooseImage() async {
    final image = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _profileImage = File(image.path);
    });
  }

  void trySubmit() {
    if (!_fomKey.currentState.validate()) return;
    FocusScope.of(context).unfocus();
    if (_profileImage == null && !_isLogin)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('please choose image!'),
      ));
    _fomKey.currentState.save();
    widget.saveForm(
      _userName.trim(),
      _password.trim(),
      _email.trim(),
      _isLogin,
      context,
      _profileImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _isLogin ? 'Login' : 'Sign UP',
              style: cons.titleTextStyle,
            ),
            SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _fomKey,
                  child: Column(
                    children: [
                      if (!_isLogin)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey.withOpacity(0.4),
                              backgroundImage: _profileImage == null
                                  ? null
                                  : FileImage(_profileImage),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FlatButton.icon(
                              icon: Icon(
                                Icons.image,
                                color: cons.indigo,
                              ),
                              label: Text(
                                'choose image!',
                                style: TextStyle(
                                  color: cons.indigo,
                                ),
                              ),
                              onPressed: chooseImage,
                            ),
                          ],
                        ),
                      if (!_isLogin)
                        SizedBox(
                          height: 30,
                        ),
                      Container(
                        decoration: cons.inputDecor,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          key: ValueKey('Email'),
                          textCapitalization: TextCapitalization.none,
                          autocorrect: false,
                          enableSuggestions: true,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            hintText: 'Email',
                            icon: Icon(
                              Icons.email,
                              color: cons.colorPurpleLight,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (val) => _email = val,
                          validator: (val) {
                            if (!val.contains('@') || val.isEmpty)
                              return 'insert valid Email';
                            else
                              return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      if (!_isLogin)
                        Container(
                          decoration: cons.inputDecor,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            key: ValueKey('UserName'),
                            decoration: InputDecoration(
                              hintText: 'Username',
                              isCollapsed: true,
                              icon: Icon(
                                Icons.account_circle_sharp,
                                color: cons.colorPurpleLight,
                              ),
                            ),
                            onSaved: (val) => _userName = val,
                            validator: (val) {
                              if (val.isEmpty)
                                return 'UserName shouldn\'t be Empty ';
                              else
                                return null;
                            },
                          ),
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: cons.inputDecor,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          key: ValueKey('Password'),
                          decoration: InputDecoration(
                              hintText: 'Password',
                              isCollapsed: true,
                              icon: Icon(
                                Icons.vpn_key,
                                color: cons.colorPurpleLight,
                              )),
                          obscureText: true,
                          onSaved: (val) => _password = val,
                          validator: (val) {
                            if (val.length < 7 || val.isEmpty)
                              return 'password should be 7 characters at least';
                            else
                              return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      widget.isLoading
                          ? CircularProgressIndicator()
                          : InkWell(
                              onTap: trySubmit,
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  gradient: cons.colorGradiant,
                                  borderRadius: BorderRadius.circular(30),
                                ),

                                //  onPressed: () => trySubmit(),
                                child: Text(
                                  _isLogin ? 'Login' : 'Sign up',
                                  style: cons.buttonTextStyle,
                                ),
                              ),
                            ),
                      SizedBox(height: 5),
                      if (!widget.isLoading)
                        FlatButton(
                          onPressed: () => setState(() {
                            _isLogin = !_isLogin;
                          }),
                          child: Text(
                            _isLogin
                                ? 'creat new account'
                                : 'hava an account ? Login',
                            style: TextStyle(color: cons.indigo),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
