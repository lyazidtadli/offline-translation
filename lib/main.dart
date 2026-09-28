import 'package:flutter/material.dart';
void main()=>runApp(MyApp());
class MyApp extends StatefulWidget{
@override State<MyApp> createState()=>_MyAppState();
}
class _MyAppState extends State<MyApp>{
final c=TextEditingController();
String r="";
Map<String,Map<String,String>> d={
"hello":{"ar":"مرحبا","fr":"bonjour","es":"hola"},
"thanks":{"ar":"شكرا","fr":"merci","es":"gracias"},
"water":{"ar":"ماء","fr":"eau","es":"agua"},
};
String t="ar";
void tr(){
String i=c.text.toLowerCase().trim();
if(d.containsKey(i)){setState(()=>r=d[i]![t]!);}else{setState(()=>r="جرب: hello, thanks, water");}
}
@override Widget build(BuildContext context){
return MaterialApp(
home:Scaffold(
appBar:AppBar(title:Text("ترجم بلا أنترنت"),backgroundColor:Colors.teal),
body:Padding(
padding:EdgeInsets.all(20),
child:Column(children:[
TextField(controller:c,decoration:InputDecoration(labelText:"English word",border:OutlineInputBorder())),
SizedBox(height:10),
Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
ChoiceChip(label:Text("عربية"),selected:t=="ar",onSelected:(v){setState(()=>t="ar");}),
ChoiceChip(label:Text("فرنسية"),selected:t=="fr",onSelected:(v){setState(()=>t="fr");}),
ChoiceChip(label:Text("إسبانية"),selected:t=="es",onSelected:(v){setState(()=>t="es");}),
]),
SizedBox(height:20),
ElevatedButton(onPressed:tr,child:Text("Translate Offline"),style:ElevatedButton.styleFrom(minimumSize:Size(double.infinity,50))),
SizedBox(height:30),
Text(r,style:TextStyle(fontSize:28,fontWeight:FontWeight.bold)),
]),
),
),
);
}
}
