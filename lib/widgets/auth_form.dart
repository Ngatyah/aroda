import 'package:arodaparcel/screens/Admin_auth_Screen.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn);

  final void Function(String name, String phone, String code, String location) submitFn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isEnabled = false;
  bool _btnEnabled = false;
  bool _logDisabled = true;
  bool isAdmin = false;


  var _userName = '';
  var _userPhone = '';
  var _userCode = '';
  var _shopLocation = '';

  void _trySubmit() {
    final _isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      _formKey.currentState.save();
      widget.submitFn(_userName.trim(), _userPhone.trim(), _userCode.trim(),_shopLocation.trim());
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
            Colors.white
          ])),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Row(
            children: [
              Text("Sent with Love ",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              SizedBox(height: 5,),
              Icon(Icons.favorite_rounded, color: Colors.cyan[400],)
            ],
          ),
        ]),
      ),
          SizedBox(
            height: 30,
          ), 


          Expanded(
            child: SingleChildScrollView(
              child:Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(40),bottomLeft: Radius.circular(40))),
                
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    onChanged: () => setState(() => _btnEnabled = _formKey.currentState.validate()),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                            )
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            visible: _logDisabled,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[200]))),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty || value.length< 4) {

                                    return  'Enter Shop Name or Your Name';
                                  }

                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(hintText: 'Shop Name',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                ),

                                onSaved: (value) {
                                  _userName = value;
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _logDisabled,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[200]))),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty || value.length < 9) {

                                    return 'Enter +254...';

                                  }

                                  return null;
                                },

                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Phone Number',focusColor: Colors.white,
                                  hintStyle: TextStyle(color: Colors.grey),

                                ),
                                onSaved: (value) {
                                  _userPhone = value;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: _logDisabled,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[200]))),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {

                                    return  'Location';
                                  }

                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(hintText: 'Shop Location',
                                  hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                ),
                                onSaved: (value) {
                                  _shopLocation = value;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Visibility(
                            visible: _logDisabled,
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.orange[700]),
                              child: FlatButton(
                                minWidth: 200,
                                  child: Text( 'get Code', style: TextStyle(color: Colors.white),),

                                  onPressed:_btnEnabled ?(){
                                    setState(() {
                                      _logDisabled =false;
                                      _isEnabled = true;
                                      _trySubmit();
                                    });

                                  }
                                      :null),
                            ),
                          ),
                          Visibility(
                            visible: _isEnabled,
                            child: TextFormField(

                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Verification Code',
                              ),
                              obscureText: true,
                              onSaved: (value){
                                _userCode = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                            visible: _isEnabled,
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.orange[700]),
                              child: FlatButton(
                                minWidth: 200,

                                  onPressed: _trySubmit, child: Text('verify',style: TextStyle(color: Colors.white),)),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Divider(color: Colors.orange,),
                          Text('For Staffs Only', style: TextStyle(color: Colors.grey[600],), ),
                          SizedBox(height: 20,),
                           Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black),
                            child: FlatButton.icon(
                                minWidth: 200,
                                icon: Icon(Icons.switch_account,color: Colors.white,),

                                onPressed:(){
                                  setState(() {
                                    isAdmin = true;

                                  });
                                  Navigator.of(context).pushNamed(AdminAuthScreen.routeName);
                                }, label: Text('Admin Side', style: TextStyle(color: Colors.white,fontSize: 18
                            ),)),
                          ),
                          SizedBox(height: 20,),
                          Text('For Assist Call or Whatsapp: 0721 825 820'),
                          SizedBox(height: 10)


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),


    );
  }
}
