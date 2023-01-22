// ignore_for_file: prefer_const_constructors

import 'package:bus_tracking_app/Admin/Admin_DashBoard.dart';
import 'package:bus_tracking_app/components/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Login/loginscreen.dart';

class AddDriver extends StatefulWidget {
  const AddDriver({super.key});

  @override
  State<AddDriver> createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {
  bool _showPassword = false;
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ConfirmPas = TextEditingController();
  TextEditingController Phonenumber = TextEditingController();
  TextEditingController cnicNumber = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ContactNo = TextEditingController();
  TextEditingController fullNameCont = TextEditingController();
  TextEditingController dateOfBirthCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();
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


 _signUP() async {
    print("call");
    // var valid = _formKey.currentState!.validate();
    var name = fullNameCont.text;
    var email = emailCont.text;
    var password = passwordCont.text;
    var Confirm = ConfirmPas.text;
    var addr = addressCont.text;
    var phone = Phonenumber.text;
    var cnic = cnicNumber.text;
    User user;
    print(name);
    if (name.length != 0 &&
        email.length != 0 &&
        password.length != 0 &&
        addr.length != 0 &&
        phone.length != 0 &&
        cnic.length != 0 &&
        Confirm.length != 0) {
      if (password != Confirm) {
        Fluttertoast.showToast(
            msg: "Password Not Match",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 30, 6, 121),
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        try{
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        String User_Uid = userCredential.user!.uid;
        print(userCredential.user);

         var obj = {
          "email": email,
          "username": name,
          "password": password,
          "userUid": User_Uid,
          "address": addr,
          "Contact_No":phone,
          "Cnic":cnic,
          "Role":"Driver"
          
        };
         await userRef.child(User_Uid).set(obj);
         Fluttertoast.showToast(
            msg: "Driver Add Succefully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Color.fromARGB(255, 30, 6, 121),
            textColor: Colors.white,
            fontSize: 16.0);

           fullNameCont.text="";
   emailCont.text="";
    passwordCont.text="";
   ConfirmPas.text="";
   addressCont.text="";
   Phonenumber.text="";
    cnicNumber.text="";
    setState(() {
      
    });
        

        // print(user);
        }
        catch(e){
           Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Color.fromARGB(255, 30, 6, 121),
            textColor: Colors.white,
            fontSize: 16.0);
        }

        }
    } else {
      print("ca");
      Fluttertoast.showToast(
          msg: "Please Enter All Data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Color.fromARGB(255, 30, 6, 121),
          textColor: Colors.white,
          fontSize: 16.0);
      // ignore: unnecessary_null_comparison
      // if (user != null) {

      //     FirebaseFirestore.instance.collection('users').add({
      //       'name': fullNameCont.text,
      //       'email': emailCont.text,
      //       'password': passwordCont.text
      //     }).then((value) {
      //     //  print(value);
      //       if (value != null) {
      //  ForgotPasswordScreen().launch(context);
      //       }
      //     });
      // }
    }
  }



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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference userRef =
      FirebaseDatabase.instance.reference().child('Drivers');


      

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Container(
              width: 300.0,
              height: 500.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                    "images/st2.jfif"),
                // fit: BoxFit.cover
              )),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // IconButton(
                  //   icon: Icon((Icons.supervised_user_circle_rounded)),
                  //   color: Colors.white,
                  //   iconSize: 60,
                  //   onPressed: () {},
                  // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   ("User"),
                      //   style: TextStyle(color: Color.fromARGB(255, 219, 25, 51),fontSize: 30),
                      // ),
                      // Text(
                      //   ("User@gmail.com"),
                      //   style: TextStyle(color: Colors.white),
                      // )
                    ],
                  )
                ],
              )),
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  child: (Row(
                    children: <Widget>[
                      // ...
                      Expanded(
                        child: Column(
                          children: <Widget>[
                         
                            Divider(color: Colors.black)
                          ],
                        ),
                      )
                    ],
                  )),
                ),

                GestureDetector(onTap:(){
                  Navigator.pop(context);
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=>AdminHome()));
                },
                child:  ListTile(
                  leading:   IconButton(
                    icon: Icon((Icons.home)),
                    color: Color.fromARGB(255, 57, 1, 129),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  title: Text("Home")
                
                ),
                ),
              
               
                 GestureDetector(onTap:(){
                  Navigator.pop(context);
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=>AddDriver()));
                },
                child:  ListTile(
                  leading:   IconButton(
                    icon: Icon((Icons.bus_alert_sharp)),
                     color: Color.fromARGB(255, 57, 1, 129),
                    onPressed: () {

                    },
                  ),
                  title: Text("Add Driver")
                
                ),
                ),
                
                // ListTile(
                //   leading:   IconButton(
                //     icon: Icon((Icons.app_blocking_rounded)),
                //     color: Colors.red,
                //     iconSize: 30,
                //     onPressed: () {},
                //   ),
                //   title: Text("About")
                
                // ),

                 ListTile(
                  leading:   IconButton(
                    icon: Icon((Icons.settings_sharp)),
                     color: Color.fromARGB(255, 57, 1, 129),
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  title: Text("Setting")
                
                ),
                GestureDetector(
                    onTap: () async {
                       final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.clear();
                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BHLoginScreen()));
                    },
                     child: ListTile(
                                     leading:   IconButton(
                      icon: Icon((Icons.login_outlined)),
                        color: Color.fromARGB(255, 57, 1, 129),
                      iconSize: 30,
                      onPressed: () {},
                                     ),
                                     title: Text("Log Out")
                                   
                                   ),
                   ),
                

               
              ],
            ),
            // GestureDetector(onTap: (){},child:ListTile(title:Text("hello"))),  //GestureDetector used for Drawer move one page to other
          ],
        ),
      ),
     appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 11, 1, 102)),
        backgroundColor: Colors.white,
        centerTitle: true,
        
        // ignore: prefer_const_constructors
        title: Text("Add Driver" ,style: TextStyle(fontSize: 22,
              fontWeight: FontWeight.bold,
                color: Color(0xff140967),),)),
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(1),
                  padding: EdgeInsets.all(1),
                  child: Card(
                    elevation: 40,
                    shadowColor: Colors.grey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Text(
                                "Driver Register ",
                                style: TextStyle(
                                    color: Color(0xff140967),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              )),
                                  
                              TextFormField(
                                controller: fullNameCont,
                                focusNode: fullNameFocusNode,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(passwordFocusNode);
                                },
                                style: primaryTextStyle(),
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: BHAppDividerColor)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: BHColorPrimary)),
                                  labelText: "Name",
                                  labelStyle: secondaryTextStyle(),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      // setState(() {
                                      //   _showPassword = !_showPassword;
                                      // });
                                    },
                                    child: const Icon(Icons.person,
                                        color: Color(0xff140967), size: 20),
                                  ),
                                ),
                              ),
                                  
                               SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: cnicNumber,
                                // focusNode: addressFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                style: primaryTextStyle(),
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: BHAppDividerColor)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: BHColorPrimary)),
                                  labelText: "Cnic Number",
                                  suffixIcon: const Icon(Icons.nine_mp_outlined,
                                      color: Color(0xff140967), size: 18),
                                  labelStyle: secondaryTextStyle(),
                                ),
                              ),
                               SizedBox(
                                height: 15,
                              ),
                                  
                              TextFormField(
                                controller: Phonenumber,
                                // focusNode: addressFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                style: primaryTextStyle(),
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: BHAppDividerColor)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: BHColorPrimary)),
                                  labelText: "Phone Number",
                                  suffixIcon: const Icon(Icons.phone,
                                      color: Color(0xff140967), size: 18),
                                  labelStyle: secondaryTextStyle(),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                                TextFormField(
                                controller: addressCont,
                                focusNode: addressFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.multiline,
                                style: primaryTextStyle(),
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: BHAppDividerColor)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: BHColorPrimary)),
                                  labelText: "Address",
                                  suffixIcon: const Icon(Icons.location_on,
                                      color: Color(0xff140967), size: 18),
                                  labelStyle: secondaryTextStyle(),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: emailCont,
                                focusNode: emailFocusNode,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(passwordFocusNode);
                                },
                                style: primaryTextStyle(),
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: BHAppDividerColor)),
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
                             
                                  
                              
                              SizedBox(
                                height: 15,
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
                                      borderSide: BorderSide(color: BHAppDividerColor)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: BHColorPrimary)),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                                  
                              TextFormField(
                                controller: ConfirmPas,
                                focusNode: ConfirmPasNode,
                                obscureText: !_showPassword,
                                keyboardType: TextInputType.text,
                                style: primaryTextStyle(),
                                decoration: InputDecoration(
                                  labelText: "Confrim Password",
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
                                      borderSide: BorderSide(color: BHAppDividerColor)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(color: BHColorPrimary)),
                                ),
                              ),
                              // TextFormField(
                              //   controller: emailCont,
                              //   focusNode: emailFocusNode,
                              //   keyboardType: TextInputType.emailAddress,
                              //   textInputAction: TextInputAction.next,
                              //   onFieldSubmitted: (value) {
                              //     FocusScope.of(context).requestFocus(dobFocusNode);
                              //   },
                              //   style: primaryTextStyle(),
                              //   decoration: InputDecoration(
                              //     enabledBorder: const UnderlineInputBorder(
                              //         borderSide: BorderSide(color: BHAppDividerColor)),
                              //     focusedBorder: const UnderlineInputBorder(
                              //         borderSide: BorderSide(color: BHColorPrimary)),
                              //     labelText: "State",
                              //     labelStyle: secondaryTextStyle(),
                              //     suffixIcon: const Icon(Icons.home,
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
                              SizedBox(
                                height: 15,
                              ),
                            
                                  
                                  
                             
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
                              // print('hassm');
                              // EAHomeScreen().launch(context);
                              _signUP();
                              //  customerregisters();
                              //registerUsers();
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
                        //    Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   child: ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //       padding: EdgeInsets.all(12),
                        //       primary: BHColorPrimary,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(10.0)),
                        //     ),
                        //     onPressed: () {
                        //       print("Ok");
                        //     bussinessregisters();
                        //      //registerUsers();
                        //     },
                        //     child: Text(
                        //       "BUSSINESS REGSISTER",
                        //       style: TextStyle(
                        //           color: whiteColor,
                        //           fontSize: 15,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //   ),
                        // )
                        12.height,
                        // 24.height,
                        // Align(
                        //   alignment: Alignment.bottomCenter,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       // EAHomeScreen();
                        //       // bussinessregisters() ;
                        //       // finish(context);
                                
                        //       Navigator.push(context, MaterialPageRoute(builder: (context)=>BHLoginScreen()));
                        //     },
                        //     child: const Text.rich(
                        //       TextSpan(
                        //         text: BHTxtAccount,
                        //         style: TextStyle(color: BHAppTextColorSecondary),
                        //         children: <TextSpan>[
                        //           TextSpan(
                        //               text: BHBtnSignIn,
                        //               style: TextStyle(
                        //                 color: Color(0xff140967),
                        //               ))
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // 8.height,
                      ],
                    ),
                  ),
                ),
              ),
        ));
  }
}