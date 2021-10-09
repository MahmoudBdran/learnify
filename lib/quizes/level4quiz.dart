import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiver/async.dart';

class Level4Quiz extends StatefulWidget {
  const Level4Quiz({Key? key}) : super(key: key);

  @override
  _Level4QuizState createState() => _Level4QuizState();
}

class _Level4QuizState extends State<Level4Quiz> {
  late int ind;
  late int dataLength;
  late String ans;
  int  score=0;
  bool finished = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ind = 0;
    ans = "";
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      int res=value['points']+score;
      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "points":res
      });
    });
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    int _start = 2;
    int _current = 2;
    void startTimer() {
      CountdownTimer countDownTimer = new CountdownTimer(
        new Duration(seconds: _start),
        new Duration(seconds: 1),
      );

      var sub = countDownTimer.listen(null);
      sub.onData((duration) {
        setState(() {
          _current = _start - duration.elapsed.inSeconds;
        });
      });

      sub.onDone(() {
        print("Done");
        setState(() {
          // answering=false;
          ans = "";

        });
        sub.cancel();
      });
    }

    void startTimer2() {
      CountdownTimer countDownTimer = new CountdownTimer(
        new Duration(seconds: _start),
        new Duration(seconds: 2),
      );

      var sub = countDownTimer.listen(null);
      sub.onData((duration) {
        setState(() {
          _current = _start - duration.elapsed.inSeconds;
        });
      });

      sub.onDone(() {
        setState(() {
          // answering=false;

        });
        sub.cancel();
      });
    }

    return Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection("quiz").doc("level 4").get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List data = [];
          int res=0;
          DocumentSnapshot<Object?>? doc = snapshot.data;
          data = doc!["words"];
          res=doc!['score'];
          dataLength = data.length;
          String arWord = data[ind]["1"];
          String answer = data[ind]["answer"];
          String choice1 = data[ind]["2"];
          String choice2 = data[ind]["3"];
          String choice3 = data[ind]["4"];
          if (ans == ""&&finished==false) {
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      arWord,
                      style: GoogleFonts.aBeeZee(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (choice1 == answer) {
                                ans = "good";
                                score++;
                                FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update(
                                    {"level4_score":score});
                                if (ind + 1 < data.length) {
                                  ind++;
                                } else if (ind + 1 == data.length) {
                                  finished = true;
                                }
                                startTimer();
                              } else {
                                ans = "bad";
                                if (ind + 1 < data.length) {
                                  ind++;
                                } else if (ind + 1 == data.length) {
                                  finished = true;
                                }
                                startTimer();
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[200],
                            ),
                            child: Text(
                              choice1,
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (choice2 == answer) {
                                ans = "good";score++;
                                FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update(
                                    {"level4_score":score});
                                if (ind + 1 < data.length) {
                                  ind++;
                                } else if (ind + 1 == data.length) {
                                  finished = true;
                                }
                                startTimer();
                              } else {
                                ans = "bad";
                                if (ind + 1 < data.length) {
                                  ind++;
                                } else if (ind + 1 == data.length) {
                                  finished = true;
                                }
                                startTimer();
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[200],
                            ),
                            child: Text(
                              choice2,
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (choice3 == answer) {
                                ans = "good";score++;
                                FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update(
                                    {"level4_score":score});
                                if (ind + 1 < data.length) {
                                  ind++;
                                } else if (ind + 1 == data.length) {
                                  finished = true;
                                }
                                startTimer();
                              } else {
                                ans = "bad";
                                if (ind + 1 < data.length) {
                                  ind++;
                                } else if (ind + 1 == data.length) {
                                  finished = true;
                                }
                                startTimer();
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[200],
                            ),
                            child: Text(
                              choice3,
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          else if (ans == "good"&&finished==false) {
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: Stack(
                  children: [

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          arWord,
                          style: GoogleFonts.aBeeZee(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200],
                              ),
                              child: Text(
                                choice1,
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200],
                              ),
                              child: Text(
                                choice2,
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200],
                              ),
                              child: Text(
                                choice3,
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        "assets/rightanswer.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          else if(finished){
            return Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Text(score.toString())
            );
          }
          else {
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          arWord,
                          style: GoogleFonts.aBeeZee(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200],
                              ),
                              child: Text(
                                choice1,
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200],
                              ),
                              child: Text(
                                choice2,
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200],
                              ),
                              child: Text(
                                choice3,
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        "assets/wronganswer.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          //SingleChildScrollView(
          //               child: Container(width: MediaQuery.of(context).size.width,
          //                 height: MediaQuery.of(context).size.height,
          //                 alignment: Alignment.center,
          //                 child: Row(
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
          //                     Column(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         Text(arWord,style: GoogleFonts.aBeeZee(
          //                             color: Colors.black87,
          //                             fontWeight: FontWeight.bold,
          //                             fontSize: 30
          //                         ),),
          //                         SizedBox(height: 30,),
          //                         Row(
          //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                           children: [
          //                             Container(
          //                               alignment: Alignment.center,
          //                               height: 50,width: 100,
          //                               decoration: BoxDecoration(
          //                                 borderRadius: BorderRadius.circular(15),
          //                                 color: Colors.grey[200],
          //                               ),
          //                               child: Text(choice1,style: GoogleFonts.aBeeZee(
          //                                   color: Colors.black87,
          //                                   fontWeight: FontWeight.bold
          //                               ),),
          //                             ),
          //                             SizedBox(width: 25,),
          //                             Container(
          //                               alignment: Alignment.center,
          //                               height: 50,width: 100,
          //                               decoration: BoxDecoration(
          //                                 borderRadius: BorderRadius.circular(15),
          //                                 color: Colors.grey[200],
          //                               ),
          //                               child: Text(choice2,style: GoogleFonts.aBeeZee(
          //                                   color: Colors.black87,
          //                                   fontWeight: FontWeight.bold
          //                               ),),
          //                             ),
          //                             SizedBox(width: 25,),
          //                             Container(
          //                               alignment: Alignment.center,
          //                               height: 50,width: 100,
          //                               decoration: BoxDecoration(
          //                                 borderRadius: BorderRadius.circular(15),
          //                                 color: Colors.grey[200],
          //                               ),
          //                               child: Text(choice3,style: GoogleFonts.aBeeZee(
          //                                   color: Colors.black87,
          //                                   fontWeight: FontWeight.bold
          //                               ),),
          //                             )
          //                           ],
          //                         )
          //                       ],
          //                     ),
          //
          //                     IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
          //                   ],
          //                 ),
          //               ),
          //             );
        } else {
          return CircularProgressIndicator();
        }
      },
    ));
  }
}
