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

  @override
  Widget build(BuildContext context) {
    List<Map<String,String>> mydata=[
      {"1":"book","2":"ball","3":"apple"},
      {"1":"sun","2":"summer","3":"dog"},
    ];
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
          answer="";
        });
        sub.cancel();
      });
    }
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
        itemCount: mydata.length,
        itemBuilder: (context, index) {
          if(!answering && answer!="good"&&answer!="bad"){
            List data=[];
            data.add(mydata[index]['1']);
            data.add(mydata[index]['2']);
            data.add(mydata[index]['3']);
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: (){
                      if(data[0]!=data[1]&&data[0]!=data[2]){
                        setState(() {
                          startTimer();
                          answer="good";
                          answering=true;

                        });
                      }else{
                        setState(() {
                          startTimer();
                          answer="bad";
                          answering=true;
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
                      child: Text(data[0],style: GoogleFonts.aBeeZee(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      if(data[1]!=data[0]&&data[1]!=data[2]){
                        setState(() {

                          startTimer();
                          answer="good";
                          answering=true;

                        });
                      }else{
                        setState(() {
                          startTimer();
                          answering=true;
                          answer="bad";
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
                      child: Text(data[1],style: GoogleFonts.aBeeZee(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      if(data[2]!=data[1]&&data[2]!=data[0]){
                        setState(() {
                          startTimer();
                          answer="good";
                          answering=true;

                        });
                      }else{
                        setState(() {
                          startTimer();
                          answering=true;
                          answer="bad";
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
                      child: Text(data[2],style: GoogleFonts.aBeeZee(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),),
                    ),
                  ),
                ],
              ),
            );
          }
          else if(answering&&answer=="good"){
            List data=[];
            data.add(mydata[index]['1']);
            data.add(mydata[index]['2']);
            data.add(mydata[index]['3']);
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
          }else{
            List data=[];
            data.add(mydata[index]['1']);
            data.add(mydata[index]['2']);
            data.add(mydata[index]['3']);
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
                  child: Image.asset("assets/wronganswer.png"),)
              ],
            );
          }
        },),
      )
    );
  }
}
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