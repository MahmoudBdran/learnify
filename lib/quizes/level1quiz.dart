import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';import 'package:quiver/async.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
class Level1Quiz extends StatefulWidget {
  const Level1Quiz({Key? key}) : super(key: key);

  @override
  _Level1QuizState createState() => _Level1QuizState();
}

class _Level1QuizState extends State<Level1Quiz> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
  @override
  dispose(){
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
  final FlutterTts tts = FlutterTts();
  final FlutterTts arabictts = FlutterTts();
  int  score=0;
  late int dataLength;
  bool finished=false;
  _Level1QuizState(){
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
    arabictts.setLanguage('ar');
    arabictts.setSpeechRate(0.4);
  }
  int question=1;
  List<String>questionsList=['a','b','c','d','e','f','g'];
  // List<String>alphabet=['a','b','c','d','e','f','g','h',
  //   'i','j','k','l','m','n','o','p','q','r','s','t','u','v',
  //   'w','x','y','z'];
  List<String> alphabet=['h','v','g','u','f','t','e','s','d','r','c','q','b','p','a','o','n','z','m','y','l','x','k','i','j','w'];
  bool answering=false;
  String answer="right";
  // late stt.SpeechToText _speech;
  // bool _isListening = false;
  // String _text = '';
  // double _confidence = 1.0;
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
        });
        sub.cancel();
      });
    }
    void startTimer2() {
      CountdownTimer countDownTimer = new CountdownTimer(
        new Duration(seconds: _start),
        new Duration(seconds: 1),
      );

      var sub = countDownTimer.listen(null);
      sub.onData((duration) {
        setState(() { _current = _start - duration.elapsed.inSeconds; });
      });

      sub.onDone(() {

        sub.cancel();
      });
    }
    // void _listen() async {
    //   if (!_isListening) {
    //     bool available = await _speech.initialize(
    //       onStatus: (val) => print('onStatus: $val'),
    //       onError: (val) => print('onError: $val'),
    //     );
    //     if (available) {
    //       setState(() => _isListening = true);
    //       _speech.listen(
    //         onResult: (val) => setState(() {
    //           _text = val.recognizedWords;
    //           if (val.hasConfidenceRating && val.confidence > 0) {
    //             _confidence = val.confidence;
    //           }
    //         }),
    //       );
    //     }
    //   } else {
    //     setState(() {_isListening = false;
    //     _speech.stop();
    //     _text='';
    //     });
    //
    //   }
    // }

    return Scaffold(
      body:
      !answering?
      SafeArea(

        child: finished==false?Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      FloatingActionButton(
                          onPressed: (){
                            setState(() {
                              tts.speak(questionsList[question-1]);
                            });
                          },
                          child: Icon(Icons.mic)),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.bottomCenter,
                            height: MediaQuery.of(context).size.height,
                            width:  MediaQuery.of(context).size.width-100,
                            child:GridView.builder(
                              physics: ScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 9),
                              itemBuilder: (_, index){
                                return InkWell(
                                  onTap: (){
                                    if(alphabet[index]==questionsList[question-1]){
                                      setState(() {

                                        startTimer();
                                        print("good");
                                        answer="right";
                                        score++;
                                        FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update({
                                          "level1_score":score
                                        });
                                        answering=true;
                                        if(question<questionsList.length){

                                          question++;
                                        }else{
                                          setState(() {
                                            finished=true;
                                          });
                                          print("finished");
                                        }
                                      });
                                    }else{

                                      setState(() {
                                        startTimer();
                                        answer="wrong";
                                        answering=true;
                                      });
                                      print("bad");
                                    }
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    margin: EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    decoration:  BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey[200]
                                      // image:  DecorationImage(
                                      //   image:  NetworkImage(bgList[index]),
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    child: Text(alphabet[index],style: GoogleFonts.aBeeZee(
                                        color: Colors.black87,
                                        fontSize: 20
                                    ),),
                                  ),
                                );
                              },
                              itemCount: 26,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                //IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
              ],
            ),
          ),
        ):Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child:Text(score.toString())
        ),
      ):
      SafeArea(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: answer=="right"?
                InkWell(
                  onTap: (){
                    setState(() {
                      answering=false;
                    });
                  },
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                FloatingActionButton(
                                    onPressed: (){
                                      setState(() {
                                        tts.speak(questionsList[question-1]);
                                      });
                                    },
                                    child: Icon(Icons.mic)),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      alignment: Alignment.bottomCenter,
                                      height: MediaQuery.of(context).size.height,
                                      width:  MediaQuery.of(context).size.width-100,
                                      child:GridView.builder(
                                        physics: ScrollPhysics(),
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 9),
                                        itemBuilder: (_, index){
                                          return InkWell(
                                            onTap: (){
                                              if(alphabet[index]==questionsList[question-1]){
                                                setState(() {
                                                  print("good");

                                                  if(question<questionsList.length){

                                                    question++;
                                                  }else{
                                                    print("finished");
                                                  }
                                                });
                                              }else{
                                                print("bad");
                                              }
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              margin: EdgeInsets.all(8),
                                              alignment: Alignment.center,
                                              decoration:  BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Colors.grey[200]
                                                // image:  DecorationImage(
                                                //   image:  NetworkImage(bgList[index]),
                                                //   fit: BoxFit.cover,
                                                // ),
                                              ),
                                              child: Text(alphabet[index],style: GoogleFonts.aBeeZee(
                                                  color: Colors.black87,
                                                  fontSize: 20
                                              ),),
                                            ),
                                          );
                                        },
                                        itemCount: 26,
                                      )
                                    /* Container(
                                      alignment: Alignment.center,
                                      decoration:  BoxDecoration(
                                        // image:  DecorationImage(
                                        //   image:  NetworkImage(bgList[index]),
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.network(bgList[index],fit: BoxFit.cover,),
                                          Text(typesList[index]),
                                        ],
                                      ),
                                    ),*/
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset("assets/rightanswer.png"),
                      )
                    ],
                  ),
                ):
            InkWell(
              onTap: (){
                setState(() {
                  answering=false;
                });
              },
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            FloatingActionButton(
                                onPressed: (){
                                  setState(() {
                                    tts.speak(questionsList[question-1]);
                                  });
                                },
                                child: Icon(Icons.mic)),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  alignment: Alignment.bottomCenter,
                                  height: MediaQuery.of(context).size.height,
                                  width:  MediaQuery.of(context).size.width-100,
                                  child:GridView.builder(
                                    physics: ScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 9),
                                    itemBuilder: (_, index){
                                      return InkWell(
                                        onTap: (){
                                          if(alphabet[index]==questionsList[question-1]){
                                            setState(() {
                                              print("good");

                                              if(question<questionsList.length){

                                                question++;
                                              }else{
                                                print("finished");
                                              }
                                            });
                                          }else{
                                            print("bad");
                                          }
                                        },
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          margin: EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          decoration:  BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.grey[200]
                                            // image:  DecorationImage(
                                            //   image:  NetworkImage(bgList[index]),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: Text(alphabet[index],style: GoogleFonts.aBeeZee(
                                              color: Colors.black87,
                                              fontSize: 20
                                          ),),
                                        ),
                                      );
                                    },
                                    itemCount: 26,
                                  )
                                /* Container(
                                      alignment: Alignment.center,
                                      decoration:  BoxDecoration(
                                        // image:  DecorationImage(
                                        //   image:  NetworkImage(bgList[index]),
                                        //   fit: BoxFit.cover,
                                        // ),
                                      ),
                                      child: Column(
                                        children: [
                                          Image.network(bgList[index],fit: BoxFit.cover,),
                                          Text(typesList[index]),
                                        ],
                                      ),
                                    ),*/
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/wronganswer.png"),
                  )
                ],
              ),
            )
          ),
        ),
      )
    );
  }

}
