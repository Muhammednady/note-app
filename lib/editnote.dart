import 'package:flutter/material.dart';
import 'package:noteappdb/sql.dart';

class EditNote extends StatefulWidget {
   
   String note;
   String title;   
   int id;

   EditNote({required this.note,required this.title,required this.id});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  SQL sql  = SQL();
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title.text = widget.title;
    note.text = widget.note;
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit note"),),
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
              int result = await  sql.updateData('''
                   UPDATE notes SET
                    note = "${note.text}" ,
                    title = "${title.text}" 
                     WHERE id = ${widget.id} 
                                     
                   ''');
                   if(result > 0){
                    Navigator.of(context).pushReplacementNamed("home");
                   }

              }, child:Text("Edit Note")),
            )
          ],
        ),
      ),
    );
  }
}
