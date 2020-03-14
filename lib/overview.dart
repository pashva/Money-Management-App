import 'package:flutter/material.dart';

import 'package:money_management/modelexp.dart';

import 'package:money_management/percent_indicator.dart';
import 'package:money_management/screensize.dart';
import 'package:money_management/wave_progress.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'databasehelper.dart';


class OverviewPage extends StatefulWidget {
  
  List<expense> cf;
  
  OverviewPage({this.cf});
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  List<expense> e=[];
  List<expense> cf=[];
  List<expense> cf2=[];
  int ts=0;
  int te=0;
  bool left=false;
  var db=new DataBaseHelper1();
  Future<List> loadcf()async {
    List a=await db.getallusers();
    List<expense> sett=[];
    for(int i =0;i<a.length;i++){
      sett.add(expense(expense.fromMap(a[i]).cost,expense.fromMap(a[i]).exp,expense.fromMap(a[i]).state));

    }
    if(mounted){
      setState(() {
         e=sett;

        });
    }
  }
  Future<List> loadchart()async {
    List a=await db.getallusers();
    List<expense> sett=[];
    int totalspent=0;
    int totalearned=0;
    for(int i =0;i<a.length;i++){
      if(expense.fromMap(a[i]).state==1){
        sett.add(expense(expense.fromMap(a[i]).cost,expense.fromMap(a[i]).exp,expense.fromMap(a[i]).state));
        totalspent+=expense.fromMap(a[i]).cost;
      }else{
        totalearned+=expense.fromMap(a[i]).cost;
      }
    }
    if(mounted){
      setState(() {
         cf=sett;
         ts=totalspent;
         te=totalearned;
         if(te>ts || te==ts){
           left=true;
         }

        });

    }
  }
  Future<List> loadchart2()async {
    List a=await db.getallusers();
    List<expense> sett=[];
   
    for(int i =0;i<a.length;i++){
      if(expense.fromMap(a[i]).state==0){
        sett.add(expense(expense.fromMap(a[i]).cost,expense.fromMap(a[i]).exp,expense.fromMap(a[i]).state));
        
      }else{
      
      }
    }
    if(mounted){
      setState(() {
         cf2=sett;
     
        });

    }
  }
  @override
  void initState() {
    loadchart();
    loadcf();
    loadchart2();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final _media = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: 20,
          top: 70,
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Overview",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            "Accounts",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              inherit: true,
              letterSpacing: 0.4,
            ),
          ),
          Row(
            children: <Widget>[
              colorCard("Total Spent", ts.toDouble(), -1, context, Color(0xFF1b5bff)),
              colorCard("Total Earned", te.toDouble(), 1, context, Color(0xFFff3f5e)),
              
            ],
          ),
          SizedBox(
            child: left? colorCard("Balance Left", te.toDouble()-ts.toDouble() ,1, context,Color(0xFFffc01b)):colorCard("Overdue", (ts-te).toDouble() ,-1, context,Color(0xFF00ddee)),
          ),
          SizedBox(
            height: 20,
          ),

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Spending",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Varela",
                  ),
                ),
                
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 15,
              right: 20,
            ),
            height:450,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 6,
                  spreadRadius: 10,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: <Widget>[
                Container(
                  height: 400,
                  width: 300,
                  child: SfCircularChart(
                    tooltipBehavior: TooltipBehavior(enable: true),
                    
                  
                    legend: Legend(isVisible: true),
                  
                    
                    series: <PieSeries>[
                       PieSeries<expense, String>(
                          explode: true,
                          explodeIndex: 0,
                          explodeOffset: '10%',

                          dataSource: cf,
                          xValueMapper: (expense data, _) => data.exp,
                          yValueMapper: (expense data, _) => data.cost,
                          dataLabelMapper: (expense data, _) => data.cost.toString(),
                          
      
                          // dataLabelSettings: DataLabelSettings(isVisible: true)
                          ),
                    ]
                    
                  )
                ),
            
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          RichText(
            text: TextSpan(
              children: [  
                TextSpan(
                  text: "Earned",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Varela",
                  ),
                ),
                
              ],
            ),
          ),
          Container(
            
            margin: EdgeInsets.only(
              top: 15,
              right: 20,
            ),
            padding: EdgeInsets.all(10),
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 6,
                  spreadRadius: 10,
                )
              ],
            ),
            child: SfCircularChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              legend: Legend(isVisible:true),
                  series: <RadialBarSeries<expense, String>>[
        RadialBarSeries<expense, String>(
          
                maximumValue: 100,
              radius: '100%',
              gap: '2%',
              innerRadius: '30%',
           
            // dataLabelSettings: DataLabelSettings(
            //     isVisible: true),
            dataSource: cf2,
            cornerStyle: CornerStyle.bothCurve,
            
           
            xValueMapper: (expense data, _) => data.exp,
            yValueMapper: (expense data, _) => data.cost,
            dataLabelMapper: (expense data, _) => data.exp,
             
            )  ],
             
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Cash flow",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              inherit: true,
              letterSpacing: 0.4,
            ),
          ),
          Container(
            height: 300,
            width: 300,
            child: ListView.builder( 
              itemCount: e.length,

              itemBuilder: (context,int i){
                if(e[i].state==0){
                  if(e[i].cost>1000){
                     return  vaweCard(context, e[i].exp, e[i].cost.toDouble(), 1, Colors.lightBlue, Colors.lightBlue,85);
                  }
                  if(e[i].cost>500){
                     return  vaweCard(context, e[i].exp, e[i].cost.toDouble(), 1, Colors.lightBlue, Colors.lightBlue,67);

                  }
                  else{
                     return  vaweCard(context, e[i].exp, e[i].cost.toDouble(), 1, Colors.lightBlue, Colors.lightBlue,33);
                  }
                 
                }else{
                  if(e[i].cost>1000){
                    return  vaweCard(context, e[i].exp, e[i].cost.toDouble(),0, Colors.red, Colors.red,85);

                  }
                  
                  if(e[i].cost>500 && e[i].cost<1000){
                    return  vaweCard(context, e[i].exp, e[i].cost.toDouble(),0, Colors.red, Colors.red,67);

                  }
                  else{
                    return  vaweCard(context, e[i].exp, e[i].cost.toDouble(),0, Colors.red, Colors.red,45);
                  }
                  
                }
              
            }),
          )
          
        
        ],
      ),
    );
  }

  Widget vaweCard(BuildContext context, String name, double amount, int type,
      Color fillColor, Color bgColor,int prog) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
        right: 20,
      ),
      padding: EdgeInsets.only(left: 15),
      height: screenAwareSize(80, context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 6,
            spreadRadius: 10,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              WaveProgress(
                screenAwareSize(45, context),
                fillColor,
                bgColor,
                prog.toDouble(),
              ),
              
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "${type > 0 ? "+" : "-"} ${amount.toString()}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  

  Widget colorCard(
      String text, double amount, int type, BuildContext context, Color color) {
    final _media = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 15, right: 15),
      padding: EdgeInsets.all(15),
      height: screenAwareSize(90, context),
      width: _media.width / 2 - 25,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 16,
                spreadRadius: 0.2,
                offset: Offset(0, 8)),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "${type > 0 ? "" : "-"}  ${amount.toString()}",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}