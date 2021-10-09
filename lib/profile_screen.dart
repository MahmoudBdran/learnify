// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: FutureBuilder<DocumentSnapshot>(
//             future: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get(),
//             builder: (context, snapshot) {
//               if(snapshot.hasData){
//
//                 DocumentSnapshot<Object?>? doc = snapshot.data;
//                 String username=doc!['username'];
//                 String avatar=doc!['avatar'];
//                 int level1_score=doc!['level1_score'];
//                 int level2_score=doc!['level2_score'];
//                 int level3_score=doc!['level3_score'];
//                 int level4_score=doc!['level4_score'];
//                 int level5_score=doc!['level5_score'];
//                 int level6_score=doc!['level6_score'];
//                 int level7_score=doc!['level7_score'];
//                 int level8_score=doc!['level8_score'];
//                 int points=doc!['points'];
//                 return Container(
//                   alignment: Alignment.center,
//                   child: Column(
//                     children: [
//                       SizedBox(height: 50,),
//                       Container(
//                         alignment: Alignment.center,
//                         width: 180,
//                         height: 180,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image: NetworkImage(doc!['avatar']))),
//                       ),
//
//                       SizedBox(height: 10,),
//                       Text(username,),
//                     ],
//                   ),
//                 );
//               }else{
//                 return Center(child: CircularProgressIndicator(),);
//               }
//             }
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
  late String uid;
  ProfileScreen({required String uid}){
    this.uid=uid;
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth auth=FirebaseAuth.instance;
  CollectionReference userInfo=FirebaseFirestore.instance.collection("users");
  String get uid=>widget.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xff7b32ea),

      body: Container(
        decoration: BoxDecoration(
            gradient:LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff7b32ea),
                Color(0xff760097),
              ],
            )
        ),
        child: FutureBuilder(
            future: userInfo.doc(uid).get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if(snapshot.hasData){
                // Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;
                // return Text("Full Name: ${data?['username']} ${data?['email']}");
                //print(snapshot.data!['username']);
                DocumentSnapshot<Object?>? doc = snapshot.data;
                String username=doc!['username'];
                String avatar=doc!['avatar'];
                int level1_score=doc!['level1_score'];
                int level2_score=doc!['level2_score'];
                int level3_score=doc!['level3_score'];
                int level4_score=doc!['level4_score'];
                int level5_score=doc!['level5_score'];
                int level6_score=doc!['level6_score'];
                int level7_score=doc!['level7_score'];
                int level8_score=doc!['level8_score'];
                int points=doc!['points'];
                return ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(avatar),
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(username,style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white
                        ),)
                      ],
                    ),
                    SizedBox(height: 20,),
                    Column(
                      children: [
                        ListTile(
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: Colors.deepOrangeAccent,
                                  shape: BoxShape.circle
                              ),child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.star,color: Colors.yellowAccent,),
                          )),
                          title: Text("Total Points",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                          ),),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(points.toString(),style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                        Divider(),
                        uid==FirebaseAuth.instance.currentUser!.uid?Text("Your Scores",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white60
                        ),):Text("his/her Scores",style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white60
                        ),),
                        ListTile(
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xfff5009b),
                                  shape: BoxShape.circle
                              ),child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.dashboard,color: Colors.white,),
                          )),
                          title: Text("Level 1",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                          ),),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(level1_score.toString(),style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xfff5009b),
                                  shape: BoxShape.circle
                              ),child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.event,color: Colors.white,),
                          )),
                          title: Text("Level 2",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                          ),),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(level2_score.toString(),style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xfff5009b),
                                  shape: BoxShape.circle
                              ),child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.extension,color: Colors.white,),
                          )),
                          title: Text("Level 3",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                          ),),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(level3_score.toString(),style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xfff5009b),
                                  shape: BoxShape.circle
                              ),child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.motorcycle,color: Colors.white,),
                          )),
                          title: Text("Level 4",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                          ),),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(level4_score.toString(),style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xfff5009b),
                                  shape: BoxShape.circle
                              ),child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.dashboard_outlined,color: Colors.white,),
                          )),
                          title: Text("Level 5",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                          ),),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(level5_score.toString(),style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xfff5009b),
                                  shape: BoxShape.circle
                              ),child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.pets,color: Colors.white,),
                          )),
                          title: Text("Level 6",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                          ),),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(level6_score.toString(),style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xfff5009b),
                                  shape: BoxShape.circle
                              ),child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.done,color: Colors.white,),
                          )),
                          title: Text("Level 7",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                          ),),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(level7_score.toString(),style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xfff5009b),
                                  shape: BoxShape.circle
                              ),child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.highlight,color: Colors.white,),
                          )),
                          title: Text("Level 8",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                          ),),
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(level8_score.toString(),style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                        ),




                      ],
                    ),

                  ],
                );
              }else{
                return Center(child: CircularProgressIndicator(color: Colors.purple,));
              }
            }
        ),
      ),
    );
  }
}