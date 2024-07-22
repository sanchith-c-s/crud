import 'package:crud/contact.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController nameController=TextEditingController();
  TextEditingController numController=TextEditingController();

  List<Contact> contacts=List.empty(growable: true);
  
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contacts List'),
      ),
      body:  Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Contact name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                )
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: numController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                hintText: 'Contact no',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                )
              ),
            ),
           SizedBox(
              height: 10,
            ), 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () {
                  String name = nameController.text.trim();
                  String num= numController.text.trim();

                  if(name.isNotEmpty && num.isNotEmpty){
                    setState(() {
                      nameController.text='';
                      numController.text='';
                      contacts.add(Contact(name: name, num: num));
                    });
                  }
                }, 
                
                child: Text("Save",style: TextStyle(
                  color: Colors.red
                ),),),
                
                ElevatedButton(onPressed: (){
                  String name = nameController.text.trim();
                  String num= numController.text.trim();
                   if(name.isNotEmpty && num.isNotEmpty){
                    setState(() {
                      nameController.text='';
                      numController.text='';
                      contacts[selectedIndex].name=name;
                      contacts[selectedIndex].num=num;
                      selectedIndex = -1;
                    });
                  }
                },
                
                child: Text('Update',style: TextStyle(color: Colors.red),))
              ],
            ),
            contacts.isEmpty ? Text('Empty',style: TextStyle(
              fontSize: 20
            ),):
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length ,
                itemBuilder: (context,index)=>getRow(index)),
            )
          ],
        ),
      ),
    );
  }
  Widget getRow(int index){
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(contacts[index].name[0]),
        ),
        title:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contacts[index].name),
            Text(contacts[index].num)
          ],
        ),
        trailing:SizedBox(
          width: 70,
          child: 
            Row(
              children: [
                InkWell(
                  onTap: ((){
                    nameController.text=contacts[index].name;
                    numController.text=contacts[index].num;
                    setState(() {
                      selectedIndex=index;
                    });
                  }),
                  child: Icon(Icons.edit)),
                InkWell(
                  onTap: ((){
                    setState(() {
                      contacts.removeAt(index);
                    });
                  }),
                  child: Icon(Icons.delete))
              ],
            ),
          
        ),
      ),
    );
  }
}