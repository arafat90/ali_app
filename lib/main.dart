import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'pages/criar_conta.dart';
import 'pages/inserir_documento.dart';
import 'pages/login.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/criar_conta': (context) => const CriarContaPage(),
        '/principal': (context) => const PrincipalPage(),

        '/inserir': (context) => const InserirDocumentoPage(),

      },
    ),
  );
}

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({Key? key}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {

  //Referenciar a Coleção de Cafés
  late CollectionReference cafes;

  @override
  void initState(){
    super.initState();

    cafes = FirebaseFirestore.instance.collection('cafes');
  }

  //
  // Item Lista
  // Definir a aparência de cada item da lista
  //
  Widget itemLista(item){

    String nome = item.data()['nome'];
    String preco = item.data()['preco'];

    return ListTile(
      title: Text(nome, style: const TextStyle(fontSize: 30)),
      subtitle: Text('R\$ $preco', style: const TextStyle(fontSize: 25)),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: (){

          //
          // APAGAR UM DOCUMENTO DA COLEÇÃO
          //
          cafes.doc(item.id).delete();

        }
      ),
      onTap: (){
        Navigator.pushNamed(context, '/inserir', arguments: item.id);
      },
    );

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Café Store'),
        centerTitle: true,
        backgroundColor: Colors.brown,
        automaticallyImplyLeading: false,

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async{
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],

      ),
      
      //
      // EXIBIR OS DOCUMENTOS DA COLEÇÃO DE CAFÉS      
      //
      body: StreamBuilder<QuerySnapshot>(

        //fonte de dados (coleção)
        stream: cafes.snapshots(),

        //exibir os dados retornados
        builder: (context, snapshot){

          switch(snapshot.connectionState){

            case ConnectionState.none:
              return const Center(child:Text('Não foi possível conectar ao Firebase'));

            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());

            //dados recebidos
            default: 
              final dados = snapshot.requireData;
              return ListView.builder(
                itemCount: dados.size,
                itemBuilder: (context,index){
                  return itemLista(dados.docs[index]);
                }
              );

          }


        }

      ),


      backgroundColor: Colors.brown.shade100,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, '/inserir');
        },
      ),
    );
  }
}
