import 'dart:convert';

import 'package:counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timer_count_down/timer_count_down.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          int j = index;
          return Container(
            width: 250,
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                border: Border.all(color: Colors.green, width: 5)),
            child: Column(
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text("Match : ${index + 1}"),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, i) {
                      int x = (j * 10) + (i + 1);
                      return Container(
                        margin: EdgeInsets.all(10),
                        color: Colors.blueGrey,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Second();
                              },
                            ));
                          },
                          title: Center(
                            child: Text(
                              "Level ${x}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  double a = 5;
  int x=5;
  bool temp = true;
  int a1 = 1;
  List someImages = [];
  List final_img = [];
  List temp1=[];
  Future _initImages() async {
    final_img.clear();
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('image/'))
        .where((String key) => key.contains('.png'))
        .toList();

      someImages = imagePaths;
      someImages.shuffle();

  }
  get()
  async {
  if(temp==true){
    for(int i=5;i>=0;i--)
    {
      await  Future.delayed(Duration(seconds: 1));
      x=i;
      setState(() { });
    }
  }else
    {
      while(true){
        await  Future.delayed(Duration(seconds: 1));
        x++;
        setState(() { });
      }
    }
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    _initImages().then((value) {
      for (int i = 0; i < 6; i++) {
        final_img.add(someImages[i]);
        final_img.add(someImages[i]);
      }
      final_img.shuffle();
      temp1=List.filled(12, true);
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$x"),
      ),
      body: Column(
        children: [
          Countdown(
            seconds: a.toInt(),
            build: (BuildContext context, double time) {
              return SliderTheme(
                child: Slider(
                  value: time,
                  max: 5,
                  min: 0,
                  activeColor: Colors.black,
                  inactiveColor: Colors.grey,
                  onChanged: (double value) {},
                ),
                data: SliderTheme.of(context).copyWith(
                    trackHeight: 10,
                    thumbColor: Colors.transparent,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0)),
              );
            },
            interval: Duration(seconds: 1),
            onFinished: () {
              print('Timer is done!');
              temp1=List.filled(12, false);
              temp=false;
              setState(() {

              });
            },
          ),
          Expanded(
              child:  GridView.builder(
                itemCount: final_img.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return InkWell(child: Visibility(visible: temp1[index],
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("${final_img[index]}"))),
                    ),
                    replacement: Container(
                      color: Colors.blueGrey,
                    ),
                  ),onTap: () {
                    temp1[index]=true;
                    setState(() {

                    });

                  },);
                },
              ) )
        ],
      ),
    );
  }
}
