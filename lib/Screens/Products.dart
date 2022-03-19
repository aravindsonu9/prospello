import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'Home.dart';

class Products extends StatefulWidget {
  const Products({Key key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  String _selectedPerson = "Aravind Sonu";
  String _selectedManager;
  bool _isOnline = false;

  double iconContainerHeight = 50;

  TextEditingController shopEditingController = TextEditingController();
  TextEditingController locationEditingController = TextEditingController();
  TextEditingController totalAmtEditingController = TextEditingController();
  TextEditingController targetEditingController = TextEditingController();

  ScrollController _controller;

  List persons = [
    {"name": "Aravind Sonu", "id": "1"},
    {"name": "Praveen Kumar", "id": "2"}
  ];
  List managers = [
    {"name": "Raveendar", "id": "1"},
    {"name": "Mohan Kumar", "id": "2"}
  ];

  List toDoList = [];

  void initState() {
    setState(() {
      _isOnline = true;
    });
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      if (iconContainerHeight != 0)
        setState(() {
          iconContainerHeight = 0;
        });
    }
    if (_controller.position.userScrollDirection == ScrollDirection.forward) {
      if (iconContainerHeight == 0)
        setState(() {
          iconContainerHeight = 55;
        });
    }
    if (_controller.position.pixels == 0) {
      if (iconContainerHeight == 0)
        setState(() {
          iconContainerHeight = 55;
        });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      appBar: AppBar(
        title: Text("Add Shop"),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20,10,20,0),
            child: Row(
              children: [
                Expanded(
                  child: CustomDropDown(
                    selectedValue: _selectedPerson,
                    list: persons,
                    hint: "Person Name",
                    height: 35,
                    onChanged: (value){
                      setState(() {
                        _selectedPerson = value;
                        print(value);
                      });},
                  ),
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: CustomDropDown(
                    selectedValue: _selectedManager,
                    list: managers,
                    hint: "Manager Name",
                    height: 35,
                    onChanged: (value){
                      setState(() {
                        _selectedManager = value;
                      });},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,10,20,0),
            child: Row(
              children: [
                Badge(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    backgroundImage: NetworkImage('https://docs.flutter.dev/assets/images/dash/dash-fainting.gif')),
                  toAnimate: true,
                  showBadge: _isOnline,
                  shape: BadgeShape.circle,
                  animationType: BadgeAnimationType.slide,
                  animationDuration: Duration(milliseconds: 800),
                  badgeColor: Colors.green,
                  position: BadgePosition.topEnd(top: 3,end: 3),
                  badgeContent: CircleAvatar(radius: 1.5,backgroundColor: Colors.white,),
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$_selectedPerson", style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.w600),),
                    Text("Shop name", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 25,),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25), topLeft: Radius.circular(25)),
              ),
              child: SingleChildScrollView(
                controller: _controller,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,10,20,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      ListView.builder(
                        shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: toDoList.length,
                          itemBuilder: (context,index){
                            return listViewObject(
                              toDoList[index]['shopName'],
                              toDoList[index]['location'],
                              toDoList[index]['totalAmt'],
                              toDoList[index]['target'],
                                index);
                          }),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: buildTextField(
                              "Shop Name",
                              shopEditingController
                            ),
                          ),
                          SizedBox(width: 12,),
                          Expanded(
                            flex: 2,
                            child: buildTextField(
                              "Location",
                              locationEditingController
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: buildTextField(
                                "Total Amount",
                                totalAmtEditingController
                            ),
                          ),
                          SizedBox(width: 12,),
                          Expanded(
                            flex: 2,
                            child: buildTextField(
                                "Target",
                                targetEditingController
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      CustomButton(
                        onTap: (){
                          setState(() {
                            addMore();
                          });
                        },
                        text: "Add More",
                        height: 40,
                        width: 100,
                        bgColor: Colors.black,
                        textColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(width: 0.5)),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            height: iconContainerHeight,
            duration: Duration(milliseconds: 200),
            padding: const EdgeInsets.fromLTRB(4,0,4,7),
            color: Colors.white,
            child: CustomButton(
              text: "Upload",
              onTap: (){
                setState(() {
                  toDoList.clear();
                });
              },
              fontSize: 18,
              // height: 50,
              bgColor: Colors.black,
              textColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }





   addMore(){
      toDoList.add(
          {
            "shopName":shopEditingController.text,
            "location":locationEditingController.text,
            "totalAmt":totalAmtEditingController.text,
            "target":targetEditingController.text,
          }
      );
      print(toDoList.length);
      shopEditingController.clear();
      locationEditingController.clear();
      totalAmtEditingController.clear();
      targetEditingController.clear();
  }

  //  delete(index){
  //    toDoList.removeAt(index);
  // }

  Column listViewObject(shopName,location,totalAmt,target,index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: buildTextContainer("$shopName"),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 2,
              child: buildTextContainer("$location"),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: buildTextContainer("$totalAmt"),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 2,
              child: buildTextContainer("$target"),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            CustomButton(
              onTap: (){
                setState(() {
                  toDoList.removeAt(index);
                });
              },
              text: "Delete",
              height: 36,
              width: 100,
              bgColor: Colors.black,
              textColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(width: 0.5)),
            ),
            SizedBox(width: 7,),
            CustomButton(
              onTap: () {},
              text: "Update todo list",
              height: 36,
              width: 120,
              bgColor: Colors.white,
              textColor: Colors.black,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(width: 0.5)),
            ),
          ],
        ),
        SizedBox(height: 15,)
      ],
    );
  }

  Container buildTextContainer(text) {
    return Container(
      height: 50,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(12, 0, 10, 0),
      decoration: BoxDecoration(
          color: Color(0xfff7f6f6), borderRadius: BorderRadius.circular(10)),
      child: Text("$text"),
    );
  }

  Column buildTextField(hint,controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: FittedBox(
              child: Text("$hint",
                  style: TextStyle(color: Colors.black, fontSize: 16))),
        ),
        SizedBox(
          height: 6,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: Color(0xfff7f6f6),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
          ),
        )
      ],
    );
  }
}
