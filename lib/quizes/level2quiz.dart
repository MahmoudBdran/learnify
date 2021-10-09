import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiver/async.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Level2Quiz extends StatefulWidget {
  const Level2Quiz({Key? key}) : super(key: key);

  @override
  _Level2QuizState createState() => _Level2QuizState();
}

class _Level2QuizState extends State<Level2Quiz> {
  final FlutterTts tts = FlutterTts();
  late int ind;
  late int dataLength;
  late String ans;
  int score = 0;
  String result = "";
  bool finished = false;

  _Level2QuizState() {
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
  }
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    ind = 0;
    ans = "";
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
          _isListening = false;
          _text = '';
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
        setState(() {
          _isListening = false;
          _speech.stop();
          _text = '';
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection("quiz")
              .doc("level 2")
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = [];
              int res = 0;
              DocumentSnapshot<Object?>? doc = snapshot.data;
              data = doc!["words"];
              res = doc!['score'];
              dataLength = data.length;
              String the_word = data[ind]["1"];
              String image = data[ind]["2"];
              if (_text == "" && finished == false) {
                return Stack(
                  children: [
                    Expanded(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            image,
                                            height: 150,
                                            width: 250,
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    tts.speak(data[ind]['1']);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 50,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: Colors.grey[200],
                                                    ),
                                                    child: Text(
                                                      data[ind]['1'],
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  )),
                                              FloatingActionButton(
                                                  onPressed: () async {
                                                    if (!_isListening) {
                                                      bool available =
                                                          await _speech
                                                              .initialize(
                                                        onStatus: (val) => print(
                                                            'onStatus: $val'),
                                                        onError: (val) => print(
                                                            'onError: $val'),
                                                      );
                                                      if (available) {
                                                        setState(() =>
                                                            _isListening =
                                                                true);
                                                        _speech.listen(
                                                          onResult: (val) =>
                                                              setState(() {
                                                            _text = val
                                                                .recognizedWords;
                                                            if (val.hasConfidenceRating &&
                                                                val.confidence >
                                                                    0) {
                                                              _confidence = val
                                                                  .confidence;
                                                            }

                                                            if (_text ==
                                                                the_word) {
                                                              result = "good";
                                                            } else {
                                                              result = "bad";
                                                            }
                                                            startTimer();
                                                          }),
                                                        );
                                                      }
                                                    } else {
                                                      setState(() {
                                                        _isListening = false;
                                                        _speech.stop();
                                                        _text = '';
                                                      });
                                                    }
                                                  },
                                                  child: Icon(_isListening
                                                      ? Icons.mic
                                                      : Icons.mic_none)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(_text),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (result == "good") {
                                            score++;
                                            FirebaseFirestore.instance
                                                .collection("quiz")
                                                .doc("level 2")
                                                .update({"score": score});
                                          }

                                          if (ind + 1 < data.length) {
                                            ind++;
                                          } else if (ind + 1 == data.length) {
                                            finished = true;
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.arrow_forward_ios)),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ],
                );
              } else if (finished) {
                return Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Text(res.toString() + "/" + dataLength.toString()),
                );
              } else if (_text == the_word && finished == false) {
                return Stack(
                  children: [
                    Expanded(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            image,
                                            height: 150,
                                            width: 250,
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    tts.speak(data[ind]['1']);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 50,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: Colors.grey[200],
                                                    ),
                                                    child: Text(
                                                      data[ind]['1'],
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  )),
                                              FloatingActionButton(
                                                  onPressed: _listen,
                                                  child: Icon(_isListening
                                                      ? Icons.mic
                                                      : Icons.mic_none)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(_text),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _text = "";
                                          ind++;
                                        });
                                      },
                                      icon: Icon(Icons.arrow_forward_ios)),
                                ],
                              ),
                            ),
                          )),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height - 100,
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              "assets/rightanswer.png",
                              height: 50,
                              width: 50,
                            ),
                          ),
                          Text(_text),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Stack(
                  children: [
                    Expanded(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            image,
                                            height: 150,
                                            width: 250,
                                            fit: BoxFit.cover,
                                          )),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    tts.speak(data[ind]['1']);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 50,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: Colors.grey[200],
                                                    ),
                                                    child: Text(
                                                      data[ind]['1'],
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  )),
                                              FloatingActionButton(
                                                  onPressed: _listen,
                                                  child: Icon(_isListening
                                                      ? Icons.mic
                                                      : Icons.mic_none)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(_text),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _text = "";
                                          ind++;
                                        });
                                      },
                                      icon: Icon(Icons.arrow_forward_ios)),
                                ],
                              ),
                            ),
                          )),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height - 100,
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              "assets/wronganswer.png",
                              height: 50,
                              width: 50,
                            ),
                          ),
                          Text(_text),
                        ],
                      ),
                    )
                  ],
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
/*
// good answer
  return Stack(
                      children: [
                        Expanded(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),child: Image.network(data[index]['2'],height: 150,width: 250,fit: BoxFit.cover,)),
                                      SizedBox(height: 50,),
                                      Row(
                                        children: [
                                          InkWell(
                                              onTap: (){

                                                tts.speak(data[index]['1']);
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 50,width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  color: Colors.grey[200],
                                                ),
                                                child: Text(data[index]['1'],style: GoogleFonts.aBeeZee(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              )
                                          ),
                                          FloatingActionButton(
                                              onPressed: _listen,
                                              child: Icon(_isListening ? Icons.mic : Icons.mic_none)),
                                        ],
                                      ),
                                      SizedBox(height: 10,),


                                    ],
                                  ),
                                ),
                              )
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height-100,
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset("assets/rightanswer.png",height: 50,width: 50,),),
                              Text(_text),
                            ],
                          ),
                        )
                      ],
                    );
 */
/*
//bad answer
return Stack(
                      children: [
                        Expanded(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [SizedBox(height: 20,),
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),child: Image.network(data[index]['2'],height: 150,width: 250,fit: BoxFit.cover,)),
                                      SizedBox(height: 50,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                  onTap: (){

                                                    tts.speak(data[index]['1']);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 50,width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: Colors.grey[200],
                                                    ),
                                                    child: Text(data[index]['1'],style: GoogleFonts.aBeeZee(
                                                        color: Colors.black87,
                                                        fontWeight: FontWeight.bold
                                                    ),),
                                                  )
                                              ),
                                              FloatingActionButton(
                                                  onPressed: _listen,
                                                  child: Icon(_isListening ? Icons.mic : Icons.mic_none)),
                                            ],
                                          ),
                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                              )
                          ),
                        ),
                        // Container(
                        //
                        //   height: MediaQuery.of(context).size.height,
                        //   width: MediaQuery.of(context).size.width,
                        //   alignment: Alignment.center,
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     height: 70,
                        //     width: 70,
                        //     decoration: BoxDecoration(
                        //         color: Colors.redAccent[400],
                        //         shape: BoxShape.circle
                        //     ),
                        //     child: Text("X",style: GoogleFonts.aBeeZee(
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.white,
                        //         fontSize: 30
                        //     ),),
                        //   ),
                        // ),
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                      height: MediaQuery.of(context).size.height-100,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.asset("assets/wronganswer.png"),),

                                      Text(_text),
                                    ],
                                  ),
                                )
                      ],
                    );
 */
