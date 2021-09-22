import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnify/levels/level1.dart';
import 'package:learnify/levels/level2.dart';
import 'package:learnify/levels/level3.dart';
import 'package:learnify/levels/level4.dart';
import 'package:learnify/levels/level5.dart';
import 'package:learnify/levels/level6.dart';
import 'package:learnify/levels/level7.dart';
import 'package:learnify/levels/level8.dart';
import 'package:learnify/quizes/level1quiz.dart';
import 'package:learnify/quizes/level2quiz.dart';
import 'package:learnify/quizes/level3quiz.dart';
import 'package:learnify/quizes/level4quiz.dart';
import 'package:learnify/quizes/level5quiz.dart';
import 'package:learnify/quizes/level6quiz.dart';
import 'package:learnify/quizes/level7quiz.dart';
import 'package:learnify/quizes/level8quiz.dart';

class LevelsPage extends StatefulWidget {
  const LevelsPage({Key? key}) : super(key: key);

  @override
  _LevelsPageState createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  List<Color> colorsList=[Color(0xffF0C433),Color(0xffB0C946),Color(0xffDC4827),Color(0xffBAD6DF),
    Color(0xffF0C433),Color(0xffB0C946),Color(0xffDC4827),Color(0xffBAD6DF),
    Color(0xffF0C433),Color(0xffB0C946),Color(0xffDC4827),Color(0xffBAD6DF),
    Color(0xffF0C433),Color(0xffB0C946),Color(0xffDC4827),Color(0xffBAD6DF)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black45,size: 70),
      ),
      body: ListView(
        children: [
          //level 1
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Color(0xffF0C433),
              elevation: 4.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (cotext)=>Level1()));
                    },
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("level 1",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),),
                          SizedBox(height: 25,),
                          Text("Letters & Sounds",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.normal,
                            color: Colors.white60,
                            fontSize: 25,
                          ),),

                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Level1Quiz()));
                    },
                    child: Container(
                      decoration:BoxDecoration(
                        color:Color(0xffdbb22a),
                      ),
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("Go to Exercise..",style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,

                            ),),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //level 2
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Color(0xffB0C946),
              elevation: 4.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (cotext)=>Level2()));
                    },
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("level 2",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),),
                          SizedBox(height: 25,),
                          Text("Letters & Sounds",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.normal,
                            color: Colors.white60,
                            fontSize: 25,
                          ),),

                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Level2Quiz()));
                    },
                    child: Container(
                      decoration:BoxDecoration(
                        color:Color(0xff92a834),
                      ),
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("Go to Exercise..",style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,

                            ),),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //level 3
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Color(0xffDC4827),
              elevation: 4.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (cotext)=>Level3()));
                    },
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("level 3",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),),
                          SizedBox(height: 25,),
                          Text("Letters & Sounds",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.normal,
                            color: Colors.white60,
                            fontSize: 25,
                          ),),

                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Level3Quiz()));
                    },
                    child: Container(
                      decoration:BoxDecoration(
                        color:Color(0xffc13b1d),
                      ),
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("Go to Exercise..",style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,

                            ),),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //level 4
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Color(0xffa1d1e0),
              elevation: 4.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (cotext)=>Level4()));
                    },
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("level 4",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),),
                          SizedBox(height: 25,),
                          Text("Letters & Sounds",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.normal,
                            color: Colors.white60,
                            fontSize: 25,
                          ),),

                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Level4Quiz()));
                    },
                    child: Container(
                      decoration:BoxDecoration(
                        color:Color(0xff7baab8),
                      ),
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("Go to Exercise..",style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,

                            ),),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //level 5
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Color(0xffF0C433),
              elevation: 4.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (cotext)=>Level5()));
                    },
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("level 5",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),),
                          SizedBox(height: 25,),
                          Text("Letters & Sounds",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.normal,
                            color: Colors.white60,
                            fontSize: 25,
                          ),),

                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Level5Quiz()));
                    },
                    child: Container(
                      decoration:BoxDecoration(
                        color:Color(0xffdbb22a),
                      ),
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("Go to Exercise..",style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,

                            ),),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //level 6
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Color(0xffB0C946),
              elevation: 4.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (cotext)=>Level6()));
                    },
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("level 6",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),),
                          SizedBox(height: 25,),
                          Text("Letters & Sounds",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.normal,
                            color: Colors.white60,
                            fontSize: 25,
                          ),),

                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Level6Quiz()));
                    },
                    child: Container(
                      decoration:BoxDecoration(
                        color:Color(0xff92a834),
                      ),
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("Go to Exercise..",style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,

                            ),),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //level 7
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Color(0xffDC4827),
              elevation: 4.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (cotext)=>Level7()));
                    },
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("level 7",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),),
                          SizedBox(height: 25,),
                          Text("Letters & Sounds",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.normal,
                            color: Colors.white60,
                            fontSize: 25,
                          ),),

                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Level7Quiz()));
                    },
                    child: Container(
                      decoration:BoxDecoration(
                        color:Color(0xffc13b1d),
                      ),
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("Go to Exercise..",style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,

                            ),),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //level 8
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Color(0xffa1d1e0),
              elevation: 4.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (cotext)=>Level8()));
                    },
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("level 8",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 22,
                          ),),
                          SizedBox(height: 25,),
                          Text("Letters & Sounds",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.normal,
                            color: Colors.white60,
                            fontSize: 25,
                          ),),

                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Level8Quiz()));
                    },
                    child: Container(
                      decoration:BoxDecoration(
                        color:Color(0xff7baab8),
                      ),
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("Go to Exercise..",style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,

                            ),),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

        ],
      )
      // StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance.collection("levels").snapshots(),
      //   builder: (context,snapshot){
      //     if(snapshot.hasData){
      //       List<LevelsCard>levelsList=[];
      //       final levels = snapshot.data!.docs;
      //       for(var level in levels){
      //         levelsList.add(new LevelsCard(level: level.id,title: level['title'],));
      //       }
      //       return ListView.builder(itemCount:levelsList.length,
      //       itemBuilder: (context, index) {
      //         return Container(
      //           child: Card(
      //             semanticContainer: true,
      //             clipBehavior: Clip.antiAliasWithSaveLayer,
      //             color: colorsList[index],
      //             elevation: 4.0,
      //             child: Column(
      //               children: [
      //                 InkWell(
      //                   onTap: (){
      //                     Navigator.push(context, MaterialPageRoute(builder: (cotext)=>SelectedLevel(title:levelsList[index].level)));
      //                   },
      //                   child: Container(
      //                     child: Column(
      //                       children: [
      //                         SizedBox(height: 10,),
      //                         Text(levelsList[index].level,style: GoogleFonts.aBeeZee(
      //                           fontWeight: FontWeight.bold,
      //                           color: Colors.white,
      //                           fontSize: 22,
      //                         ),),
      //                         SizedBox(height: 25,),
      //                         Text(levelsList[index].title,style: GoogleFonts.aBeeZee(
      //                           fontWeight: FontWeight.normal,
      //                           color: Colors.white60,
      //                           fontSize: 25,
      //                         ),),
      //
      //                         SizedBox(height: 10,),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //                 InkWell(
      //                   onTap: (){
      //                     Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectedLevelExercise(title:levelsList[index].level)));
      //                   },
      //                   child: Container(
      //                     color: Colors.grey[800],
      //                     child: Container(
      //                       decoration:BoxDecoration(
      //                         color: colorsList[index].withAlpha(230),
      //                       ),
      //                       child: ButtonBar(
      //                         alignment: MainAxisAlignment.center,
      //                         children: [
      //                           Padding(
      //                             padding: const EdgeInsets.all(3.0),
      //                             child: Text("Go to Exercise..",style: GoogleFonts.aBeeZee(
      //                               fontWeight: FontWeight.bold,
      //                               color: Colors.white,
      //
      //                             ),),
      //                           )
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //         );
      //       },);
      //     }else{
      //       return Center(child: CircularProgressIndicator(),);
      //     }
      //   },
      // ),

    );
  }
}
class LevelsCard extends StatelessWidget {
  final level;
  final color;
  final title;
  LevelsCard({this.level,this.color,this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectedUnitScreen(title: level,)));
          },
          child: Container(
            decoration: BoxDecoration(
              color: color,
              boxShadow: [
                BoxShadow(
                  color: color,
                  blurRadius: 5.0,
                  offset: Offset(4, 4),
                ),
              ],
            ),
            margin: new EdgeInsets.all(1.0),
            child: new Center(
              child: new Text(
                level,
                style: GoogleFonts.aBeeZee(
                  fontSize: 50.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
    );
  }
}