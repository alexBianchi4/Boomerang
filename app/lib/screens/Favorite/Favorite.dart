

import 'package:app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/ViewListing/ViewListing_page.dart';
import 'package:app/services/database.dart';



  var currnetFavorites= [];
  var allPosts = [];
  var currentPosts = [];
  var allUserPosts = [];

  var price = [];
  var description = [];
  var title = [];
  var tags = [];
  var Favoritekeys = [];
  var allData = [];
  var images = [];

  class Favorites extends StatefulWidget {
    const Favorites({ Key? key }) : super(key: key);

    @override
    _FavoritesState createState() => _FavoritesState();
  }

  class _FavoritesState extends State<Favorites> {

    @override
    void initState(){
        // TODO: implement initState
        //  Future.delayed(Duration.zero,()async{
        //   await getAllData();
        // });
        super.initState();
        getData();
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
        
          
        ),
        body: MyFavoritesPage()
        
        // Container(
        //   child: 
        //   ListView(
        //     children: [FavoritesList()]
          
        //   )
        // ) 
      );

      


    }

    getData() async{
      print("here");
      AuthService authService = new AuthService();
      var favorites = await  DatabaseService().getFavorites();
      var key = authService.getID();
      
      
        
        currnetFavorites.clear();
        currentPosts.clear();
        price.clear();
        title.clear();
        description.clear();
        tags.clear();
        allPosts.clear();
        images.clear();

        favorites.forEach((element)=>{
          print("xxxxxxxxxxxxxxx"),
          print(element["postId"]),
          if(allPosts.contains(element["postId"])){
            
          }
          else if(key == element["ref"]){
            currnetFavorites.add(element),
            allPosts.add(element["postId"])
          },
          
        });
        print(allPosts);
        print("+++++++++++++++++++++++++++");
       
        var snapshot1;
        var data;
        print("thissss");

        try { 
          for(int i=0;i<allPosts.length;i++){
            print("xsdfgfrerthgtrethgjhtrtyjk");
            print(allPosts[i]);
            snapshot1 = await FirebaseFirestore.instance.collection("listing").doc(allPosts[i]).get();
            data = snapshot1.data();
            print(data);
            price.add(data["price"]);
            title.add(data["title"]);
            description.add(data["description"]);
            tags.add(data["tag"]);
            images.add(data["url"]);
          }
        }
        catch(exception) { 
          print(exception);
          print("this is error");
        } 

        print("in this");

        // currentPosts[0].forEach((element) async =>{
        //   print(element),
        //   snapshot1 = await FirebaseFirestore.instance.collection("listing").doc(element).get(),
        //   data = snapshot1.data(),
        //   price.add(data["price"]),
        //   title.add(data["title"]),
        //   description.add(data["description"]),
        //   tags.add(data["tag"])
        // });

        setState(() {
          
        });
      }
    // getAllData() async {
    // // print("------------------------------------------------");
    //   AuthService authService = new AuthService();
    //   var favorites = await  DatabaseService("").getFavorites();
    //   var key = authService.getID();
    //   // print(key);
      
    //   // setState(() {
        
    //     currnetFavorites.clear();
    //     currentPosts.clear();
    //     price.clear();
    //     title.clear();
    //     description.clear();
    //     tags.clear();

        // favorites.forEach((element)=>{
        //   print(element["ref"]),
        //   if(key == element["ref"]){
        //     currnetFavorites.add(element),
        //     allPosts.add(element["postId"])
        //   },
        // });

    //     currentPosts.add(allPosts[0]);
    
    //     var snapshot1;
    //     var data;
    //     currentPosts[0].forEach((element) async =>{
    //       print(element),
    //       snapshot1 = await FirebaseFirestore.instance.collection("listing").doc(element).get(),
    //       data = snapshot1.data(),
    //       price.add(data["price"]),
    //       title.add(data["title"]),
    //       description.add(data["description"]),
    //       tags.add(data["tag"])
    //     });
      // });

      // setState(() {
        
      // });
        

      }




  //}

  class MyFavoritesPage extends StatefulWidget {
    const MyFavoritesPage({ Key? key }) : super(key: key);

    @override
    _MyFavoritesPageState createState() => _MyFavoritesPageState();
  }

  class _MyFavoritesPageState extends State<MyFavoritesPage> {
      
      void initState() {
        // TODO: implement initState
        super.initState();
        
      }
    List<Map<String,dynamic>> allListings = []; 
    final Listing = FirebaseFirestore.instance.collection('listing');
    final Favorites = FirebaseFirestore.instance.collection('Favorite');
    @override
    Widget build(BuildContext context) {
    return ListView.builder(
          itemCount: price.length,
          itemBuilder:(BuildContext context, int index){

      return Container(
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
                      NetworkImage(images[index]))),
        child:Row(
          children: [
            Column(
              children: [
                // Image.asset("assets/Console.PNG", height: 150,width: 150,)
                
              ]),

            Column(
              children: [
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[
                      Text(title[index].toString()),
                    
                      
                      
                    ]
                  ),
                  Text(tags[index].toString()),
                  Text(price[index].toString()),
                  Text(description[index].toString()),
                      
                


            
              ],
          )
      ]) ,
              
              
            );

          }
          
          
        );
        
    }
    
    

  } 
        
      
        
        

    // getSpeiefiedInformation() async{

      // var favorites = await  DatabaseService("").getFavorites();
      // print("-----------------------");
      // var snapshot;
      // for(int i=0;i<Favoritekeys[0].length;i++){
      //   print("wdfoenidpfsdoifgudfpgigvo");
        
        // print(snapshot.data());
        // allData.add(snapshot.data());
      //}
      // var snapshots = await FirebaseFirestore.instance.collection('listing').doc(Favoritekeys[0][0]).snapshots();
      // print(snapshots.data())


      
    
    // }
    

  // }



  // return ListView.builder(
      //     itemCount: price.length,
      //     itemBuilder:(BuildContext context, int index){

      //       return Container(
      //         child:Row(
      //   children: [
      //     Column(
      //       children: [
      //         // Image.asset("assets/Console.PNG", height: 150,width: 150,)
              
      //       ]),

      //     Column(
      //       children: [
            
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children:[
      //               Text(title[index].toString()),
                  
                    
                    
      //             ]
      //           ),
      //           Text(tags[index].toString()),
      //           Text(price[index].toString()),
      //           Text(description[index].toString()),
                    
              


          
      //   ],
      // )]) ,
              
              
      //       );

      //     }
          
          
      //   );




  // AuthService authService = new AuthService();
  //       var key = authService.getID();
  //       print("--------------------");
  //       print(key);
  // 	    var collection =  Favorites.where('ref', isEqualTo: key);

        
        
        
      
      // print(allPostId[0]);
    

    
        
      //   var allPosts = currentFavoriets['postId'];
      //   ignore: avoid_print
      //   print(currentFavoriets["ref"]);
      //   print("+++++++++++++++=");
      
      //   print(currentFavoriets.snapshots());
        
        
      //   currentFavoriets.forEach((element) {
      //     allPostId = element.docs.first.data()["postId"];
      //     Favoritekeys.add(element.docs.first.data()["postId"]);
          
          
      //   });

      
        // print("rtyunerg8d9rfiuj9go");
      
        // print(currentFavoriets);

        // print( Favoritekeys[0][0]);
        
        // return Favorites.snapshots();