// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_is_empty

import 'dart:convert';
import 'dart:math';

import 'package:bus_tracking_app/Login/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:bus_tracking_app/components/colors.dart';
import 'package:bus_tracking_app/components/constant.dart';
// import 'package:bus_tracking_app/screens/EAHomeScreen.dart';

class BHRegistrationScreen extends StatefulWidget {
  static String tag = '/NewRegistrationScreen';

  @override
  NewRegistrationScreenState createState() => NewRegistrationScreenState();
}

class NewRegistrationScreenState extends State<BHRegistrationScreen> {
  bool _showPassword = false;
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ConfirmPas = TextEditingController();

  // ignore: non_constant_identifier_names
  TextEditingController ContactNo = TextEditingController();
  TextEditingController fullNameCont = TextEditingController();
  TextEditingController YearCont = TextEditingController();
  TextEditingController BatchCont = TextEditingController();
  TextEditingController bussinessemailCont = TextEditingController();
  TextEditingController bussinespasswordCont = TextEditingController();
  TextEditingController bussinessConfirmPas = TextEditingController();
  TextEditingController bussinessContactNo = TextEditingController();
  TextEditingController bussinessfullNameCont = TextEditingController();
  TextEditingController bussinessdateOfBirthCont = TextEditingController();
  TextEditingController bussinessaddressCont = TextEditingController();
  var register = "Customer";
  var _formKey = GlobalKey<FormState>();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode dobFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode contactNoFocusNode = FocusNode();
  FocusNode ConfirmPasNode = FocusNode();

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  FocusNode bussinessfullNameFocusNode = FocusNode();
  FocusNode bussinesspasswordFocusNode = FocusNode();
  FocusNode bussinessemailFocusNode = FocusNode();
  FocusNode bussinessdobFocusNode = FocusNode();
  FocusNode bussinessaddressFocusNode = FocusNode();
  FocusNode bussinesscontactNoFocusNode = FocusNode();
  FocusNode bussinessConfirmFocusNode = FocusNode();

  String get BHBarCodeImg => "jskajdds";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  DatabaseReference userRef =
      FirebaseDatabase.instance.reference().child('Students');

  @override
  void dispose() {
    super.dispose();
    fullNameFocusNode.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    dobFocusNode.dispose();
    addressFocusNode.dispose();
    ConfirmPasNode.dispose();
    bussinessfullNameFocusNode.dispose();
    bussinesspasswordFocusNode.dispose();
    bussinessemailFocusNode.dispose();
    bussinessdobFocusNode.dispose();
    bussinessaddressFocusNode.dispose();
    bussinessConfirmFocusNode.dispose();
  }

  // Future<String> registerUser(String email, String password) async {
  //   User user;
  //   try {
  //     UserCredential userCredential = await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     user = userCredential.user!;
  //   } catch (e) {}
  //   return e.toString();
  // }

  // _signUP() async {
  //   var valid = _formKey.currentState!.validate();
  //   User user;
  //   if (!valid) {
  //     return;
  //   } else {
  //     user = (await registerUser(emai            lCont.text, passwordCont.text)) as User;
  //     // ignore: unnecessary_null_comparison
  //     if (user != null) {
  //       FirebaseFirestore.instance.collection('users').add({
  //         'name': fullNameCont.text,
  //         'email': emailCont.text,
  //         'password': passwordCont.text
  //       }).then((value) {
  //       //  print(value);
  //         if (value != null) {
  //    ForgotPasswordScreen().launch(context);
  //         }
  //       });
  //     }
  //   }
  // }

