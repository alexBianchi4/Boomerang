
import 'package:app/screens/Favorite/Favorite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/dashboard/dashboard_page.dart';
import 'package:app/services/database.dart';
import 'package:app/services/auth.dart';
import 'package:provider/provider.dart';

class ViewListing extends StatefulWidget {
  String title;
  double price;
  String description;
  String tag;
  String url;
  String postId;
 ViewListing(this.title,this.price,this.description,this.tag,this.url,this.postId);
  @override
  _ViewListingState createState() => _ViewListingState();
}
class _ViewListingState extends State<ViewListing> {
  String currentIcon = "";
  Icon icon1 = Icon(Icons.favorite_border);
  int count = 0;
  
    @override
  void initState(){
	    // TODO: implement initState
      //  Future.delayed(Duration.zero,()async{
      //   await getAllData();
      // });
	    super.initState();
      print("in here");
      checkFavorite();


	    // getAllData.when;
   
	  }

  @override
	  Widget build(BuildContext context) {
	    return Scaffold(
        
	      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/EBay_logo.svg/1920px-EBay_logo.svg.png',
              width: 100,
            )
          ],
        ),
        actions: <Widget>[
            IconButton(
              icon: icon1,
              onPressed: ()async{
                if(currentIcon ==  "Icons.favorite") {
                    currentIcon =  "nothing";
                         
                  }
                else {
                    currentIcon =  "Icons.favorite";
                }

                if(currentIcon =="Icons.favorite"){
                      insertFavorite();
                  
                    
                  }

                else if(currentIcon !="Icons.favorite"){
                    await deleteFavorite();
                
                  
                }
                setState(() {
                  print("//////////////////////////////////////////////////////////////////");
                
                  
                  print(icon1);
                
                  
                  if(currentIcon ==  "Icons.favorite") {
                   
                    icon1 = Icon(Icons.favorite);      
                  }
                  else {
                    
                      icon1 = Icon(Icons.favorite_border);
                      
                  }
                  print("344444444444444444444444444444444444444444444444");
                 

                });
               
                // setState((){
                //  count+=1;
                // });
                print("sssssssssssssssss");
              },
              
            ),
            IconButton(
              icon: Icon(
                Icons.bar_chart,
                color: Colors.white,
              ),
              onPressed: () {           
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Favorites()));
              },
        )
      ],
        
      ),
	      body: ViewListContent(widget.title,widget.price,widget.description,widget.tag,widget.url),
	    );
	  }


    checkFavorite() async{
      AuthService authService = new AuthService();
      var favorites = await  DatabaseService().getFavorites();
      var key = authService.getID();   
      print(key);
      var listOfPostId = [];
      var snapshot;
  
      favorites.forEach((element)=>{
        if(element["ref"] == key){
          listOfPostId.add(element["postId"]),
          
         
        }
        
      });
      print("xxxxxxxxxxxxxxxxxxxxxxxxx");
      print(listOfPostId);
      for(int i=0;i<listOfPostId.length;i++){
        if(listOfPostId[i] == widget.postId){
          icon1 = Icon(Icons.favorite);
          currentIcon = "Icons.favorite";
        }
      }
      

      setState(() {
        
      });
      // snapshot = await FirebaseFirestore.instance.collection('listing').doc(listOfPostId[2]).get(); 
      // print(snapshot.data());
     }

     insertFavorite()async {
        AuthService authService = new AuthService();
        var key = authService.getID();   
        

        var favorites = await  DatabaseService().insertFavorite({"ref": key,"postId": widget.postId});
       
       
        
     }

     deleteFavorite()async{
        AuthService authService = new AuthService();
        var key = authService.getID();  
        await  DatabaseService().deleteFavorite({"ref": key,"postId": widget.postId});
        print("2222222222222222222222222222222222222222222222");
       
     }

    
}

class ViewListContent extends StatefulWidget {
  String title;
  double price;
  String description;
  String tag;
  String url;
  ViewListContent(this.title,this.price,this.description,this.tag,this.url);
  

  @override
  _ViewListContentState createState() => _ViewListContentState();
}

class _ViewListContentState extends State<ViewListContent> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
     
        Container(
          width: 130,
          height: 250,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                // Radius.circular(20)),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                // topRight: Radius.circular(20),
                // bottomRight: Radius.circular(20)
              ),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      NetworkImage(widget.url))) ,
          
          
        ),
      
    
      
        
        
      Column(
        mainAxisAlignment:MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.fromLTRB(30,10,0,0),
           
          child:Text(widget.tag, style: TextStyle(
            color: Colors.grey,) 
          ),),

        Padding(padding: EdgeInsets.fromLTRB(30,10,0,0),
          child:Text(widget.title,style: TextStyle(
            fontSize: 20,
  	          fontWeight: FontWeight.bold
          ),)),

        Padding(padding: EdgeInsets.fromLTRB(30,10,0,0),
          child:Text("Markham, On - 22km",style:TextStyle(color: Colors.blue))),
        
        Padding(padding: EdgeInsets.fromLTRB(30,10,0,0),
          child:Text((widget.price.toString()),style:TextStyle(
            fontSize: 25,
  	        fontWeight: FontWeight.bold))),

        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueAccent,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.blue
          ),
          padding: EdgeInsets.fromLTRB(20,0,0,0),
          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text("nitendorone12",style:TextStyle(color: Colors.white),textAlign: TextAlign.center)],
          )
        ),

        Padding(padding: EdgeInsets.fromLTRB(30,10,0,0),
          child:Text("Description",style:TextStyle(
            fontSize: 20,
  	        fontWeight: FontWeight.bold))),

        Padding(padding: EdgeInsets.fromLTRB(30,10,0,0),
          child:
            Text(
              widget.description,style:TextStyle(
              fontSize: 15,
  	        ))

        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
          // constraints: BoxConstraints(minWidth: 40),
              padding: EdgeInsets.fromLTRB(0,0,0,0),
              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
              width: 180,
              height: 30,
          
              child: Row( 
                mainAxisAlignment:MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Contact Information",style:TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.bold))
                ],
              )
        ),

            ],
          
        ),
        
      
      
      ],)
      
    ],);
  }
}