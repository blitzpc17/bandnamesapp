import 'dart:io';
import 'package:flutter/material.dart';
import 'package:proto/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band>bands = [
    Band(id:'1', name:'Coldplay', votes:69),
    Band(id:'2', name:'U2', votes:60),
    Band(id:'3', name:'Temerindios', votes:120),
    Band(id:'4', name:'Bronco', votes:75),
    Band(id:'5', name:'Los acosta', votes:12),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Bandnames', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black38,   
        elevation: 1,     
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.add),
        elevation:1,
        onPressed:addNewBand
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
          key: Key(band.id),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction){
            print('direccion: $direction');
            print('id: ${band.id}');
          },
          background: Container(
            padding: EdgeInsets.only(left:8.8),
            color:Colors.red,
            child: Align(
              alignment: Alignment.centerLeft,
              child:Text('Eliminar banda...', style:TextStyle(color:Colors.white))
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              child:Text(band.name.substring(0,2)),
              backgroundColor: Colors.blue[100],
            ),
          title: Text(band.name),
          trailing: Text('${band.votes}', style: TextStyle(fontSize:20)),
          onTap: (){
            print(band.name);
          },
          ),
        );
  }

  addNewBand() {

    final textController = new TextEditingController();
    if(Platform.isAndroid){
      return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title:Text('New band name:'),
            content: TextField(
              controller: textController,
            ),
            actions:<Widget>[
              MaterialButton(
                child: Text('Add'),
                elevation: 1,
                textColor: Colors.blue,
                onPressed:()=>addBandToList(textController.text)
              )
            ]
          );
        }
      );
    }
    
  }

  void addBandToList(String text) {
    if(text.length>1){
      this.bands.add(new Band(id:DateTime.now().toString(), name:text));
      setState(() {
              
            });
    }

    Navigator.pop(context);
  }
}
