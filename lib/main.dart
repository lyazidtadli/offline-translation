import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  final c = TextEditingController();
  String r = "";
  bool en = true;
  Map<String,String> d = {"hello":"bonjour","thank you":"merci","yes":"oui","no":"non","water":"eau","food":"nourriture","house":"maison","friend":"ami","love":"amour","book":"livre","time":"temps","day":"jour","night":"nuit"};
  late Map<String,String> rev;
  @override
  void initState(){ super.initState(); rev = d.map((k,v)=>MapEntry(v,k)); }
  void tr(){ String i=c.text.trim().toLowerCase(); if(i.isEmpty)return; setState((){ r=en? (d[i]??"Not found offline") : (rev[i]??"Non trouvé"); }); }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Offline EN-FR"), centerTitle: true),
      body: Padding(padding: EdgeInsets.all(20), child: Column(children:[
        Row(mainAxisAlignment: MainAxisAlignment.center, children:[Text(en?"EN":"FR"), Switch(value: en, onChanged: (v)=>setState(()=>en=v)), Text(en?"FR":"EN")]),
        TextField(controller: c, decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Enter word")),
        SizedBox(height:15),
        ElevatedButton(onPressed: tr, child: Text("Translate Offline"), style: ElevatedButton.styleFrom(min
