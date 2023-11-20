// ignore_for_file: sort_child_properties_last, deprecated_member_use, use_build_context_synchronously, prefer_const_constructors

import 'package:bus_tracking_app/Driver/Driver_Navigation.dart';
import 'package:bus_tracking_app/Login/SignupSelect.dart';
import 'package:bus_tracking_app/Login/stdregistration.dart';
import 'package:bus_tracking_app/Navigation/BottomNavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:bus_tracking_app/components/colors.dart';
import 'package:bus_tracking_app/components/constant.dart';

import '../Admin/Admin_DashBoard.dart';

class BHLoginScreen extends StatefulWidget {
  static String tag = '/LoginScreen';

  @override
  BHLoginScreenState createState() => BHLoginScreenState();
}

class BHLoginScreenState extends State<BHLoginScreen> {
  //final LocalStorage storage = new LocalStorage('localstorage_app');
  var _formKey = GlobalKey<FormState>();
  // final AuthService _auth =  AuthService();

  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  bool _showPassword = false;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();
  // ignore: non_constant_identifier_names
  String get BHFacebookIcon => 'asdas';

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // changeStatusColor(BHColorPrimary);
  }

  @override
  void dispose() {
    super.dispose();
    //  changeStatusColor(Colors.transparent);
    emailFocusNode.dispose();
    passWordFocusNode.dispose();
  }