  std_regsister() async {
    var name = fullNameCont.text;
    var email = emailCont.text;
    var password = passwordCont.text;
    var confirm = ConfirmPas.text;

    var year = YearCont.text;
    var Contact = ContactNo.text;

    if (name.length > 0 &&
        email.length > 0 &&
        password.length > 0 &&
        confirm.length > 0 &&
        year.length > 0 &&
        Contact.length > 0) {
      if (password != confirm) {
        Fluttertoast.showToast(
            msg: "Password Not Match",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 30, 6, 121),
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        try {
          UserCredential userCredential = await _auth
              .createUserWithEmailAndPassword(email: email, password: password);
          String User_Uid = userCredential.user!.uid;
          print(userCredential.user);

          //  String User_Uid = userCredential.user!.uid;
          print(userCredential.user);

          var obj = {
            "email": email,
            "username": name,
            "password": password,
            "userUid": User_Uid,
            "Year": year,
            "Phone_Number": Contact,
            "Role": "Student"
          };
          await userRef.child(User_Uid).set(obj);

          Fluttertoast.showToast(
              msg: "Student Regsister",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromARGB(255, 30, 6, 121),
              textColor: Colors.white,
              fontSize: 16.0);

          // ignore: use_build_context_synchronously
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BHLoginScreen()));
        } catch (e) {
          Fluttertoast.showToast(
              msg: e.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromARGB(255, 30, 6, 121),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: "Enter All Data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 30, 6, 121),
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Container(
        color: Color.fromARGB(255, 224, 223, 223),
        child: Column(children: [
          Container(
            child: Image.asset("images/std.png"),
            height: 400,
            margin: EdgeInsets.only(
                // top: 50,
                // left: MediaQuery.of(context).size.width * 0.35,
                // right: MediaQuery.of(context).size.width * 0.32

                ),
            color: Color.fromARGB(255, 224, 223, 223),
            // width: 100.0,
            // height: 100,
          ),

          //  15.height,
          //  const Center(child: Text("Registrazione")),
          Container(
            // margin: const EdgeInsets.only(top: 100),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50)),
                color: Color.fromARGB(255, 252, 251, 251)),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          "Student Register ",
                          style: TextStyle(
                              color: Color(0xff140967),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: fullNameCont,
                          // focusNode: fullNameFocusNode,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(passwordFocusNode);
                          },
                          style: primaryTextStyle(),
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: BHAppDividerColor)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: BHColorPrimary)),
                            labelText: "User Name",
                            labelStyle: secondaryTextStyle(),
                            suffixIcon: GestureDetector(
                              // onTap: () {
                              //   setState(() {
                              //     _showPassword = !_showPassword;
                              //   });
                              // },
                              child: const Icon(Icons.person_add,
                                  color: Color(0xff140967), size: 20),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: YearCont,
                          // focusNode: emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            // FocusScope.of(context).requestFocus(dobFocusNode);
                          },
                          style: primaryTextStyle(),
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: BHAppDividerColor)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: BHColorPrimary)),
                            labelText: "Reg No : ",
                            labelStyle: secondaryTextStyle(),
                            suffixIcon: const Icon(
                                Icons.app_registration_outlined,
                                color: Color(0xff140967),
                                size: 18),
                          ),
                        ),

                        TextFormField(
                          controller: ContactNo,
                          // focusNode: addressFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          style: primaryTextStyle(),
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: BHAppDividerColor)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: BHColorPrimary)),
                            labelText: "Phone Number",
                            suffixIcon: const Icon(Icons.phone,
                                color: Color(0xff140967), size: 18),
                            labelStyle: secondaryTextStyle(),
                          ),
                        ),
                        TextFormField(
                          controller: emailCont,
                          // focusNode: fullNameFocusNode,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(passwordFocusNode);
                          },
                          style: primaryTextStyle(),
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: BHAppDividerColor)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: BHColorPrimary)),
                            labelText: "Email",
                            labelStyle: secondaryTextStyle(),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: const Icon(Icons.email,
                                  color: Color(0xff140967), size: 20),
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: passwordCont,
                          focusNode: passwordFocusNode,
                          obscureText: !_showPassword,
                          keyboardType: TextInputType.text,
                          style: primaryTextStyle(),
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: secondaryTextStyle(),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color(0xff140967),
                                  size: 20),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: BHAppDividerColor)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: BHColorPrimary)),
                          ),
                        ),
                        TextFormField(
                          controller: ConfirmPas,
                          focusNode: ConfirmPasNode,
                          obscureText: !_showPassword,
                          keyboardType: TextInputType.text,
                          style: primaryTextStyle(),
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            labelStyle: secondaryTextStyle(),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color(0xff140967),
                                  size: 20),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: BHAppDividerColor)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: BHColorPrimary)),
                          ),
                        ),

                        // TextFormField(
                        //   controller:BatchCont,
                        //   // focusNode: emailFocusNode,
                        //   keyboardType: TextInputType.emailAddress,
                        //   textInputAction: TextInputAction.next,
                        //   onFieldSubmitted: (value) {
                        //     // FocusScope.of(context).requestFocus(dobFocusNode);
                        //   },
                        //   style: primaryTextStyle(),
                        //   decoration: InputDecoration(
                        //     enabledBorder: const UnderlineInputBorder(
                        //         borderSide: BorderSide(color: BHAppDividerColor)),
                        //     focusedBorder: const UnderlineInputBorder(
                        //         borderSide: BorderSide(color: BHColorPrimary)),
                        //     labelText: "Year",
                        //     labelStyle: secondaryTextStyle(),
                        //     suffixIcon: const Icon(Icons.timelapse_sharp,
                        //            color: Color(0xff140967), size: 18),
                        //   ),
                        // ),
                        // TextFormField(
                        //   controller: dateOfBirthCont,
                        //   keyboardType: TextInputType.datetime,
                        //   focusNode: dobFocusNode,
                        //   textInputAction: TextInputAction.next,
                        //   onFieldSubmitted: (value) {
                        //     FocusScope.of(context).requestFocus(addressFocusNode);
                        //   },
                        //   style: primaryTextStyle(),
                        //   decoration: InputDecoration(
                        //     enabledBorder: const UnderlineInputBorder(
                        //         borderSide: BorderSide(color: BHAppDividerColor)),
                        //     focusedBorder: const UnderlineInputBorder(
                        //         borderSide: BorderSide(color: BHColorPrimary)),
                        //     labelText: "Country",
                        //     suffixIcon: const Icon(Icons.home_max,
                        //            color: Color(0xff140967), size: 18),
                        //     // suffixIcon: GestureDetector(
                        //     //   onTap: () {
                        //     //     showDatePicker(
                        //     //         context: context,
                        //     //         initialDate: DateTime.now(),
                        //     //         firstDate: DateTime(2014, 8),
                        //     //         lastDate: DateTime(2101));
                        //     //   },
                        //     //   child: const Icon(Icons.calendar_today,
                        //     //       color: BHColorPrimary, size: 16),
                        //     // ),
                        //     labelStyle: secondaryTextStyle(),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(17),
                        primary: Color(0xff140967),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      onPressed: () {
                        std_regsister();
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  12.height,
                  // 24.height,
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BHLoginScreen()));
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: BHTxtAccount,
                          style: TextStyle(color: BHAppTextColorSecondary),
                          children: <TextSpan>[
                            TextSpan(
                                text: BHBtnSignIn,
                                style: TextStyle(
                                  color: Color(0xff140967),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  // 8.height,
                ],
              ),
            ),
          ),

          // const BackButton(color: Colors.white),
        ]),
      ),
    )));
  }

