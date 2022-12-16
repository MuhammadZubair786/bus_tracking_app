import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BustRacker extends StatefulWidget {
  const BustRacker({super.key});

  @override
  State<BustRacker> createState() => _BustRackerState();
}

class _BustRackerState extends State<BustRacker> {

   List Bus_List =[
  {"Time":"7pm to 10pm ",
  "route":"Data 1 to data 2",

  },
  {"Time":"7pm ",
  "route":"Data 2 to data 3",

  },
  {"Time":"7pm ",
  "route":"Data 3 to data 4",

  },
  {"Time":"7pm to 10pm ",
  "route":"Data 1 to data 2",

  },
  {"Time":"7pm ",
  "route":"Data 2 to data 3",

  },
  {"Time":"7pm ",
  "route":"Data 3 to data 4",

  },
   {"Time":"7pm ",
  "route":"Data 2 to data 3",

  },
  {"Time":"7pm ",
  "route":"Data 3 to data 4",

  },
   {"Time":"7pm ",
  "route":"Data 2 to data 3",

  },
  {"Time":"7pm ",
  "route":"Data 3 to data 4",

  }
 ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SafeArea(
          child: Container(
           decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Color.fromARGB(255, 197, 243, 167),
                  Color.fromARGB(255, 174, 243, 127),
                  Color.fromARGB(255, 162, 247, 139),
                  Color.fromARGB(255, 197, 243, 167)
                ]),
          ),
          // height: 400,
          width: 800,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start
            ,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(255, 115, 233, 30),
                height: 50,
                child: Center(
                  child: Text("Bus Timing ",style: TextStyle(fontSize: 25,
                  
                   fontFamily: "ButtonMelian",color: Color.fromARGB(255, 72, 4, 219),
             ),),
                )),
             ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: Bus_List.length,
              itemBuilder: ((context, index) {
                return Card(
                  elevation: 20,
                  child:
                  index%2==0 ? 
                   Container(
                    child: ListTile(
                      leading: Icon(Icons.bus_alert_sharp,color: Colors.green,),
                      title: Text(Bus_List[index]["route"].toString()),
                      subtitle: Text(Bus_List[index]["Time"].toString()),
                    ),
                  ):  Container(
                    child: ListTile(
                      leading: Icon(Icons.bus_alert_sharp,color: Color.fromARGB(255, 199, 4, 4),),
                      title: Text(Bus_List[index]["route"].toString()),
                      subtitle: Text(Bus_List[index]["Time"].toString()),
                    ),
                  ),
                );   
              })
          )]),
        
            ),
        )
        );

  }
}