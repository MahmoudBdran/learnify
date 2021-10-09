import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiver/async.dart';
class Level3Quiz extends StatefulWidget {
  const Level3Quiz({Key? key}) : super(key: key);

  @override
  _Level3QuizState createState() => _Level3QuizState();
}

class _Level3QuizState extends State<Level3Quiz> {
  bool answering=false;
  String answer="";
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
  }
  @override
  void dispose() {
    // TODO: implement dispose
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
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
        setState(() { _current = _start - duration.elapsed.inSeconds; });
      });

      sub.onDone(() {

        print("Done");
        setState(() {

          answering=false;
          ans="";

        });
        sub.cancel();
      });
    }
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future:FirebaseFirestore.instance.collection("quiz").doc("level 3").get(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              List data = [];
              int res=0;
              DocumentSnapshot<Object?>? doc = snapshot.data;
              data = doc!["words"];
              print("data is "+data[0]["3"].toString());
              res=doc!['score'];
              print("data is "+ res.toString());
              dataLength = data.length;
              String choice1 = data[ind]["1"];
              String choice1FA=choice1.substring(0,1);
              print("first letter "+choice1FA);
              String choice2 = data[ind]["2"];
              String choice2FA=choice2.substring(0,1);
              String choice3 = data[ind]["3"];
              String choice3FA=choice3.substring(0,1);
              if(answering==false&&finished==false&&ans==""){
                return
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: (){
                              if(choice1FA==choice2FA||choice1FA==choice3FA){
                                setState(() {

                                  answering=true;
                                  ans="bad";
                                  if (ind + 1 < data.length) {
                                    ind++;
                                  } else if (ind + 1 == data.length) {
                                    finished = true;
                                  }
                                  startTimer();
                                });
                              }else{
                                setState(() {score++;
                                FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update(
                                    {"level3_score":score});
                                  answering=true;
                                  ans="good";
                                  if (ind + 1 < data.length) {
                                    ind++;
                                  } else if (ind + 1 == data.length) {
                                    finished = true;
                                  }
                                  startTimer();
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 70,width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200],
                              ),
                              child: Text(choice1,style: GoogleFonts.aBeeZee(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              if(choice2FA==choice1FA||choice2FA==choice3FA){
                                setState(() {
                                  answering=true;
                                  ans="bad";
                                  if (ind + 1 < data.length) {
                                    ind++;
                                  } else if (ind + 1 == data.length) {
                                    finished = true;
                                  }
                                  startTimer();
                                });
                              }else{
                                setState(() {score++;
                                FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update(
                                    {"level3_score":score});
                                answering=true;
                                ans="good";
                                  answering=true;
                                  ans="bad";
                                  if (ind + 1 < data.length) {
                                    ind++;
                                  } else if (ind + 1 == data.length) {
                                    finished = true;
                                  }
                                  startTimer();
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 70,width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200],
                              ),
                              child: Text(choice2,style: GoogleFonts.aBeeZee(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              if(choice3FA==choice1FA||choice3FA==choice2FA){
                                setState(() {
                                  answering=true;
                                  ans="bad";
                                  if (ind + 1 < data.length) {
                                    ind++;
                                  } else if (ind + 1 == data.length) {
                                    finished = true;
                                  }
                                  startTimer();
                                });
                              }else{
                                setState(() {score++;
                                FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update(
                                    {"level3_score":score});
                                answering=true;
                                ans="good";
                                  if (ind + 1 < data.length) {
                                    ind++;
                                  } else if (ind + 1 == data.length) {
                                    finished = true;
                                  }
                                  startTimer();
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 70,width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200],
                              ),
                              child: Text(choice3,style: GoogleFonts.aBeeZee(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),),
                            ),
                          ),
                        ],
                      ),
                    );
              }else if(answering==true&&finished==false&&ans=="good"){
                return
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: (){
                                if(choice1FA==choice2FA||choice1FA==choice3FA){
                                  setState(() {
                                    answering=true;
                                    ans="good";
                                    if (ind + 1 < data.length) {
                                      ind++;
                                    } else if (ind + 1 == data.length) {
                                      finished = true;
                                    }
                                    startTimer();
                                  });
                                }else{
                                  setState(() {
                                    answering=true;
                                    ans="bad";
                                    if (ind + 1 < data.length) {
                                      ind++;
                                    } else if (ind + 1 == data.length) {
                                      finished = true;
                                    }
                                    startTimer();
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 70,width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200],
                                ),
                                child: Text(choice1,style: GoogleFonts.aBeeZee(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                if(choice2FA==choice1FA||choice2FA==choice3FA){
                                  setState(() {
                                    answering=true;
                                    ans="good";
                                    if (ind + 1 < data.length) {
                                      ind++;
                                    } else if (ind + 1 == data.length) {
                                      finished = true;
                                    }
                                    startTimer();
                                  });
                                }else{
                                  setState(() {
                                    answering=true;
                                    ans="bad";
                                    if (ind + 1 < data.length) {
                                      ind++;
                                    } else if (ind + 1 == data.length) {
                                      finished = true;
                                    }
                                    startTimer();
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 70,width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200],
                                ),
                                child: Text(choice2,style: GoogleFonts.aBeeZee(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                if(choice3FA==choice1FA||choice3FA==choice2FA){
                                  setState(() {
                                    answering=true;
                                    ans="good";
                                    if (ind + 1 < data.length) {
                                      ind++;
                                    } else if (ind + 1 == data.length) {
                                      finished = true;
                                    }
                                    startTimer();
                                  });
                                }else{
                                  setState(() {
                                    answering=true;
                                    ans="bad";
                                    if (ind + 1 < data.length) {
                                      ind++;
                                    } else if (ind + 1 == data.length) {
                                      finished = true;
                                    }
                                    startTimer();
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 70,width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200],
                                ),
                                child: Text(choice3,style: GoogleFonts.aBeeZee(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset("assets/rightanswer.png"),)
                    ],
                  );
              }else if(answering==true&&finished==false&&ans=="bad"){
                return
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: (){
                                if(choice1FA==choice2FA||choice1FA==choice3FA){
                                  setState(() {
                                    answering=true;
                                    ans="good";
                                    if (ind + 1 < data.length) {
                                      ind++;
                                    } else if (ind + 1 == data.length) {
                                      finished = true;
                                    }
                                    startTimer();
                                  });
                                }else{
                                  setState(() {
                                    answering=true;
                                    ans="bad";
                                    if (ind + 1 < data.length) {
                                      ind++;
                                    } else if (ind + 1 == data.length) {
                                      finished = true;
                                    }
                                    startTimer();
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 70,width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200],
                                ),
                                child: Text(choice1,style: GoogleFonts.aBeeZee(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                if(choice2FA==choice1FA||choice2FA==choice3FA){
                                  setState(() {
                                    answering=true;
                                    ans="good";
                                    if (ind + 1 < data.length) {
                                      ind++;
                                    } else if (ind + 1 == data.length) {
                                      finished = true;
                                    }
                                    startTimer();
                                  });
                                }else{
                                  setState(() {
                                    answering=true;
                                    ans="bad";
                                    if (ind + 1 < data.length) {
                                      ind++;
                                    } else if (ind + 1 == data.length) {
                                      finished = true;
                                    }
                                    startTimer();
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 70,width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200],
                                ),
                                child: Text(choice2,style: GoogleFonts.aBeeZee(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                if(choice3FA==choice1FA||choice3FA==choice2FA){
                                  setState(() {
                                    answering=true;
                                    ans="good";
                                    if (ind + 1 < data.length) {
                                      ind++;
                                    } else if (ind + 1 == data.length) {
                                      finished = true;
                                    }
                                    startTimer();
                                  });
                                }else{
                                  setState(() {
                                    answering=true;
                                    ans="bad";
                                    if (ind + 1 < data.length) {
                                      ind++;
                                    } else if (ind + 1 == data.length) {
                                      finished = true;
                                    }
                                    startTimer();
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 70,width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[200],
                                ),
                                child: Text(choice3,style: GoogleFonts.aBeeZee(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset("assets/wronganswer.png"),)
                    ],
                  );
              }else{
                return Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Text(score.toString())
                );
              }
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
        )
      )
    );
  }
}
/*
return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 70,width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200],
                        ),
                        child: Text(data[0],style: GoogleFonts.aBeeZee(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 70,width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200],
                        ),
                        child: Text(data[1],style: GoogleFonts.aBeeZee(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 70,width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200],
                        ),
                        child: Text(data[2],style: GoogleFonts.aBeeZee(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset("assets/rightanswer.png"),)
              ],
            );
 */
/*
if(answer=="bad")
            {
              List data=[];
              data.add(mydata[index]['1']);

              data.add(mydata[index]['2']);
              data.add(mydata[index]['3']);
              return Stack(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 70,width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[200],
                            ),
                            child: Text(data[0],style: GoogleFonts.aBeeZee(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 70,width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[200],
                            ),
                            child: Text(data[1],style: GoogleFonts.aBeeZee(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 70,width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[200],
                            ),
                            child: Text(data[2],style: GoogleFonts.aBeeZee(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),),
                          ),
                        ],
                      ),
                    ),
                  ),
          Expanded(
            child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/rightanswer.png"),),
          )
                ],
              );
            }
            else
              {
              List data=[];
              data.add(mydata[index]['1']);

              data.add(mydata[index]['2']);
              data.add(mydata[index]['3']);
              return Stack(
                children: [
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 70,width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[200],
                            ),
                            child: Text(data[0],style: GoogleFonts.aBeeZee(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 70,width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[200],
                            ),
                            child: Text(data[1],style: GoogleFonts.aBeeZee(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 70,width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[200],
                            ),
                            child: Text(data[2],style: GoogleFonts.aBeeZee(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/wronganswer.png"),),
                  )
                ],
              );
            }
 */