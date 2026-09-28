import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
void main()=>runApp(MyApp());
class MyApp extends StatefulWidget{ @override State<MyApp> createState()=>_MyAppState(); }
class _MyAppState extends State<MyApp>{
final c=TextEditingController(); String r=""; String t="ar"; final FlutterTts tts=FlutterTts();
Map<String,Map<String,String>> d={
"hello":{"ar":"مرحبا","fr":"bonjour","es":"hola","de":"hallo","it":"ciao","en":"hello"},
"thanks":{"ar":"شكرا","fr":"merci","es":"gracias","de":"danke","it":"grazie","en":"thanks"},
"water":{"ar":"ماء","fr":"eau","es":"agua","de":"wasser","it":"acqua","en":"water"},
"food":{"ar":"طعام","fr":"nourriture","es":"comida","de":"essen","it":"cibo","en":"food"},
"friend":{"ar":"صديق","fr":"ami","es":"amigo","de":"freund","it":"amico","en":"friend"},
"house":{"ar":"منزل","fr":"maison","es":"casa","de":"haus","it":"casa","en":"house"},
"love":{"ar":"حب","fr":"amour","es":"amor","de":"liebe","it":"amore","en":"love"},
"book":{"ar":"كتاب","fr":"livre","es":"libro","de":"buch","it":"libro","en":"book"},
"sea":{"ar":"بحر","fr":"mer","es":"mar","de":"meer","it":"mare","en":"sea"},
"school":{"ar":"مدرسة","fr":"école","es":"escuela","de":"schule","it":"scuola","en":"school"},
};
Map<String,String> lc={"ar":"ar-SA","fr":"fr-FR","es":"es-ES","de":"de-DE","it":"it-IT","en":"en-US"};
void tr(){ String i=c.text.toLowerCase().trim(); if(d.containsKey(i)){setState(()=>r=d[i]![t]!);} else {setState(()=>r="جرب: hello, thanks, water...");} }
void speak() async { if(r.isNotEmpty){await tts.setLanguage(lc[t]!); await tts.setSpeechRate(0.5); await tts.speak(r);} }
@override Widget build(BuildContext context){
return MaterialApp(debugShowCheckedModeBanner:false,home:Scaffold(appBar:AppBar(title:Text("ترجم + صوت 🔊"),backgroundColor:Colors.teal),
body:Padding(padding:EdgeInsets.all(16),child:Column(children:[
TextField(controller:c,decoration:InputDecoration(labelText:"كتب EN",border:OutlineInputBorder())),
SizedBox(height:10),
Wrap(spacing:5,children:[
ChoiceChip(label:Text("AR"),selected:t=="ar",onSelected:(v)=>setState(()=>t="ar")),
ChoiceChip(label:Text("FR"),selected:t=="fr",onSelected:(v)=>setState(()=>t="fr")),
ChoiceChip(label:Text("ES"),selected:t=="es",onSelected:(v)=>setState(()=>t="es")),
ChoiceChip(label:Text("DE"),selected:t=="de",onSelected:(v)=>setState(()=>t="de")),
ChoiceChip(label:Text("IT"),selected:t=="it",onSelected:(v)=>setState(()=>t="it")),
]),
SizedBox(height:15),
ElevatedButton(onPressed:tr,child:Text("Translate"),style:ElevatedButton.styleFrom(minimumSize:Size(double.infinity,50),backgroundColor:Colors.teal)),
SizedBox(height:25),
if(r.isNotEmpty) Container(padding:EdgeInsets.all(20),decoration:BoxDecoration(color:Colors.teal.shade50,borderRadius:BorderRadius.circular(15)),
child:Row(children:[Expanded(child:Text(r,style:TextStyle(fontSize:32,fontWeight:FontWeight.bold))),IconButton(icon:Icon(Icons.volume_up,size:36,color:Colors.teal),onPressed:speak)])),
]))));
}}
