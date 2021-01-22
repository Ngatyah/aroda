import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ParcelForm extends StatefulWidget {
  @override
  _ParcelFormState createState() => _ParcelFormState();
}

class _ParcelFormState extends State<ParcelForm> {
  FirebaseUser user;
  String shopName ='';
  String shopPhone ='';
  String shopLocation='';

  @override
  void initState() {
    getUserData();
    getData();
    // TODO: implement initState
    super.initState();
  }

  getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
    });
  }

  final _formKey = GlobalKey<FormState>();
  bool _isSent = false;
  bool _isLoading = false;
  String customerName;
  String address;
  String customerPhone;
  String parcelName;
  int status;
  DateTime dateTime;
  String selectedWeight = '';
  String town = '';
  String routes = '';



  getData() async{
    await FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance.collection('users').where(
          'userId', isEqualTo: user.uid)
          .getDocuments().then((docs) {
        if (docs.documents[0].exists) {
            shopPhone = docs.documents[0].data['userPhone'];
            shopName = docs.documents[0].data['userName'];
            shopLocation = docs.documents[0].data['shopLocation'];
        }
      });
    });
  }




  Future<void> _sendParcel() async {
    final user = await FirebaseAuth.instance.currentUser();
    final _isValid = _formKey.currentState.validate();
    setState(() {
      _isLoading = true;
    });
    await FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance.collection('users').where('userId', isEqualTo: user.uid)
          .getDocuments().then((docs){
        if(docs.documents[0].exists){

            shopPhone = docs.documents[0].data['userPhone'];
            shopName = docs.documents[0].data['userName'];
            shopLocation = docs.documents[0].data['shopLocation'];

            print('I want to see this hello  $shopPhone');


        }
      });

    });

    if (_isValid) {
      _formKey.currentState.save();


      try {
        await Firestore.instance.collection('parcels').add({
          'userId': user.uid,
          'customerName': customerName,
          'customerPhone': customerPhone,
          'routes': routes,
          'parcelName': parcelName,
          'weight': selectedWeight,
          'status': 1,
          'time': DateTime.now(),
          'address': address,
          'town': town,
          'shopName': shopName,
          'shopLocation': shopLocation,
          'shopPhone': shopPhone


        });
        setState(() {
          _isSent = true;
        });
      } on PlatformException catch (e) {
        var message = 'An error occurred, Check your credentials';
        if(e.message != null ){
          message = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),);
      }catch(e){
        print(e);
      }
    }
    setState(() {

      _isLoading = false;
    });
  }

  townSelector(){
    if(routes== 'waiyakiWay'){
      return waiyakiWay;
    }
    else if(routes =='limuruRoad'){
      return limuruRoad;
    }
    else if(routes =='jogooRoad'){
      return jogooRoad;
    }
    else if(routes =='eastleigh'){
      return eastleigh;
    }
    else if(routes =='babaDogo'){
      return babaDogo;
    }
    else if(routes =='thikaRoad'){
      return thikaRoad;
    }
    else if(routes =='naivashaRoad'){
      return naivashaRoad;
    } else if(routes =='mombasaRoad'){
      return mombasaRoad;
    }
    else if(routes =='kiambuRoad'){
      return kiambuRoad;
    }
    else if(routes =='jujaRoad'){
      return jujaRoad;
    }
    else if(routes =='magadiRoad'){
      return magadiRoad;
    }
    else if(routes =='ngongRoad'){
      return ngongRoad;
    }
    else if(routes =='cbd'){
      return cbd;
    }
    else {
      return langata;
    }

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text('Customer Details',
                    style: TextStyle(fontSize: 24, color: Colors.blue)),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Receiver Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  onSaved: (value) {
                    customerName = value;
                  },
                  keyboardType: TextInputType.text,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Receiver Phone No';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  onSaved: (value) {
                    customerPhone = value;
                  },
                  keyboardType: TextInputType.phone,
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: DropDownFormField(
                    titleText: 'Route',
                    hintText: 'Select Route',
                    value: routes,
                    onSaved: (value) {
                      setState(() {
                        routes = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        routes = value;
                        town = '';

                      });
                    },
                    dataSource: route,
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: DropDownFormField(
                    titleText: 'Town',
                    hintText: 'Select Town Near Client',
                    value: town,
                    onSaved: (value) {
                      setState(() {
                        town = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                       town = value;
                       getData();
                      });
                    },
                    dataSource: townSelector(),
                    textField: 'display',
                    valueField: 'value',
                  ),
                ), 
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter client\'s Residence address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                  onSaved: (value) {
                    address = value;
                  },
                  keyboardType: TextInputType.text,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Item Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Parcel Name',
                  ),
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    parcelName = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: DropDownFormField(
                    titleText: 'Weight',
                    hintText: 'Please choose one',
                    value: selectedWeight,
                    onSaved: (value) {
                      setState(() {
                        selectedWeight = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        selectedWeight = value;

                      });
                    },
                    dataSource: weight,
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
                SizedBox(height: 10,),
                if (_isLoading) CircularProgressIndicator(),
                if (!_isLoading)
                  Visibility(
                    visible: !_isSent,
                    child: RaisedButton(
                      color: _isSent?Colors.green:Colors.grey[300] ,
                       child:Text ('OK', style: TextStyle(fontSize: 18),),
                      onPressed: _sendParcel,
                    ),
                  ),
                SizedBox(height: 20,),
                if(_isSent)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, size: 50,semanticLabel: 'Parcel Sent...',color: Colors.green,),
                    Text('Parcel Sent Successfully',style: TextStyle(color: Colors.green, fontSize: 18),)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



