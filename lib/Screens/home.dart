import 'package:flutter/material.dart';
import 'package:anime_wallpaper/models/api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import '../models/wallpaper.dart';
import '../widgets/imgview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final ScrollController _scrollController =  ScrollController();

 bool enable = true;
 int currentPage = 1;
 int total= 20;
 bool isLoading = false;

 List<WallpaperModel> animeData = [];

  Future<List<WallpaperModel>> callAnime(int currentPage) async{
    HttpHelper helper = HttpHelper();
    List<WallpaperModel> anime = await helper.getpics();
    
    return anime;

  }
  

 @override
  void initState() {
    super.initState();
loadMoreData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // User has reached the end of the list, load more data
        if(currentPage != total){
          currentPage += 1;
          callAnime(currentPage);

        }
        if (!isLoading) {
          loadMoreData();
        }
      }
    });
    
  }

  Future<void> loadMoreData() async {
    setState(() {
      isLoading = true; // Set the loading flag to true
    });
    List<WallpaperModel> newAnimeData = await callAnime(currentPage);
    setState(() {
      animeData.addAll(newAnimeData);
      currentPage+=1; // Increment the current page
      isLoading = false; // Set the loading flag back to false
      
    });
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea (
          top: enable,
          bottom: enable,
        child :FutureBuilder(
        future: callAnime(currentPage),
  builder: (BuildContext context, AsyncSnapshot<List<WallpaperModel>> snapshot) {

    if(snapshot.connectionState == ConnectionState.waiting){

      return  Shimmer.fromColors(
          enabled: enable,

          baseColor: Colors.black54,
          highlightColor: Colors.black87,
          child: MasonryGridView.count(
            controller: _scrollController ,
            crossAxisCount: 4,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            itemCount: 100,
              
              itemBuilder: (context, index ) {return Card(
            );
                 }
            ,),
      );

    }
    else if(snapshot.connectionState == ConnectionState.done){

      if(snapshot.hasError) {
        return const Center(child:
        Text('Server is down.',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),),

        );
      }
      else{
        return MasonryGridView.count(
          controller: _scrollController,
            crossAxisCount: 4,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
          
       itemBuilder: (BuildContext context, int index) {
  if (index >= 0 && index < snapshot.data!.length) {
    // The index is within the valid range of indices
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageView(
                imgUrl: snapshot.data![index].file,
              ),
            ),
          );
        },
        child: CachedNetworkImage(
          imageUrl: snapshot.data![index].file,
          fit: BoxFit.fill,
        ),
      ),
    );
  } else {
    // Handle the case where the index is out of bounds
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      // Load more data
      loadMoreData();
      return const Center(
        child: Text('Loading more data...'),
      );
    }
  }
},

          itemCount:  isLoading ? animeData.length + 1 : animeData.length

        );}

    }

    else{
      return const Center(child: Text('No Internet Connection',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,),),);
    }
        })));
        }
      }