//   Future<void> logins() async {
//     if (passwordCont.text.isNotEmpty && emailCont.text.isNotEmpty) {
//       var response = await http.post(
//           Uri.parse("https://hostrelic.com/sys/wowonder/api/create-account'"),
//           body: ({
//             'name': fullNameCont.text,
//             'email': emailCont.text,
//             'password': passwordCont.text,
//             'server_key':
//                 '0173e2128db8a97b9e375dfb3c731de728fd5611-ec0acfc09ee7c3e289c855741382d18f-85844002'
//           }));

//       if (response.statusCode == 200) {
//         // Navigator.push(context, MaterialPageRoute(builder: (context)=> BHDashedBoardScreen()
// //        BHDashedBoardScreen({}).launch(context);
//         ;
//       } else {
//         // ignore: use_build_context_synchronously
//         ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text("Invalid")));
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Black Field Not Allowed")));
//     }
//   }

//   void registerUsers() async {
//     var url = "https://hostrelic.com/sys/wowonder/api/create-account";
//     var data = {
//       "username": fullNameCont.text,
//       "email": emailCont.text,
//       "password": passwordCont.text,
//       'server_key':
//           '0173e2128db8a97b9e375dfb3c731de728fd5611-ec0acfc09ee7c3e289c855741382d18f-85844002'
//     };

//     var body = json.encode(data);
//     var urlParse = Uri.parse(url);
//     http.Response responses = await http.post(urlParse,
//         body: body, headers: {"Content-Type": "application/json"});
//     var datas = jsonDecode(responses.body);

// // Response response = await http.post(
// //   urlParse,
// //   body: body,
// //   headers: {
// //     "Content-Type": "application/json"
// //   }
// // );

// // var data = jsonDecode(response.body);
//   }
}
