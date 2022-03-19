import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  double percent = 0.0;
  String _selectedPerson;
  String _cycle = "Jan 06 - Jan 12";

  TabController _tabController;

  List list = [
    {"day": "Tuesday", "date": "15 Mar 2020", "hours": "8:46"},
    {"day": "Wednesday", "date": "16 Mar 2020", "hours": "3:28",}
  ];
  List persons = [
    {"name": "Aravind", "id": "1"},
    {"name": "Sonu", "id": "2"}
  ];
  List weeklyProgress = [2.3,4.6,3.1,6.8,4.9,2.2,1.6];
  List monthlyProgress = [2.6,7.2,6.5,2.6,3.5,2.3,4.6,3.1,6.8,4.9,2.2,1.6];

  void initState() {
      setState(() {
        percent = 76.0;
    });
      _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffF9F8FB),
      appBar: AppBar(
        title: Text("Merchant Leave Report"),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20, 13, 5, 13),
          child: Container(
            child: Icon(
              Icons.arrow_back_ios_sharp,
              size: 15,
              color: Colors.black,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
      body: ScrollConfiguration(
        behavior: new ScrollBehavior()..buildViewportChrome(context, null, AxisDirection.down),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 325,
                color: Colors.black,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,0,20,0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomDropDown(
                        selectedValue: _selectedPerson,
                        list: persons,
                        hint: "Person Name",
                        height: 32,
                        width: 130,
                        onChanged: (value){
                          setState(() {
                            _selectedPerson = value;
                          });},
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 340,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 10,),
                          Text("Overall Performance", style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600),),
                          Text("$_cycle", style: TextStyle(color: Color(0xffa0a2ad))),
                          Container(
                            width: size.width*0.82,
                            height: 40,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Color(0xffeef3fb),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TabBar(
                              controller: _tabController,
                              labelColor: Colors.black,
                              indicator: ShapeDecoration(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                  color: Colors.white
                              ),
                              tabs: [
                                Text("Weekly"),
                                Text("Monthly"),
                                Text("All time"),
                              ],
                              onTap: (value) {
                                if(value == 0){setState(() {_cycle = "Jan 06 - Jan 12";});}
                                if(value == 1){setState(() {_cycle = "Jan 2021 - Dec 2021";});}
                                if(value == 2){setState(() {_cycle = "All Time";});}
                              },
                            ),
                          ),
                          Container(
                            width: size.width*0.9,
                            height: 190,
                            child: TabBarView(
                              controller: _tabController,
                              children: [
                                WeekBuilder(
                                  dayHeight: 150,
                                  dayWidth: 25,
                                  totalWidth: size.width*0.9,
                                  leftPadding: 15,
                                  starPercentage: 75,
                                  totalHrs: 8,
                                  list: weeklyProgress,
                                ),
                                MonthBuilder(
                                  monthHeight: 150,
                                  monthWidth: 25,
                                  separatorWidth: 19,
                                  leftPadding: 15,
                                  totalHrs: 8,
                                  starPercentage: 75,
                                  list: monthlyProgress,
                                ),
                                Container(),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15,0,15,10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Complete View", style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                      Text("View your complete view for leave", style: TextStyle(color: Color(0xffa0a2ad))),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 26,height: 26,
                                  child: Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    size: 15,
                                    color: Color(0xffffbf49),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xffffeecf),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    CustomButton(
                      onTap: (){},
                      text: "Download Report",
                      height: 50,
                      bgColor: Color(0xFF000000),
                      textColor: Colors.white,
                      fontSize: 18,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide: BorderSide(color: Colors.white,width: 0.5)),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: (){},
                            text: "Pay Slip",
                            height: 50,
                            bgColor: Color(0xFF000000),
                            textColor: Colors.white,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide: BorderSide(color: Colors.white,width: 0.5)),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: CustomButton(
                            onTap: (){},
                            text: "Payment Breakdown",
                            height: 49,
                            bgColor: Color(0xFFFFFFFF),
                            textColor: Colors.black,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),borderSide: BorderSide(width: 0.5)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF4880),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12,0,35,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: CircularPercentIndicator(
                                percent: percent/100,
                                center: FittedBox(
                                  child: Text( percent.toString().split('.').first + "%",
                                    style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600, color: Colors.white),),
                                ),
                                radius: 30,
                                animation: true,
                                animationDuration: 1000,
                                circularStrokeCap: CircularStrokeCap.round,
                                backgroundColor: Colors.white.withOpacity(0.3),
                                progressColor: Color(0xffffd369),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Expanded(
                              flex: 6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("On - Time Arrival",
                                    style: TextStyle( fontSize: 16,fontWeight: FontWeight.w700, color: Colors.white),),
                                  SizedBox(height: 5,),
                                  FittedBox(
                                    child: Text("From Feb 20, 2020 to 15 Mar, 2020",
                                      style: TextStyle(color: Color(0xffffd4e1)),),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("Recent Logs", style: TextStyle(color: Color(0xffbcbec4))),
                    SizedBox(height: 10,),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                        itemBuilder: (context,index){
                      return   Column(
                        children: [
                          RecentListTile(
                            day: list[index]['day'],
                            date: list[index]['date'],
                            hours: list[index]['hours'],
                          ),
                          SizedBox(height: 10,)
                        ],
                      );
                    }),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
     );
  }
}

