import 'package:flutter/material.dart';

class AdminAuthForm extends StatefulWidget {
  AdminAuthForm(this.submitFn, this.isLoading);

  final bool isLoading;

  final void Function(String email, String password, BuildContext context)
      submitFn;

  @override
  _AdminAuthFormState createState() => _AdminAuthFormState();
}

class _AdminAuthFormState extends State<AdminAuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange[900],
          Colors.orange[600],
          Colors.orange[400]
        ])),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Aroda Parcels",
                  style: TextStyle(color: Colors.white, fontSize: 48)),
              SizedBox(
                height: 10,
              ),
              Text("Welcome Back",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ]),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(40))),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                )
                              ]),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty ||
                                            !value.contains('@')) {
                                          return 'Enter valid Email Address';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Enter Email',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                      onSaved: (value) {
                                        _userEmail = value;
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty || value.length < 6) {
                                          return 'Enter 6 characters and above';
                                        }
                                        return null;
                                      },
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: true,
                                      decoration: InputDecoration(

                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                      onSaved: (value) {
                                        _userPassword = value;
                                      },
                                    ),
                                  )
                                ],
                              ))),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(color: Colors.grey),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      if (widget.isLoading) CircularProgressIndicator(),
                      if (!widget.isLoading)
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.orange[700]),
                          child: FlatButton(
                            minWidth: 200,
                            onPressed: _trySubmit,
                            child: Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}
