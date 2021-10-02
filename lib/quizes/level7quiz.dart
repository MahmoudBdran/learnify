import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiver/async.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Level7Quiz extends StatefulWidget {
  const Level7Quiz({Key? key}) : super(key: key);

  @override
  _Level7QuizState createState() => _Level7QuizState();
}

class _Level7QuizState extends State<Level7Quiz> {
  final FlutterTts  tts = FlutterTts();
  final FlutterTts arabictts = FlutterTts();


  _Level7QuizState() {
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
    arabictts.setLanguage('ar');
    arabictts.setSpeechRate(0.4);
  }
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
    _speech = stt.SpeechToText();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  double _confidence = 1.0;
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
          //ans = "";
          _text="";

        });
        sub.cancel();
      });
    }
    void _listen() async {
      if (!_isListening) {
        bool available = await _speech.initialize(
          onStatus: (val) => print('onStatus: $val'),
          onError: (val) => print('onError: $val'),
        );
        if (available) {
          setState(() => _isListening = true);
          _speech.listen(
            onResult: (val) => setState(() {
              _text = val.recognizedWords;
              if (val.hasConfidenceRating && val.confidence > 0) {
                _confidence = val.confidence;
              }

              startTimer();


            }),
          );
        }
      } else {
        setState(() {_isListening = false;
        _speech.stop();
        _text='';
        });

      }
    }
    return Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
          future:
          FirebaseFirestore.instance.collection("quiz").doc("level 7").get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = [];
              int res=0;
              DocumentSnapshot<Object?>? doc = snapshot.data;
              data = doc!["words"];
              res=doc!['score'];
              dataLength = data.length;
              String the_word = data[ind]["1"];
              String answer = data[ind]["answer"];
              String image = data[ind]["image"];
              if (_text == ""&&finished==false) {
                return SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                tts.speak(the_word);
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 200,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                  child:Column(
                                    children: [
                                      Image.network(image,height: 170,width: 150,fit: BoxFit.cover,),
                                    ],
                                  )
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          tts.speak(the_word);
                                        },
                                        child: Text(
                                          the_word,
                                          style: GoogleFonts.aBeeZee(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                      ),
                                      FloatingActionButton(
                                          onPressed: _listen,
                                          child: Icon(_isListening ? Icons.mic : Icons.mic_none)),
                                    ],
                                  ),
                                  Text(_text),
                                ],),
                            )
                          ],
                        ),


                  ),
                );
              }
              else if (_text==the_word&&finished==false) {
                return SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          alignment: Alignment.center,
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                // onTap: () {
                                //   setState(() {
                                //     if (the_word == answer) {
                                //       ans = "good";
                                //       score++;
                                //       FirebaseFirestore.instance.collection("quiz").doc("level 7").update(
                                //           {"score":score});
                                //       if (ind + 1 < data.length) {
                                //         ind++;
                                //       } else if (ind + 1 == data.length) {
                                //         finished = true;
                                //       }
                                //       startTimer();
                                //     } else {
                                //       ans = "bad";
                                //       if (ind + 1 < data.length) {
                                //         ind++;
                                //       } else if (ind + 1 == data.length) {
                                //         finished = true;
                                //       }
                                //       startTimer();
                                //     }
                                //   });
                                // },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 200,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child:Column(
                                      children: [
                                        Image.network(image,height: 170,width: 150,fit: BoxFit.cover,),
                                      ],
                                    )
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            tts.speak(the_word);
                                          },
                                          child: Text(
                                            the_word,
                                            style: GoogleFonts.aBeeZee(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ),
                                        ),
                                        FloatingActionButton(
                                            onPressed: _listen,
                                            child: Icon(_isListening ? Icons.mic : Icons.mic_none)),
                                      ],
                                    ),
                                    Text(_text),
                                  ],),
                              )
                            ],
                          ),


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
                  child: Text(res.toString()+"/2"),
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          alignment: Alignment.center,
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                // onTap: () {
                                //   setState(() {
                                //     if (the_word == answer) {
                                //       ans = "good";
                                //       score++;
                                //       FirebaseFirestore.instance.collection("quiz").doc("level 7").update(
                                //           {"score":score});
                                //       if (ind + 1 < data.length) {
                                //         ind++;
                                //       } else if (ind + 1 == data.length) {
                                //         finished = true;
                                //       }
                                //       startTimer();
                                //     } else {
                                //       ans = "bad";
                                //       if (ind + 1 < data.length) {
                                //         ind++;
                                //       } else if (ind + 1 == data.length) {
                                //         finished = true;
                                //       }
                                //       startTimer();
                                //     }
                                //   });
                                // },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 200,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child:Column(
                                      children: [
                                        Image.network(image,height: 170,width: 150,fit: BoxFit.cover,),
                                      ],
                                    )
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            tts.speak(the_word);
                                          },
                                          child: Text(
                                            the_word,
                                            style: GoogleFonts.aBeeZee(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30),
                                          ),
                                        ),
                                        FloatingActionButton(
                                            onPressed: _listen,
                                            child: Icon(_isListening ? Icons.mic : Icons.mic_none)),
                                      ],
                                    ),
                                    Text(_text),
                                  ],),
                              )
                            ],
                          ),


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
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