final List<Map> weight = [
  {
    "display": 'Below 0.5 kg',
    "value": 'Below 0.5 kg',
  },
  {
    "display": '1kg',
    "value": '1kg',
  },
  {
    "display": '2kg',
    "value": '2kg',
  },
  {
    "display": '3kg',
    "value": '3kg',
  },
  {
    "display": '4kg',
    "value": '4kg',
  },
  {
    "display": 'Above 5kg',
    "value": 'Above 5kg',
  }
];
final List<Map> cbd = [
  {
    "display": 'CBD/ Uhuru Park ',
    "value": 'CBD/ Uhuru Park',
  },
  {
    "display": 'Serena/ Kilimani ',
    "value": 'Serena/ Kilimani',
  },
  {
    "display": 'Community/ StateHouse',
    "value": 'Community/ StateHouse',
  },
  {
    "display": 'K.N.H/ UpperHill ',
    "value": 'K.N.H/ UpperHill ',
  },
  {
    "display": 'D.O.D/ Hurlinghum ',
    "value": 'D.O.D/ Hurlinghum',
  },
  {
    "display": 'Kileleshwa/ Lavington',
    "value": 'Kileleshwa/ Lavington',
  },
  {
    "display": 'Yaya Centre',
    "value": 'Yaya Centre',
  },

];
final List<Map> peponi = [
  {
    "display": 'Spring Valley/ Kitusuru',
    "value": 'Spring Valley/ Kitusuru',
  },
  {
    "display": ' Loresho',
    "value": 'Loresho',
  },
  {
    "display": ' Wangige/ Nyari',
    "value": 'Wangige/ Nyari',
  },
  {
    "display": 'UON Lower Kabete',
    "value": 'UON Lower Kabete',
  },

];
final List<Map> waiyakiWay = [
  {
    "display": 'Chiromo/ Riverside ',
    "value": 'Chiromo/ Riverside ',
  },
  {
    "display": ' Museum ',
    "value": ' Museum',
  },
  {
    "display": 'WestLands/ Safaricom',
    "value": 'WestLands/ Safaricom',
  },
  {
    "display": 'Deloitte/ Kangemi ',
    "value": 'Deloitte/ Kangemi',
  },
  {
    "display": 'Kinoo/Uthiru',
    "value": 'Kinoo/Uthiru',
  },
  {
    "display": 'Kinoo/Sigona',
    "value": 'Kinoo/Sigona',
  },
];
final List<Map> naivashaRoad = [
  {
    "display": 'Wanyee Road ',
    "value": 'Wanyee Road',
  },
  {
    "display": 'Satelite/ IRL ',
    "value": 'Satelite/ IRL',
  },
  {
    "display": 'Kawangware ',
    "value": 'Kawangware',
  },

  
];
final List<Map> jogooRoad = [
  {
    "display": 'Gikomba/ Kamukunji/ City Stadium ',
    "value": 'Gikomba/ Kamukunji/ City Stadium'
  },
  {
    "display": 'Madaraka/ Hamsa/ Rikana',
    "value": 'Madaraka/ Hamsa/ Rikana',
  },
  {
    "display": 'BuruBuru/ Dohnhom',
    "value": 'BuruBuru/ Dohnhom',
  },
  {
    "display": 'GreenSpan/ Umoja 1&2',
    "value": 'GreenSpan/ Umoja 1&2',
  },

  {
    "display": 'Kayole Junction/ Pipeline',
    "value": 'Kayole Junction/ Pipeline',
  },
  {
    "display": 'Komorock/ Mama Lucy',
    "value": 'Komorock/ Mama Lucy',
  },
  {
    "display": 'Fedha/ Nyayo/ Saika ',
    "value": 'Fedha/ Nyayo/ Saika',
  },
  {
    "display": 'Tasia/ Embakasi/ UTawala/Ruai  ',
    "value": 'Tasia/ Embakasi/ UTawala/Ruai',
  },
  {
    "display": 'Njiru/ Kamulu/ Joska/ Maraa',
    "value": 'Njiru/ Kamulu/ Joska/ Maraa',
  },
];
final List<Map> eastleigh = [
  {
    "display": 'Kariokor/ Pumwani',
    "value": 'Kariokor/ Pumwani',
  },
  {
    "display": ' Garage/ Garissa Lodge/ Section 3',
    "value": ' Garage/ Garissa Lodge/ Section 3',
  },
];
final List<Map> babaDogo = [
  {
    "display": 'Naivas/ Qwetu/ Ruaraka',
    "value": 'Naivas/ Qwetu/ Ruaraka',
  },
  {
    "display": ' Baba Dogo/ Lucky Summer',
    "value": 'Baba Dogo/ Lucky Summer',
  },
];
final List<Map> thikaRoad = [
  {
    "display": 'Ngara/ Pangani',
    "value": 'Ngara/ Pangani',
  },
  {
    "display": 'Garden Estate/ Roasters/ Gumba',
    "value": 'Garden Estate/ Roasters/ Gumba',
  },
  {
    "display": 'Muthaiga/ Survey/ Alsoaps',
    "value": 'Muthaiga/ Survey/ Alsoaps',
  },
  {
    "display": 'Safari Park/ TRM/ USIU',
    "value": 'Safari Park/ TRM/ USIU',
  },
  {
    "display": 'Roysambu/ Kasarani/ Mwiki',
    "value": 'Roysambu/ Kasarani/ Mwiki',
  },
  {
    "display": 'Githurai 45/ Wendani/ K.U/Kahawa.S ',
    "value": 'Githurai 45/ Wendani/ K.U/Kahawa.S',
  },
  {
    "display": 'Githurai 44/ Kahawa.W',
    "value": 'Githurai 44/ Kahawa.W',
  },
  {
    "display": 'Clay Works/ Ruiru/ Juja/ Thika ',
    "value": 'Clay Works/ Ruiru/ Juja/ Thika',
  },
];
final List<Map> limuruRoad = [
  {
    "display": 'Parklands / Gigiri/ Village Market',
    "value": 'Parklands / Gigiri/ Village Market',
  },
  {
    "display": 'UNEP / Runda/ Ruaka',
    "value": 'UNEP / Runda/ Ruaka',
  },
  {
    "display": 'Ndenderu/ Muchatha/ Banana/ Limuru',
    "value": 'Ndenderu/ Muchatha/ Banana/ Limuru',
  },

];
final List<Map> mombasaRoad = [
  {
    "display": 'Nyayo / Capital Centre/ Nai.West',
    "value": 'Nyayo / Capital Centre/ Nai.West',
  },
  {
    "display": 'Belle View/ South B/ Airtel/ South C',
    "value": 'Belle View/ South B/ Airtel/ South C',
  },
  {
    "display": 'Nextgen/ Standard Group/ Sameer ',
    "value": 'Nextgen/ Standard Group/ Sameer',
  },
  {
    "display": ' Syokimau/ Mlolongo ',
    "value": 'Syokimau/ Mlolongo',
  },
  {
    "display": 'G.M/ Imara Daima/ City Cabanas/ Transami',
    "value": 'G.M/ Imara Daima/ City Cabanas/ Transami',
  },
  {
    "display": 'JKIA Gate/ JKIA Inside/ GateWay Mall',
    "value": 'JKIA Gate/ JKIA Inside/ GateWay Mall',
  },{
    "display": 'Athi River/ Kitengela/ Green Park',
    "value": 'Athi River/ Kitengela/ Green Park',
  },
];
final List<Map> kiambuRoad = [
  {
    "display": 'C.I.D/ Muthaiga Estate',
    "value": 'C.I.D/ Muthaiga Estate',
  },
  {
    "display":  'Thindigua ',
    "value": 'Thindigua',
  },
  {
    "display":  'Kiambu Town',
    "value": 'Kiambu Town',
  },
];
final List<Map> jujaRoad = [
  {
    "display": 'Pangani/ Mlango/ Mathare ',
    "value": 'Pangani/ Mlango/ Mathare',
  },
  {
    "display": 'Huruma/ Raunda/ Kariobangi N&S ',
    "value": 'Huruma/ Raunda/ Kariobangi N&S',
  },
];
final List<Map> magadiRoad = [
  {
    "display": 'BrookHouse School',
    "value": 'BrookHouse School',
  },
  {
    "display": ' Rongai',
    "value": 'Rongai',
  },
  {
    "display": 'Kiserian',
    "value": 'Kiserian',
  },
];
final List<Map> ngongRoad = [
  {
    "display": 'Coptical Hospital/ China Centre',
    "value": 'Coptical Hospital/ China Centre',
  },
  {
    "display": ' Prestige/ Junction/ Jamhuri Estate',
    "value": ' Prestige/ Junction/ Jamhuri Estate',
  },

  {
    "display": 'Lenana School/ Dagoreti',
    "value": 'Lenana School/ Dagoreti',
  },
  {
    "display": ' Karen',
    "value": 'Karen',
  },
  {
    "display": 'BulBul/ Ngong Town/ Riruta',
    "value": 'BulBul/ Ngong Town/ Riruta',
  },
  
];
final List<Map> langata = [

  {
    "display": 'Madaraka/ HighRise/ Mbagathi/ W.AirPort',
    "value": 'Madaraka/ HighRise/ Mbagathi/ W.AirPort',
  },
  {
    "display": 'Carnivore/ Uhuru Garden/ deliverance ',
    "value": 'Carnivore/ Uhuru Garden/ deliverance',
  },
  {
    "display": 'L.A Hospital/ Otiende / St Mary ',
    "value": 'L.A Hospital/ Otiende / St Mary',
  },
  {
    "display": 'L.A Prisons/ Galleria/ Bomas',
    "value": 'L.A Prisons/ Galleria/ Bomas',
  },

];

final List<Map> route = [
  {
    "display": 'Waiyaki Way',
    "value": 'waiyakiWay',
  },
  {
    "display": 'CBD',
    "value": 'cbd',
  },
  {
    "display": 'Limuru Road ',
    "value": 'limuruRoad',
  },
  {
    "display": 'Jogoo Road ',
    "value": 'jogooRoad',
  },
  {
    "display": 'Eastleigh',
    "value": 'eastleigh',
  },
  {
    "display": 'Baba Dogo',
    "value": 'babaDogo',
  },{
    "display": 'Thika Road',
    "value": 'thikaRoad',
  },

  {
    "display": 'Naivasha Road',
    "value": 'naivashaRoad',
  },
  {
    "display": 'Mombasa Road',
    "value": 'mombasaRoad',
  },
  {
    "display": 'Kiambu Road',
    "value": 'kiambuRoad',
  },
  {
    "display": 'Juja Road',
    "value": 'jujaRoad',
  },
  {
    "display": 'Magadi Road',
    "value": 'magadiRoad',
  },
  {
    "display": 'Ngong Road',
    "value": 'ngongRoad',
  },{
    "display": 'Lang\'ata',
    "value": 'langata',
  },

];








