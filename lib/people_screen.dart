import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnify/profile_screen.dart';

class PeopleScreen extends StatefulWidget {

  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map((doc) {
          if(doc['uid']!=FirebaseAuth.instance.currentUser!.uid){
            return ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(uid:doc['uid']),));
              },
              leading:Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(doc['avatar']),
                    )),
              ),
              title: Text(
                doc['username'],
                style: GoogleFonts.aBeeZee(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text("Total Points : "+doc["points"].toString(),style:GoogleFonts.aBeeZee(),),
            );
          }else{
            return SizedBox(height: 1,);
          }
    })
        .toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color:   Colors.black54),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Discover People",style: GoogleFonts.aBeeZee(
            fontWeight: FontWeight.bold,
            color: Colors.black54
        ),),
      ),
      body: SafeArea(

        child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection("users").get(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return  ListView(children: getExpenseItems(snapshot));
                // return ListView.builder(
                //     itemCount: Friends.length,
                //     itemBuilder: (context, index) {
                //       return Container(
                //         margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //         decoration: BoxDecoration(
                //             color: Color(0xff300a6a),
                //             border: Border.all(color: Color(0xFFEEEEEE)),
                //             borderRadius: BorderRadius.all(Radius.circular(15))),
                //         child: Row(
                //           children: [
                //             Expanded(
                //               flex: 10,
                //               child: InkWell(
                //                 onTap: (){
                //                   Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                //                           builder: (context) => ChatScreen()));
                //
                //                 },
                //                 child: Container(
                //
                //                   color: Colors.white,
                //                   child: ListTile(
                //                     leading: Friends[index]['story'] > 0
                //                         ? Stack(
                //                       children: [
                //
                //                         Container(
                //                           width: 65,
                //                           height: 65,
                //                           padding: EdgeInsets.all(1),
                //                           decoration: BoxDecoration(
                //                             shape: BoxShape.circle,
                //                             border: Border.all(color :Color(0xff384dfd),width: 2),
                //                           ),
                //                           child: Container(
                //                             width: 65,
                //                             height: 65,
                //                             decoration: BoxDecoration(
                //                                 shape: BoxShape.circle,
                //                                 image: DecorationImage(
                //                                   fit: BoxFit.cover,
                //                                   image:
                //                                   NetworkImage(Friends[index]["image"]),
                //                                 )),
                //                           ),
                //                         ),
                //                       ],
                //                     )
                //                         : Container(
                //                       width: 65,
                //                       height: 65,
                //                       decoration: BoxDecoration(
                //                           shape: BoxShape.circle,
                //                           image: DecorationImage(
                //                             fit: BoxFit.cover,
                //                             image: NetworkImage(Friends[index]["image"]),
                //                           )),
                //                     ),
                //                     title: Text(
                //                       Friends[index]["name"],
                //                       style: TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                     subtitle: Text(Friends[index]["status"]),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             Expanded(
                //               flex: 2,
                //               child: InkWell(
                //                 onTap: (){
                //                   Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                //                           builder: (context) => PersonProfile()));
                //
                //                 },
                //                 child: Container(
                //                   alignment: Alignment.center,
                //                   child: IconButton(
                //                     onPressed: (){
                //                       Navigator.push(
                //                           context,
                //                           MaterialPageRoute(
                //                               builder: (context) => PersonProfile()));
                //
                //                     },
                //                     icon: Icon(
                //                       EvaIcons.person,
                //                       color: Colors.white,
                //                     ),
                //
                //                   ),
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //       );
                //     });
              }else{
                return Center(child: CircularProgressIndicator(),);
              }
            }
        ),
      ),
    );
  }
}