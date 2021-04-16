import 'package:flutter/material.dart';
import 'package:ht/services/ProgressHUD.dart';
import 'package:ht/services/api_service.dart';
import 'package:ht/untils/from_helper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String _username = "";
  String _pwd = "";
  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        key: _scaffoldkey,
        body: ProgressHUD(
          child: _loginUISetup(context),
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
        ),
      ),
    );
  }

  Widget _loginUISetup(BuildContext context) {
    return new SingleChildScrollView(
      child: new Container(
        child: new Form(
          key: globalFormKey,
          child: _loginUI(context),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3.5,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blueAccent[400],
                    Colors.lightBlue[200],
                  ]),
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(180))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Spacer(),
              Align(
                alignment: Alignment.center,
                child: Image.network(
                  "https://flagdownload.com/wp-content/uploads/Emblem_of_Turkish_Republic_of_Northern_Cyprus-128x138.png",
                  fit: BoxFit.contain,
                  width: 125,
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20, top: 40),
            child: Text(
              "Giriş Yap",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: FromHelper.inputFieldWidget(
            context,
            Icon(Icons.verified_user),
            "username",
            "Okul Numarası",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Okul Numaranı Boş Bırakamazsın";
              }

              return null;
            },
            (onSavedValue) {
              _username = onSavedValue.toString().trim();
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: FromHelper.inputFieldWidget(
              context, Icon(Icons.lock), "password", "Şifre", (onValidateVal) {
            if (onValidateVal.isEmpty) {
              return "Şifreni Boş Bırakamazsın";
            }
            return null;
          }, (onSavedValue) {
            _pwd = onSavedValue.toString().trim();
          },
              initialValue: "",
              obscureText: hidePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
                color: Colors.blueGrey.withOpacity(0.4),
                icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility),
              )),
        ),
        SizedBox(
          height: 20,
        ),
        new Center(
          child: FromHelper.saveButton(
            "Giriş Yap",
            () {
              if (validateAndSave()) {
                print("Okul Numarası: $_username");
                print("Şifre: $_pwd");

                setState(() {
                  this.isApiCallProcess = true;
                });

                APIServices.loginCustomer(_username, _pwd).then((response) {
                  setState(() {
                    this.isApiCallProcess = false;
                  });
                  print(response);
                });
              }
            },
          ),
        )
      ],
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
