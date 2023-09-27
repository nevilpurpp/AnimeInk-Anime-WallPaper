import 'package:flutter/material.dart';
import 'package:anime_wallpaper/models/api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../models/wallpaper.dart';
import '../widgets/imgview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  ScrollController _scrollController = new ScrollController();

 bool enable = true;
  Future<List<WallpaperModel>> callPizzas() async{
    HttpHelper helper = HttpHelper();
    List<WallpaperModel> pizzas = await helper.getpics();
    return pizzas;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {

      }
    });
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff121212),
      body: SafeArea (
          top: enable,
          bottom: enable,
        child :FutureBuilder(
        future: callPizzas(),
  builder: (BuildContext context, AsyncSnapshot<List<WallpaperModel>> snapshot) {

    if(snapshot.connectionState == ConnectionState.waiting){

      return  Shimmer.fromColors(
          enabled: enable,

          baseColor: Colors.black54,
          highlightColor: Colors.black87,
          child: GridView.builder(
            itemCount: 12,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.55,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemBuilder: (context, index ) {return GridTile(
                 child: Container( color: Colors.white38,));
                 }
            ,),
      );

    }
    else if(snapshot.connectionState == ConnectionState.done){

      if(snapshot.hasError) {
        return const Center(child:
        Text('Server is down.',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),

        );
      }
      else{
        return GridView.builder(
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.55,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
          ),
          itemBuilder: (BuildContext context, int index){
            return GridTile(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageView(
                              imgUrl:snapshot.data![index].arturl,
                            )
                        )
                    );
                  },

                  child: CachedNetworkImage(
                    imageUrl: snapshot.data![index].arturl,
                    fit: BoxFit.cover,
                    placeholder: (context , url) => const Center(child: CircularProgressIndicator()),
                    //progressIndicatorBuilder: CircularProgressIndicator(),
                  ),
                )
            );
          },
          itemCount:  (snapshot.data == null) ? 0 : snapshot.data!.length,

        );}

    }

    else{
      return const Center(child: Text('No Internet Connection',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.white),),);
    }
        })));
        }
      }
