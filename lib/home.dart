import 'package:flutter/material.dart';
import 'package:noteappdb/editnote.dart';
import 'package:noteappdb/sql.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SQL sql_db = SQL();
  List<Map>? notes;

  readNotes() async {     
    notes = await sql_db.readData("SELECT * FROM 'notes' ");
  
   if(this.mounted){

     setState(() {});
   }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readNotes();
     print("==================initstate========================");
    print(notes);
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("addnote");
          }),
      appBar: AppBar(
        title: Text("YOUR NOTES"),
        actions: [
          IconButton(onPressed:(){
          sql_db.deleteData("DELETE FROM notes");          
          setState(() {
            notes  = [];
          });
         // Navigator.of(context).pushReplacementNamed("home");

        }, icon:Icon(Icons.delete_forever),iconSize: 40,color: Colors.red,)],

      ),
      body: (notes == null)
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
            shrinkWrap: true,
              itemCount: notes!.length,
              itemBuilder: (context, i) {
                return Card(
                  child: ListTile(
                    title: Text("${notes![i]['title']}"),
                    subtitle: Text("${notes![i]['note']}"),
                    trailing:Row(mainAxisSize: MainAxisSize.min,
                      children: [   
                         IconButton(
                        onPressed: () async {
                          int response = await sql_db.deleteData(
                              "DELETE FROM notes WHERE id = ${notes![i]['id']}");
                          if (response > 0) {
                           // notes!.removeWhere((element) => element['id'] == notes![i]['id']);

                           /* notes!.forEach((element) {
                              if(element['id'] == notes![i]['id']){
                                notes!.remove(element);
                                //There is a problem in note list to delete its members
                              }
                             });*/
                            // notes!.removeAt(i);
                             Navigator.of(context).pushReplacementNamed("home");
                          
                            setState(() {print("=====--=====setState================");});
                          } else {
                            print("ERROR");
                          }
                        },
                        icon: Icon(Icons.delete,color: Colors.red,size: 30,)),
                        IconButton(onPressed:(){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                            return EditNote(note: notes![i]['note'],title: notes![i]['title'],
                                            id: notes![i]['id'],);
                          },));
                
                        }, icon:Icon(Icons.edit,color: Colors.green,size: 30,)),
                
                    ],)
                
                  ),
                );
              },
            ),
    );
  }
}
