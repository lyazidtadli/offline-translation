import 'package:flutter/material.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Offline Translator',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const TranslatorPage(),
    );
  }
}

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});
  @override
  State<TranslatorPage> createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  final _controller = TextEditingController();
  String _result = '';
  bool _enToFr = true;

  final Map<String,String> _dict = {
    'hello':'bonjour','hi':'salut','goodbye':'au revoir','bye':'au revoir',
    'thank you':'merci','thanks':'merci','please':'s\'il vous plait','yes':'oui','no':'non',
    'water':'eau','food':'nourriture','bread':'pain','love':'amour','friend':'ami',
    'family':'famille','house':'maison','cat':'chat','dog':'chien','book':'livre',
    'time':'temps','day':'jour','night':'nuit','good':'bon','bad':'mauvais',
    'big':'grand','small':'petit','man':'homme','woman':'femme','child':'enfant',
    'school':'ecole','work':'travail','help':'aide','money':'argent','car':'voiture',
    'city':'ville','i love you':'je t\'aime','how are you':'comment ca va',
    'what is your name':'comment tu t\'appelles','my name is':'je m\'appelle',
  };

  void _translate(){
    String input = _controller.text.toLowerCase().trim();
    if(input.isEmpty) return;
    String out = _dict[input]?? '';
    if(out.isEmpty){
      out = input.split(' ').map((w) => _dict[w]?? w).join(' ');
      if(out == input) out = 'Try: hello, thank you, i love you';
    }
    if(!_enToFr){
      var rev = _dict.map((k,v) => MapEntry(v,k));
      out = rev[input]?? input.split(' ').map((w)=>rev[w]??w).join(' ');
    }
    setState(()=> _result = out);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(_enToFr?'EN -> FR Offline':'FR -> EN Offline'), centerTitle:true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children:[
          Row(children:[
            Chip(label: Text(_enToFr?'EN -> FR':'FR -> EN')),
            const Spacer(),
            IconButton(icon: const Icon(Icons.swap_horiz), onPressed: ()=>setState(()=> _enToFr=!_enToFr))
          ]),
          const SizedBox(height:20),
          TextField(controller: _controller, decoration: InputDecoration(labelText: _enToFr?'Enter English':'Entrez Francais', border: const OutlineInputBorder()), onSubmitted: (_)=>_translate()),
          const SizedBox(height:20),
          SizedBox(width: double.infinity, child: FilledButton(onPressed: _translate, child: const Text('Translate Offline'))),
          const SizedBox(height:30),
          Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)), child: Text(_result.isEmpty?'Translation will appear here':_result, style: const TextStyle(fontSize:22, fontWeight:FontWeight.bold))),
          const Spacer(),
          const Text('100% Offline - No Internet Needed', style: TextStyle(color: Colors.grey))
        ]),
      ),
    );
  }
}
