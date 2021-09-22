import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectedTypeScreen extends StatefulWidget {
  final title;

  SelectedTypeScreen({this.title});

  @override
  _SelectedTypeScreenState createState() => _SelectedTypeScreenState();
}

class _SelectedTypeScreenState extends State<SelectedTypeScreen> {
  final FlutterTts tts = FlutterTts();


  _SelectedTypeScreenState() {
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
  }
String get title=>widget.title;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title,style: GoogleFonts.aBeeZee(
          fontWeight: FontWeight.bold,
          color: Colors.black45,
        ),),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black45,size: 70),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection("type").doc(title).get(),
        builder: (context,snapshot){
          List data=[];
          if(snapshot.hasData){
            DocumentSnapshot<Object?>? doc = snapshot.data;
            data=doc![title];
            return title=="color"?Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  child:GridView.builder(
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (_, index){
                      return InkWell(
                        onTap: (){
                          setState(() {
                            tts.speak(data[index]);
                          });
                         },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200]
                              // image:  DecorationImage(
                              //   image:  NetworkImage(bgList[index]),
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0),
                                  child: Text(data[index],style: GoogleFonts.aBeeZee(
                                      color: Colors.black87,
                                      fontSize: 30
                                  ),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: data.length,
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
            ):Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  child:GridView.builder(
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (_, index){
                      return InkWell(
                        onTap: (){
                          setState(() {
                            tts.speak(data[index]);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey[200]
                              // image:  DecorationImage(
                              //   image:  NetworkImage(bgList[index]),
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0),
                                  child: Text(data[index],style: GoogleFonts.aBeeZee(
                                      color: Colors.black87,
                                      fontSize: 30
                                  ),),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: data.length,
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
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },

      ),

    );
  }
}
