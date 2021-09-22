import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnify/selected_unit/selectedunit_screen.dart';

class UnitsPage extends StatefulWidget {
  const UnitsPage({Key? key}) : super(key: key);

  @override
  _UnitsPageState createState() => _UnitsPageState();
}
List<Color>unitsColors=[
  Color(0xfff5b801),
  Color(0xffd52222),
  Color(0xffbf4040),
  Color(0xffe2a244),
  Color(0xfff5b801),
  Color(0xffd52222),
  Color(0xffbf4040),
  Color(0xffe2a244),
  Color(0xff76ec00),
  Color(0xff09b880),
  Color(0xff03e260),
  Color(0xff0295c4),
  Color(0xff02bdbf),
  Color(0xff17418d),
  Color(0xff04c1ab),
  Color(0xff76ec00),
  Color(0xff04c1ab),
  Color(0xff0295c4),
  Color(0xff03d091),
  Color(0xff16bdbf),
  Color(0xff17418d),
  Color(0xff03e260),];
int selectRandomIndex(){
  Random random = new Random();
  int randomNumber = random.nextInt(unitsColors.length);
  return randomNumber;
}
class _UnitsPageState extends State<UnitsPage> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLevel();
  }

int level=1;
Future<int> checkLevel()async{
  await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get().then((value){
      level=int.parse(value['level']);

    });
  return level;
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

  /*24 is for notification bar on Android*/

  final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
  final double itemWidth = size.width / 2;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black45,size: 70),
        ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream:FirebaseFirestore.instance.collection("units").snapshots(),
          builder: (context, snapshot) {
           if(snapshot.hasData){
             List<UnitsCards>UnitsList=[];
             List<String>unitsList=[];
             final units = snapshot.data!.docs;
             for(var unit in units){
               UnitsList.add(new UnitsCards(unit: unit.id));
               unitsList.add(unit.id);
             }
             // return GridView.builder(
             //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
             //   itemCount: 4, itemBuilder: (BuildContext context, int index) {
             //   return
             // },
            //);
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              controller: new ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: UnitsList
            );

           }else{
             return CircularProgressIndicator();
           }
          }
        ),
      )


    );

  }
}


class UnitsCards extends StatelessWidget {
  final unit;
  final color=unitsColors[selectRandomIndex()];
  UnitsCards({this.unit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectedUnitScreen(title: unit,)));
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
              unit,
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