class WeekBuilder extends StatelessWidget {
  const WeekBuilder({this.list,this.totalHrs,this.dayHeight,this.dayWidth,this.totalWidth,this.leftPadding,this.starPercentage});
  final List list;
  final double totalHrs;
  final double totalWidth;
  final double starPercentage;
  final double dayHeight;
  final double dayWidth;
  final double leftPadding;

  @override
  Widget build(BuildContext context) {
    List days = ["M","T","W","T","F","S","S"];
    var i = totalWidth-7*dayWidth;
    print(i);
    var j = i-leftPadding;
    print(j/7);
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: j/7,);},
        itemBuilder: (context,index){
          return DayBar(
            hours: list[index],
            totalHours: totalHrs,
            height: dayHeight,
            width: dayWidth,
            starPercentage: starPercentage,
            day: days[index]
          );
        },
      ),
    );
  }
}

class MonthBuilder extends StatelessWidget {
  const MonthBuilder({this.list,this.totalHrs,this.monthHeight,this.monthWidth,this.separatorWidth,this.leftPadding,this.starPercentage});
  final List list;
  final double totalHrs;
  final double separatorWidth;
  final double starPercentage;
  final double monthHeight;
  final double monthWidth;
  final double leftPadding;

  @override
  Widget build(BuildContext context) {
    List months = ["JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"];
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: separatorWidth,);},
        itemBuilder: (context,index){
          return Row(
            children: [
              DayBar(
                  hours: list[index],
                  totalHours: totalHrs,
                  height: monthHeight,
                  width: monthWidth,
                  starPercentage: starPercentage,
                  day: months[index]
              ),
              if(index==months.length-1)SizedBox(width: leftPadding,)
            ],
          );
        },
      ),
    );
  }
}

class DayBar extends StatelessWidget {
  const DayBar({this.day,this.height,this.width,this.hours,this.totalHours,this.starPercentage});
  final double height;
  final double hours;
  final double totalHours;
  final double starPercentage;
  final double width;
  final String day;

  @override
  Widget build(BuildContext context) {
    double progress = hours/totalHours*height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  color: Color(0xffeef3fb),
                  borderRadius: BorderRadius.circular(30)
              ),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: progress>height?height:progress,
                  width: width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          const Color(0xFF3366FF),
                          const Color(0xFF00CCFF),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.circular(30)
                  ),
                ),
                if(hours/totalHours*100>starPercentage)Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Icon(Icons.star,color: Colors.white,size: 18,),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10,),
        Text("$day")
      ],
    );
  }
}

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    Key key,
    @required String selectedValue,
    @required this.list,this.height,this.width,this.onChanged,this.hint
  }) : _selectedValue = selectedValue, super(key: key);

  final String _selectedValue;
  final String hint;
  final List list;
  final Function onChanged;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 0, 5, 0),
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            elevation: 0,
            value: _selectedValue,
            style: TextStyle(color: Colors.black),
            items: list.map((value) {
              return DropdownMenuItem<String>(
                child: Text(value['name']),
                value: value['name'],
                // value: value['id'],
              );
            }).toList(),
            hint: FittedBox(
              child: Text(
                "$hint",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      ),);
  }
}

class RecentListTile extends StatelessWidget {
  const RecentListTile({this.day,this.date,this.hours});
  final String day;
  final String date;
  final String hours;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.5, 0, 1, 0),
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(day, style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                Text(date, style: TextStyle(color: Color(0xffa0a2ad))),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.track_changes_outlined,color: Colors.blue,size: 28,),
                Text(hours+" Hrs",),
              ],
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  offset: Offset(0.0, 2),
                  spreadRadius: 0.1,
                  blurRadius: 6)
            ]),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({this.height,this.bgColor,this.text,this.textColor,this.border,this.fontSize,this.onTap,this.width});
  final double height;
  final double width;
  final double fontSize;
  final Color bgColor;
  final Color textColor;
  final String text;
  final OutlineInputBorder border;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: FittedBox(child: Text(text,
            style: TextStyle(color: textColor,fontSize: fontSize),)),
        ),
        onTap: onTap,
         borderRadius: BorderRadius.circular(25),
      ),
      color: bgColor,
      shape: border,
      // shape: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(25),
      // ),
    );
  }
}
