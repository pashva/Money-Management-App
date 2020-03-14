
import 'package:flutter/material.dart';

import 'databasehelper.dart';
import 'modelexp.dart';


class SecondWidget extends StatefulWidget {
 
  const SecondWidget({
    Key key,
    
   
  }) : super(key: key);


  @override
  _SecondWidgetState createState() => _SecondWidgetState();
}

class _SecondWidgetState extends State<SecondWidget> { 
  bool checkspent=false;
  bool checkearned=false;
  String hint="Select one option from above";
  List<String> dropdown=["Spent","Earned"];
  var db=new DataBaseHelper1();
    TextEditingController x1=new TextEditingController();
    TextEditingController y1=new TextEditingController();
    TextEditingController z1=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    String treason="";
    String tcost="";
    
    
    return Scaffold(
          body: SingleChildScrollView(
                      child: Column(
              
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: height*0.26,
          ),
             RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Add Transaction",
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
              SizedBox(
                height: 20,
              ),
            Container(
              margin: EdgeInsets.only(left:0.039473*height),
             
              decoration:  BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 6,
                          spreadRadius: 10,
                        )
                      ],
                    ),
              height: 0.5*height,
              width: 0.3947*height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Checkbox(
                        
                        value: checkspent,
                        onChanged: (bool value){
                           print(value); 
                           setState(() {
                             hint="Spent on";
                             checkspent=value;
                             if(checkearned==true){
                               checkearned=!checkearned;
                             }
                           });
                        },
                        

                      ),
                      Text("Spent")

                      ],),
                      Row(children: <Widget>[
                        Checkbox(
                        
                        value: checkearned,
                        onChanged: (bool value){
                           print(value); 
                           setState(() {
                             hint="Earned from";
                             checkearned=value;
                             if(checkspent==true){
                               checkspent=!checkspent;
                             }
                           });
                        },
                        

                      ),
                      Text("Earned")

                      ],)
                      
                    ],
                  ),
                
                  SizedBox(
                    height:20
                  ),
                  Container(
                    height: 50,
                    width: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:Colors.white
                    ),
                    
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: y1,
                        decoration: InputDecoration(
                          hintText: hint,
                          border: InputBorder.none
                        ),
                        onChanged: (value){
                          treason=value;
                        },

                      ),
                    ),
                  ),
                  SizedBox(
                    height:20
                  ),
                  Container(
                     height: 50,
                    width: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: z1,
                        
                        decoration: InputDecoration(
                          
                          
                          hintText: "Cost",
                            border: InputBorder.none
                          ),
                        
                        onChanged: (value){
                          tcost=value;
                          
                        },


                      ),
                    ),
                  ),
                  FlatButton(
                    color: Colors.white,
                    onPressed: ()async {
                      if(checkearned==false && checkspent==false){
                        final snackBar = SnackBar(content: Text('Select Spent or Earned'));

                          Scaffold.of(context).showSnackBar(snackBar);
                        
                      }
                      
                      
                      if(checkearned){
                        
                         await db.saveuser(expense(int.parse(tcost),treason,0));
                         final snackBar = SnackBar(content: Text('Earning added successfully'));

                          Scaffold.of(context).showSnackBar(snackBar);
                         

                      }
                      if(checkspent){
                        await db.saveuser(expense(int.parse(tcost),treason,1));
                        final snackBar = SnackBar(content: Text('Expense added successfully'));

                          Scaffold.of(context).showSnackBar(snackBar);

                        
                         
                      }
                    
                   
                    setState(() {
                      x1.clear();
                      y1.clear();
                      z1.clear();
                      checkearned=false;
                      checkspent=false;
                      hint="Select one option from above";
                    });
                    
                  }, child: Text("Press to add")),
                ],
              ),
            ),
        ],
      ),
          ),
    );
  }
}
