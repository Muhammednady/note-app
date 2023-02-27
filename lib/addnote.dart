import 'package:flutter/material.dart';
import 'package:noteappdb/sql.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  SQL sql  = SQL();
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Note"),),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(child: Container(height: 200,width: 200,
              child: Image.asset("images/stickynote.jpg",fit: BoxFit.fill,)),),
            Form(
                child: Column(
              children: [
                TextFormField(
                    controller: title,
                    decoration: InputDecoration(hintText: "title")),
                TextFormField(
                    controller: note,
                    decoration: InputDecoration(hintText: "note")),
                
              ],
            )),
            SizedBox(height: 30,),
            Center(
              child: ElevatedButton(onPressed:()async{
              int response = await sql.writeData('''
                    INSERT INTO 'notes' ('note','title')  VALUES 
                                      ('${note.text}','${title.text}')
         ''');
             
             if(response > 0){
              Navigator.of(context).pushReplacementNamed("home");
             }

              }, child:Text("add Note")),
            )
          ],
        ),
      ),
    );
  }
}