//sign in email and address

  // Future<void> login() async {
  //   print(emailCont.text);
  //   print(passwordCont.text);

  //   var response = await http.post(
  //       Uri.parse('https://hostrelic.com/sys/wowonder/api/auth'),
  //       body: ({
  //         "username": emailCont.text,
  //         "password": passwordCont.text,
  //         'server_key':
  //             'e8b9080f72126d08d47d4ae7f9e660221494d2f7-0ca2f68eabb596f498371983a2b607ca-96710287',
  //         // 'type': 'get_news_feed'
  //       }));

  //   print(json.decode(response.body));

  //   var apistatus = json.decode(response.body)['api_status'];
  //   print(apistatus);

  //   if (apistatus == 200) {
  //     var access_token = json.decode(response.body)['access_token'];
  //     var id = json.decode(response.body)['user_id'];

  //     // print(access_token);
  //     // print(id);

  //     var response1 = await http.post(
  //         Uri.parse(
  //             'http://hostrelic.com/sys/wowonder/api/get-my-pages?access_token=${access_token}'),
  //         body: ({
  //           'server_key': server_key,
  //           'type': 'my_pages'
  //           // 'type': 'get_news_feed'
  //         }));

  //     // print(response1.body);
  //     var userdata = json.decode(response1.body)['data'];
  //     var apistatus1 = json.decode(response1.body)['api_status'];

  //     print(userdata);
  //     //  print(apistatus1);
  //     // print("Get data ");

  //     if (userdata.length > 0) {
  //       await storage.setItem("User_id", id);
  //       await storage.setItem("access_token", access_token);
  //       print("bussiness login");

  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text("Login As Bussiness"),
  //         backgroundColor: BHColorPrimary,
  //       ));

  //       BHBussinessDashedBoardScreen({}).launch(context);

  //     } else {
  //       await storage.setItem("User_id", id);
  //       await storage.setItem("access_token", access_token);
  //       print("Customer login");

  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text("Login As Customer",style: TextStyle(fontSize: 20),),
  //         backgroundColor: BHColorPrimary,

  //       ));
  //      // BHDashedBoardScreen({}).launch(context);
  //     }
  //     // print(userdata);
  //     // await   storage.setItem("User_id", id);
  //     // await   storage.setItem("access_token", access_token);
  //     //  BHDashedBoardScreen({}).launch(context);

  //   }

  //   //   var err_type = json.decode(response.body)['errors']['error_text'];
  //   // if(data == 200){
  //   //   print("ök");
  //   //    finish(context);
  //   //   //  BHDashedBoardScreen.launch(context);>
  //   //   Navigator.push(context,MaterialPageRoute(builder: (context)=>BHDashedBoardScreen()));

  //   //   // show alert
  //   //    }
  //   //    else if(data == 400){
  //   //      BHDashedBoardScreen.launch(context);

  //   //    }
  // }

  // if(data == "400"){
  //  print(response.statusCode);

  //   //show alert
  // }
  // else if(data =="200"){

  //     BHDashedBoardScreen.launch(context);
  // }

  login_user() async {
    var email = emailCont.text;
    var password = passwordCont.text;

    print(email);
    print(password);
    if (email == '') {
      Fluttertoast.showToast(
          msg: "Plz Enter Your  Email Address",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Color.fromARGB(255, 30, 6, 121),
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (password == '') {
      Fluttertoast.showToast(
          msg: "Plz Enter Your  Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Color.fromARGB(255, 30, 6, 121),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      try {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        print(user.user!.uid);

        var login_user;

        DatabaseReference userRef =
            FirebaseDatabase.instance.reference().child('Students');
        final data = await userRef
            .child(user.user!.uid)
            .once()
            .then((DatabaseEvent event) async {
          login_user = event.snapshot.value;

          if (login_user == null) {
            print("Not strd");
            DatabaseReference userRef1 =
                FirebaseDatabase.instance.reference().child('Drivers');
            final data = await userRef1
                .child(user.user!.uid)
                .once()
                .then((DatabaseEvent event) async {
              // print(event.snapshot.value);
              login_user = event.snapshot.value;
              final prefs = await SharedPreferences.getInstance();

              if (login_user == null) {
                print("Not admin");

                DatabaseReference userRef1 =
                    FirebaseDatabase.instance.reference().child('Admin');
                final data = await userRef1
                    .child(user.user!.uid)
                    .once()
                    .then((DatabaseEvent event) async {
                  print(event.snapshot.value);
                  login_user = event.snapshot.value;
                  if (login_user != null) {
                    print("Admin");
                    prefs.setString("Uid", login_user["userUid"]);
                    prefs.setString("User Name", login_user["username"]);
                    print(login_user["Role"]);

                    if (login_user["Role"] == "Driver") {
                      var data = await prefs.setString("Login_User", "Driver");
                      print(data);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Driver_Navigation()));
                    } else if (login_user["Role"] == "Student") {
                      var data = await prefs.setString("Login_User", "Student");
                      print(data);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBar()));
                    } else if (login_user["Role"] == "Admin") {
                      var data = await prefs.setString("Login_User", "Admin");
                      print(data);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => AdminHome()));
                    }
                  } else {
                    print("Not get");
                    // print("Not strd");
                  }
                });
              } else {
                prefs.setString("Uid", login_user["userUid"]);
                prefs.setString("User Name", login_user["username"]);
                print(login_user["Role"]);

                if (login_user["Role"] == "Driver") {
                  var data = await prefs.setString("Login_User", "Driver");
                  print(data);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Driver_Navigation()));
                } else if (login_user["Role"] == "Student") {
                  var data = await prefs.setString("Login_User", "Student");
                  print(data);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()));
                } else if (login_user["Role"] == "Admin") {
                  var data = await prefs.setString("Login_User", "Admin");
                  print(data);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => AdminHome()));
                }
              }
            });
          } else {
            final prefs = await SharedPreferences.getInstance();

            print("cal1");
            prefs.setString("Uid", login_user["userUid"]);
            prefs.setString("User Name", login_user["username"]);
            print(login_user["Role"]);
            if (login_user["Role"] == "Driver") {
              var data = await prefs.setString("Login_User", "Driver");
              print(data);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Driver_Navigation()));
            } else if (login_user["Role"] == "Student") {
              var data = await prefs.setString("Login_User", "Student");
              print(data);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => BottomNavBar()));
            } else if (login_user["Role"] == "Admin") {
              var data = await prefs.setString("Login_User", "Admin");
              print(data);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AdminHome()));
            }
          }

          // Obtain shared preferences.

          // print("call123");
          // final prefs = await SharedPreferences.getInstance();
          // prefs.setString("Uid", login_user["userUid"]);
          // prefs.setString("User Name", login_user["username"]);

          // if (login_user["Role"] == "Driver") {
          //   var data = await prefs.setString("Login_User", "Driver");
          //   print(data);
          //   Navigator.pushReplacement(context,
          //       MaterialPageRoute(builder: (context) => Driver_Navigation()));
          // } else if (login_user["Role"] == "Student") {
          //   var data = await prefs.setString("Login_User", "Student");
          //   print(data);
          //   Navigator.pushReplacement(context,
          //       MaterialPageRoute(builder: (context) => BottomNavBar()));
          // }
          //
        });
      } catch (e) {
        print(e.toString());
        Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Color.fromARGB(255, 30, 6, 121),
            textColor: Colors.white,
            fontSize: 16.0);
        // Widget okButton = TextButton(child: Text("OK"), onPressed:(){Navigator.pop(context);});

        // AlertDialog alert = AlertDialog(
        //   title: Center(child: Text("Login Error ")),
        //   // ignore: unnecessary_string_interpolations
        //   content: Text("${e.toString()}"),
        //   actions: [
        //     okButton,
        //   ],
        // );

        // return showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return alert;
        //   },
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: BHColorPrimary,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 0),
            // height: 500,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  // margin: EdgeInsets.only(top: 30),
                  child: Center(
                      child: const Text(
                    'SAU BUS TRACKER',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 4, 2, 122),
                    ),
                  )
                      // child: Image.asset("a"),
                      ),

                  width: MediaQuery.of(context).size.width,
                  height: 100,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Center(
                    child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/learner-app-e457c.appspot.com/o/SAUTransport-removebg-preview.png?alt=media&token=01410e99-de51-4b9c-9834-33e614649c78',
                      height: 100,
                      width: 400,
                      // color:
                      //     Color.fromARGB(255, 185, 181, 181).withOpacity(0.9),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: TextFormField(
                    controller: emailCont,
                    focusNode: emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(passWordFocusNode);
                    },
                    style: primaryTextStyle(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // enabledBorder: UnderlineInputBorder(
                      //     borderSide: BorderSide(color: BHAppDividerColor)),
                      // focusedBorder: UnderlineInputBorder(
                      //     borderSide: BorderSide(color: BHColorPrimary)),
                      labelText: " Email",
                      labelStyle: TextStyle(color: BHGreyColor, fontSize: 14),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 4, 72, 128),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: passwordCont,
                  focusNode: passWordFocusNode,
                  obscureText: !_showPassword,
                  keyboardType: TextInputType.text,
                  style: primaryTextStyle(),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: BHGreyColor, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.key,
                      color: Color.fromARGB(255, 4, 72, 128),
                    ),
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
                          color: Color.fromARGB(255, 4, 72, 128),
                          size: 20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: const Text(BHTxtForgetPwd,
                          style: TextStyle(color: Colors.blue, fontSize: 14))
                      .onTap(
                    () {
                      //    ForgotPasswordScreen().launch(context);
                    },
                  ),
                ),
                40.height,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(17),
                      // ignore: deprecated_member_use
                      primary: Color.fromARGB(255, 4, 72, 128),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    onPressed: () async {
                      login_user();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar()));
                    },
                    child: const Text(
                      BHBtnSignIn,
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                16.height,
                12.height,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text.rich(
                        TextSpan(
                            text: 'Dont you Have and accoount?',
                            style: TextStyle(color: Colors.black)),
                      ).onTap(
                        () {
                          //  BHRegistrationScreen().launch(context);
                        },
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      const Text.rich(
                        TextSpan(
                            text: BHBtnSignUp,
                            style: TextStyle(color: Colors.blue)),
                      ).onTap(
                        () {
                          BHRegistrationScreen().launch(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
