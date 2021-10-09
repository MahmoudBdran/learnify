import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnify/levels/levels.dart';
import 'package:learnify/login_package/loginPage.dart';
import 'package:learnify/people_screen.dart';
import 'package:learnify/profile_screen.dart';
import 'package:learnify/selectedtype_screen.dart';
import 'package:learnify/units/UnitsPage.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("user id "+FirebaseAuth.instance.currentUser!.uid);
    }
  final FlutterTts tts = FlutterTts();


  _HomePageState() {
    tts.setLanguage('en');
    tts.setSpeechRate(0.4);
  }


  @override
  Widget build(BuildContext context) {
  var size = MediaQuery.of(context).size;
  final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
  final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // IconButton(onPressed: (){FirebaseAuth.instance.signOut();
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));},
          //     icon: Icon(Icons.logout,color: Colors.black,))
        ],
        iconTheme: IconThemeData(color: Colors.black45,size: 70),
      ),
      drawer: Drawer(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get(),
          builder: (context, snapshot) {
           if(snapshot.hasData){
             DocumentSnapshot<Object?>? doc = snapshot.data;

             return ListView(
               children: [
                 UserAccountsDrawerHeader(
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
                   accountName: Text(doc!['username']),
                   accountEmail: Text(doc!['email']),
                   currentAccountPicture:  Container(
                     width: 140,
                     height: 140,
                     decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         image: DecorationImage(
                             image: NetworkImage(doc!['avatar']))),
                   ),
                 ),
                 ListTile(
                   onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),));},
                   leading: Icon(Icons.person),
                   title: Text("My Profile"),
                   trailing: Icon(Icons.arrow_forward_ios),
                 ),
                 ListTile(
                   onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context) => PeopleScreen(),));},
                   leading: Icon(Icons.search),
                   title: Text("Discover People"),
                   trailing: Icon(Icons.arrow_forward_ios),
                 ),
                 Divider(),
                 ListTile(
                   onTap:(){FirebaseAuth.instance.signOut();},
                   leading: Icon(Icons.logout),
                   title: Text("Sign Out"),
                   trailing: Icon(Icons.arrow_forward_ios),
                 ),
               ],
             );
           }else{
             return Center(child: CircularProgressIndicator(),);
           }
          }
        ),
      ),
      body:  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("type").snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List<String>typesList=[];
            List<String>bgList=[];
            List<String>colorList=[];

            final types = snapshot.data!.docs;
            for(var type in types){
              typesList.add(type.id);
              bgList.add(type['background']);
              colorList.add(type['tile_color']);
            }
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get(),
              builder: (context, snapshot) {

               if(snapshot.hasData){
                 DocumentSnapshot<Object?>? doc = snapshot.data;
                 String username=doc!['username'];
                 return SingleChildScrollView(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(left:8.0),
                         child: Container(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("Welcome.",style: GoogleFonts.aBeeZee(
                                   color: Colors.grey[400],
                                   fontWeight: FontWeight.bold,
                                   fontSize: 24

                               ),),
                               Text(username,style: GoogleFonts.aBeeZee(
                                 color: Colors.black,

                               ),),
                             ],
                           ),
                         ),
                       ),
                       Container(
                         child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[
                               SizedBox(height: 10.0),
                               InkWell(
                                 onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>LevelsPage()));
                                 },
                                 child: Container(
                                   alignment: Alignment.center,
                                   decoration: BoxDecoration(
                                     color: Color(0xFF931D1D),
                                     borderRadius: BorderRadius.circular(15.0),
                                     image:  DecorationImage(
                                       fit: BoxFit.cover,
                                       colorFilter:  ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
                                       image:  AssetImage(
                                           "images/book.jpeg"),
                                     ),
                                     boxShadow: [
                                       BoxShadow(
                                         color: Colors.black12,
                                         blurRadius: 6.0,
                                         offset: Offset(2, 2),
                                       ),
                                     ],
                                   ),
                                   height: 100,
                                   width: MediaQuery.of(context).size.width,
                                   child: Text("Go To Your Vocabulary",style: GoogleFonts.aBeeZee(
                                       fontSize: 30,
                                       color: Colors.white
                                   ),),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                       ),
                       SizedBox(height: 10,),
                       Padding(
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
                                       tts.speak(typesList[index]);
                                     });
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectedTypeScreen(title: typesList[index],)));
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
                                           Image.network(bgList[index],fit: BoxFit.fitWidth,height: 100),
                                           Padding(
                                             padding: const EdgeInsets.only(top:8.0),
                                             child: Text(typesList[index],style: GoogleFonts.aBeeZee(
                                                 color: Colors.black87,
                                                 fontSize: 20
                                             ),),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 );
                               },
                               itemCount: 7,
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
                       // Column(
                       //   children: [
                       //     Container(
                       //       child: Padding(
                       //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                       //         child: Column(
                       //           crossAxisAlignment: CrossAxisAlignment.start,
                       //           children: <Widget>[
                       //             SizedBox(height: 10.0),
                       //             InkWell(
                       //               onTap: (){
                       //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>UnitsPage()));
                       //               },
                       //               child: Container(
                       //                 alignment: Alignment.center,
                       //                 decoration: BoxDecoration(
                       //                   color: Color(0xFF931D1D),
                       //                   borderRadius: BorderRadius.circular(15.0),
                       //                   image:  DecorationImage(
                       //                     fit: BoxFit.cover,
                       //                     colorFilter:  ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
                       //                     image:  AssetImage(
                       //                         "images/book.jpeg"),
                       //                   ),
                       //                   boxShadow: [
                       //                     BoxShadow(
                       //                       color: Colors.black12,
                       //                       blurRadius: 6.0,
                       //                       offset: Offset(2, 2),
                       //                     ),
                       //                   ],
                       //                 ),
                       //                 height: 100,
                       //                 width: MediaQuery.of(context).size.width,
                       //                 child: Text("Go To Your Vocabulary",style: GoogleFonts.aBeeZee(
                       //                     fontSize: 30,
                       //                     color: Colors.white
                       //                 ),),
                       //               ),
                       //             ),
                       //           ],
                       //         ),
                       //       ),
                       //     ),
                       //     Padding(
                       //       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                       //     ),
                       //     SizedBox(height: 10,),
                       //     Padding(
                       //       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                       //       child: Container(
                       //           height: MediaQuery.of(context).size.height,
                       //           child:GridView.builder(
                       //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                       //             itemBuilder: (_, index){
                       //               return InkWell(
                       //                 onTap: (){
                       //                   setState(() {
                       //                     tts.speak(typesList[index]);
                       //                   });
                       //                   Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectedTypeScreen(title: typesList[index],)));
                       //                 },
                       //                 child: Padding(
                       //                   padding: const EdgeInsets.all(8.0),
                       //                   child: Container(
                       //                     alignment: Alignment.center,
                       //                     decoration:  BoxDecoration(
                       //                         borderRadius: BorderRadius.circular(20),
                       //                         color: Colors.grey[200]
                       //                       // image:  DecorationImage(
                       //                       //   image:  NetworkImage(bgList[index]),
                       //                       //   fit: BoxFit.cover,
                       //                       // ),
                       //                     ),
                       //                     child: Column(
                       //                       mainAxisAlignment: MainAxisAlignment.center,
                       //                       children: [
                       //                         Image.network(bgList[index],fit: BoxFit.fitWidth,height: 100),
                       //                         Padding(
                       //                           padding: const EdgeInsets.only(top:8.0),
                       //                           child: Text(typesList[index],style: GoogleFonts.aBeeZee(
                       //                               color: Colors.black87,
                       //                               fontSize: 20
                       //                           ),),
                       //                         ),
                       //                       ],
                       //                     ),
                       //                   ),
                       //                 ),
                       //               );
                       //             },
                       //             itemCount: 7,
                       //           )
                       //         /* Container(
                       //         alignment: Alignment.center,
                       //         decoration:  BoxDecoration(
                       //           // image:  DecorationImage(
                       //           //   image:  NetworkImage(bgList[index]),
                       //           //   fit: BoxFit.cover,
                       //           // ),
                       //         ),
                       //         child: Column(
                       //           children: [
                       //             Image.network(bgList[index],fit: BoxFit.cover,),
                       //             Text(typesList[index]),
                       //           ],
                       //         ),
                       //       ),*/
                       //       ),
                       //     ),
                       //   ],
                       // ),
                     ],
                   ),
                 );
               }else{
                 return Center(child: CircularProgressIndicator(),);
               }
              }
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      )
    );
  }
}
class TypesTiles extends StatelessWidget {
  final type;
  final color;
  TypesTiles({this.type,this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectedTypeScreen(title: type)));
        },
        child: Container(
          decoration: BoxDecoration(
            color:  Color(int.parse(color)),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Text(type,style: GoogleFonts.aBeeZee(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,

          ),),
        ),
      ),
    );
  }
}

