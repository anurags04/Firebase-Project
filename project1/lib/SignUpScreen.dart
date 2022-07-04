import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project1/input_string.dart';
import 'package:project1/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _firstName = TextEditingController();
  TextEditingController _passTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
              SliverFillRemaining(
              hasScrollBody: false,
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        hexStringToColor("#307CB4"),
                        hexStringToColor("#3966B2"),
                        hexStringToColor("#3B3DAB"),
                      ]
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create your Account',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.sp,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: reusableTextField('First name', IconData(0xe491, fontFamily: 'MaterialIcons'),
                            false, _firstName),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: reusableTextField("Email", IconData(0xe22a, fontFamily: 'MaterialIcons')
                            ,false,   _emailTextController),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child:  reusableTextField("Password", Icons.lock_outline
                            ,true, _passTextController),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: signInsignUpButton(context, false, () {
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: _emailTextController.text, password: _passTextController.text).then((value) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => UserHome()));
                          }).onError((error, stackTrace) {
                            print("Error ${error.toString()}");
                          });
                        }),
                      ),

                      divider(),
                      Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: Container(
                              width: 360.w,
                              height: 50.h,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  await FirebaseServices().signInWithGoogle();
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => UserHome()));
                                },
                                icon: Image.asset(
                                  'assets/images/google.png',
                                  width: 30,
                                  height: 30,
                                ),
                                label: Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color (0xFFFFFDD0),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                    side: BorderSide(color: Colors.black54, width: 3),
                                  ) ,
                                ),
                              )
                          )
                      ),
                      // fbSignIn(),
                    ],
                  ),
                )
              ),
              )
            ]
          )
        );
      }
    );
  }
}
