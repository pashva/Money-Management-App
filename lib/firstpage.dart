import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

import 'card.dart';

import 'databasehelper.dart';
import 'modelexp.dart';



class Firstwidget extends StatefulWidget {
  
  @override
  _FirstwidgetState createState() => _FirstwidgetState();
}

class _FirstwidgetState extends State<Firstwidget> {
 List e=[];
 List s=[];
  var db=new DataBaseHelper1();
  Future<List> load()async {
    List a=await db.getallusers();
    List<expense> sett=[];
    for(int i =0;i<a.length;i++){
      sett.add(expense(expense.fromMap(a[i]).cost,expense.fromMap(a[i]).exp,expense.fromMap(a[i]).state));

    }
    
        setState(() {
         e=sett;
         s=a;

        });
    
    
  }
  @override
  void initState() {
   load();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    
    return Padding(
      padding:  EdgeInsets.only(top: 0.08*height,left: 0.040*height),
      child: Container(
      height: height,
      width: width,
      child: Column(
        children: <Widget>[
         
          SizedBox(
            height: 0.013*height,
          ),
          Padding(
            padding:  EdgeInsets.only(left: 0.030*height),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Recent Transactions",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 0.032*height,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Varela",
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
      
          Container(
              height: 0.763*height,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: e.length,
                itemBuilder: (_,int index){
                if(e[index].state==1){
                  return  GestureDetector(
                    onDoubleTap: ()async {
                      
                     int a= await db.deleteUser(expense.fromMap(s[index]).id);
                     print(a);
                        setState(() {
                          e.removeAt(index);
                        });
                    },
                                      child: EasyCard(
                      prefixBadge: Colors.red[400],
                      icon: Icons.cancel,
                      iconColor: Colors.red[400],
                      title: e[index].exp,
                      description:"-"+e[index].cost.toString(),
                      suffixIcon: Icons.chevron_right,
                      suffixIconColor: Colors.red[400],
                ),
                  );

                }else{
                  return  GestureDetector(
                     onDoubleTap: ()async {
                      
                      int a=await db.deleteUser(expense.fromMap(s[index]).id);
                      print(a);
                        setState(() {
                          e.removeAt(index);
                        });
                    },
                                      child: EasyCard(
                      prefixBadge: Colors.blue[400],
                      icon: Icons.check_box,
                      iconColor: Colors.blue[400],
                      title: e[index].exp,
                      description:"+"+e[index].cost.toString(),
                      suffixIcon: Icons.chevron_right,
                      suffixIconColor: Colors.blue[400],
                ),
                  );
                }
              }),
            ),
        ],
      ),
      ),
    );
  }
}
 
