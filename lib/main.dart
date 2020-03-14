import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:money_management/overview.dart';

import 'firstpage.dart';
import 'secondscree.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      
      
      home: Example(),
    );
  }
}
class Example extends StatefulWidget {
  
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  //  static List<expense> e=[];
  // static List<expense> cf=[];
  // var db=new DataBaseHelper1();
  // Future<List> load()async {
  //   List a=await db.getallusers();
  //   List<expense> sett=[];
  //   for(int i =0;i<a.length;i++){
  //     sett.add(expense(expense.fromMap(a[i]).cost,expense.fromMap(a[i]).exp,expense.fromMap(a[i]).state));

  //   }
  //   if(mounted){
  //       setState(() {
  //         e=sett;

  //       });
  //   }
        
    

  //   return sett;
  // }
  
  

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
   List<Widget> _widgetOptions = <Widget>[
     Firstwidget(),
   
    SecondWidget(),
    OverviewPage()
    
    
  ];

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      
      
      
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
            color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                  gap: 6,
                  activeColor: Colors.white,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  duration: Duration(milliseconds: 800),
                  tabBackgroundColor: Colors.grey[800],
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.add,
                      text: 'Add Transaction',
                    ),
                    GButton(
                      icon: Icons.account_balance_wallet,
                      text: 'Overview',
                    ),
                    
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
