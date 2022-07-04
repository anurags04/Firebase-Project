import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project1/user.dart';

Image logoWidget(String imageName)
{
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240.w,
    height: 240.h,
    color: Colors.white,
  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(prefixIcon: Icon(icon, color: Colors.white,),
      labelText: text,
      labelStyle: TextStyle(color: Colors.grey),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Color (0xFFD0EAFF),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Row divider()
{
  return  Row(
    children: [
      const Expanded(child: Divider()),
      Text(
        'OR',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16.sp,
        ),
      ),
      const Expanded(child: Divider()),
    ],
  );
}
    Container signInsignUpButton(BuildContext context, bool isLogin, Function onTap) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.h,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: ElevatedButton(
        onPressed: (){
          onTap();
        },
        child: Text(
          isLogin ? 'Log In' : 'Sign Up',
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.black,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if(isLogin){
              return Color (0xFFD0D2FF);
            }
            return Color (0xFFD0D2FF);
          }
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder> (
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          )
        ),
      ),
    );
  }

Padding fbSignIn ()
{
  return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Container(
          width: 360.w,
          height: 50.h,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/fb.jpg',
              width: 30,
              height: 30,
            ),
            label: Text(
              'Continue with Facebook',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF4267B2),
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
                // side: BorderSide(color: Colors.black54, width: 3),
              ),
            ),
          )
      )
  );
}

class FirebaseServices{
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if(googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
        );
        await _auth.signInWithCredential(authCredential);
      }
    }
    on FirebaseAuthException catch (e)
    {
      print(e.message);
      throw (e);
    }
  }

  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if(hexColor.length == 6){
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}