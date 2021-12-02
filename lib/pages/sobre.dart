import 'package:flutter/material.dart';

class WidgetCarro extends StatelessWidget {

  final String marca;
  final String modelo;
  final String foto;

  const WidgetCarro(this.marca,this.modelo,this.foto,{ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      //MARGENS (externo)
      //margin: EdgeInsets.all(50),
      //margin: EdgeInsets.only(top: 50),
      //margin: EdgeInsets.only(bottom: 50),
      margin: EdgeInsets.fromLTRB(30, 30, 30, 0),

      //ESPAÇAMENTO (interno)
      padding: EdgeInsets.all(20),

      width: MediaQuery.of(context).size.width,
     //height: 300,

      //DECORAÇÃO
      decoration: BoxDecoration(
        color: Colors.blue[700],

        //BORDAS
        border: Border.all(
          color: Colors.blue,
          width: 2,
        ),

        //BORDAS ARREDONDADAS
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),

      ),

      child: Column(
        children: [
          Text(this.marca, style: 
            TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.blue[100],
            ),
          ),
          Text(this.modelo, style:
            TextStyle(
              fontSize: 28,
              fontStyle: FontStyle.italic,
              color: Colors.blue[100],
            ),
          ),

          SizedBox(height: 10),

          //FOTO do CARRO
          Container(
            decoration: BoxDecoration(

              border: Border.all(
                color: Colors.blue,
                width: 1,     
              ),

              borderRadius: BorderRadius.all(
                Radius.circular(20),  
              ),
            ),
            //child: Image.asset(this.foto, scale: 2.5),

            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(20),  
              ),
              child: Image.asset(this.foto),
            ),

          ),

        ],
      )   
    );
  }
}