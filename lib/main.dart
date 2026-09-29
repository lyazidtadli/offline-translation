import 'package:flutter/material.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Translator 3 Languages',
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
  String _from = 'EN';
  String _to = 'FR';

  final Map<String, Map<String,String>> _dict = {
    'EN': {
      'hello':'bonjour','hi':'salut','goodbye':'au revoir','thank you':'merci',
      'please':'s\'il vous plait','yes':'oui','no':'non','water':'eau','food':'nourriture',
      'love':'amour','friend':'ami','house':'maison','cat':'chat','dog':'chien',
      'book':'livre','good':'bon','man':'homme','woman':'femme','i love you':'je t\'aime',
      'how are you':'comment ca va',
      // EN -> AR
      'EN_AR_hello':'مرحبا','EN_AR_hi':'مرحبا','EN_AR_goodbye':'وداعا','EN_AR_thank you':'شكرا',
      'EN_AR_water':'ماء','EN_AR_food':'طعام','EN_AR_love':'حب','EN_AR_friend':'صديق',
      'EN_AR_house':'منزل','EN_AR_cat':'قط','EN_AR_dog':'كلب','EN_AR_good':'جيد','EN_AR_i love you':'احبك',
    },
    'FR': {
      'bonjour':'hello','salut':'hi','au revoir':'goodbye','merci':'thank you',
      'eau':'water','amour':'love','ami':'friend','maison':'house','chat':'cat','chien':'dog',
      'FR_AR_bonjour':'مرحبا','FR_AR_merci':'شكرا','FR_AR_eau':'ماء','FR_AR_amour':'حب','FR_AR_ami':'صديق',
    },
    'AR': {
      'مرحبا':'hello','وداعا':'goodbye','شكرا':'thank you','ماء':'water','طعام':'food',
      'حب':'love','صديق':'friend','منزل':'house','قط':'cat','كلب':'dog','احبك':'i love you',
      'AR_FR_مرحبا':'bonjour','AR_FR_شكرا':'merci','AR_FR_ماء':'eau','AR_FR_حب':'amour',
    }
  };

  void _translate(){
    String input = _controller.text.toLowerCase().trim();
    if(input.isEmpty) return;
    String key = input;
    if(_from=='EN' && _to=='AR') key = 'EN_AR_$input';
    if(_from=='FR' && _to=='AR') key = 'FR_AR_$input';
    if(_from=='AR' && _to=='FR') key = 'AR_FR_$input';

    String out = _dict[_from]?[key]?? _dict[_from]?[input]?? '';
    if(out.isEmpty){
      // simple word by word
      out = input.split(' ').map((w){
        String k = _from=='EN'&&_to=='AR'? 'EN_AR_$w' : _from=='FR'&&_to=='AR'? 'FR_AR_$w' : _from=='AR'&&_to=='FR'? 'AR_FR_$w' : w;
        return _dict[_from]?[k]?? _dict[_from]?[w]?? w;
      }).join(' ');
    }
    if(out==input) out = _to=='AR'? 'جرب: مرحبا، شكرا، ماء' : 'Try: hello, thank you, water';
    setState(()=> _result = out);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('$_from -> $_to Offline'), centerTitle:true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children:[
          Row(children:[
            DropdownButton<String>(value: _from, items: ['EN','FR','AR'].map((e)=>DropdownMenuItem(value:e, child:Text(e))).toList(), onChanged:(v)=>setState(()=> _from=v!)),
            const Icon(Icons.arrow_forward),
            DropdownButton<String>(value: _to, items: ['EN','FR','AR'].where((e)=>e!=_from).map((e)=>DropdownMenuItem(value:e, child:Text(e))).toList(), onChanged:(v)=>setState(()=> _to=v!)),
            const Spacer(),
            IconButton(icon: const Icon(Icons.swap_horiz), onPressed: ()=>setState((){var tmp=_from; _from=_to; _to=tmp;}))
          ]),
          const SizedBox(height:16),
          TextField(controller: _controller, decoration: InputDecoration(labelText: 'Enter $_from', border: const OutlineInputBorder()), onSubmitted: (_)=>_translate()),
          const SizedBox(height:16),
          SizedBox(width: double.infinity, child: FilledButton(onPressed: _translate, child: const Text('Translate Offline'))),
          const SizedBox(height:20),
          Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)), child: Text(_result.isEmpty?'Translation here':_result, style: const TextStyle(fontSize:24, fontWeight:FontWeight.bold))),
          const Spacer(),
          const Text('EN - FR - AR | 100% Offline', style: TextStyle(color: Colors.grey))
        ]),
      ),
    );
  }
}
