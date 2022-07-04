import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project1/SignUpScreen.dart';
import 'package:project1/input_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project1/user.dart';
import 'package:provider/provider.dart';

class Log_in extends StatefulWidget {
  @override
  _Log_inState createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {
  void _GoBack()
  {
    setState(() {
      Navigator.pushNamed(context, '/home');
    });
  }
  TextEditingController _passTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context , child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  hexStringToColor("#307CB4"),
                  hexStringToColor("#3966B2"),
                  hexStringToColor("#3B3DAB"),
                ]
                )
            ),
            child:  CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: SafeArea(
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CloseButton(
                              color: Colors.white,
                              onPressed: (){
                                setState(() {
                                  _GoBack();
                                });
                              },
                            ),
                          ],
                        ),
                        Text(
                          'Log into your account',
                          style: TextStyle(
                            fontSize: 33.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              reusableTextField("Email", IconData(0xe22a, fontFamily: 'MaterialIcons')
                                  ,false, _emailTextController),
                              SizedBox(height: 40.h),
                              reusableTextField("Password", Icons.lock_outline
                                  ,true, _passTextController),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: signInsignUpButton(context, true, (){
                              FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: _emailTextController.text, password: _passTextController.text).then((value)
                              {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => UserHome()));
                              }).onError((error, stackTrace) {
                                print("Error ${error.toString()}");
                              });
                            })),
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
                                      color: Colors.black87,
                                      fontSize: 18,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFFFFDD0),
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100.0),
                                      side: BorderSide(color: Colors.black54, width: 3),
                                    ) ,
                                  ),
                                )
                            )
                        ),
                        // fbSignIn(),
                        signUp(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        );
      }
    );
  }

  Row signUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.sp,
          ),
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}


