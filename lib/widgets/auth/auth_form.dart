import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      Scaffold.of(context).showSnackBar(SnackBar(
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
      child: Card(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _fomKey,
              child: Column(
                children: [
                  if (!_isLogin)
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      backgroundImage: _profileImage == null
                          ? null
                          : FileImage(_profileImage),
                    ),
                  if (!_isLogin)
                    FlatButton.icon(
                      icon: Icon(
                        Icons.image,
                        color: Theme.of(context).accentColor,
                      ),
                      label: Text(
                        'choose image!',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      onPressed: chooseImage,
                    ),
                  TextFormField(
                    key: ValueKey('Email'),
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    enableSuggestions: true,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (val) => _email = val,
                    validator: (val) {
                      if (!val.contains('@') || val.isEmpty)
                        return 'insert valid Email';
                      else
                        return null;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('UserName'),
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (val) => _userName = val,
                      validator: (val) {
                        if (val.isEmpty)
                          return 'UserName shouldn\'t be Empty ';
                        else
                          return null;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('Password'),
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (val) => _password = val,
                    validator: (val) {
                      if (val.length < 7 || val.isEmpty)
                        return 'password should be 7 characters at least';
                      else
                        return null;
                    },
                  ),
                  SizedBox(height: 20),
                  widget.isLoading
                      ? CircularProgressIndicator()
                      : RaisedButton(
                          color: Theme.of(context).accentColor,
                          onPressed: () => trySubmit(),
                          child: Text(_isLogin ? 'Login' : 'Sign up'),
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
                        style: TextStyle(color: Theme.of(context).accentColor),
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
