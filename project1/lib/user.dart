import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project1/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project1/input_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late YoutubePlayerController controller;

  @override
  void initState(){
    super.initState();

    const url = 'https://www.youtube.com/watch?v=5mLnuCORMrU';

    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        mute: false,
        loop: false,
        autoPlay: true,
      )
    );
  }


  @override
  Widget build(BuildContext context) => YoutubePlayerBuilder(
    player: YoutubePlayer(controller: controller,),
    builder: (context, player) => Scaffold(
      // backgroundColor: Color(0xFF3B3DAB),
      appBar: AppBar(
        backgroundColor: Color(0xFF004D4D),
        title: Text(
            'User Home',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
      ),
        body: Container(
          height: MediaQuery. of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("#307CB4"),
                hexStringToColor("#3966B2"),
                hexStringToColor("#3B3DAB"),
              ]
              )
          ),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          child: Text('Log Out'),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder> (
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF004D4D)),
                          ),
                          onPressed: () async {
                            controller.pause();
                            FirebaseAuth.instance.signOut().then((value) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Home()));
                            });
                            await FirebaseServices().signOut();
                          }
                      ),
                    ],
                  ),
                  player,
                ],
              ),
            ),
          ),
        )
      ),
    );
}

