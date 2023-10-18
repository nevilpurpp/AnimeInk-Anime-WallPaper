import 'package:flutter/material.dart';
import 'package:anime_wallpaper/models/api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import '../provider/get_data_provider.dart';
import '../utils/shimmer_layout.dart';
import '../utils/util.dart';
import '../widgets/imgview.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final ScrollController _scrollController =  ScrollController();
  

 bool isLoading = false;
 

@override
void initState() {
  super.initState();
  // Load initial data
  final dataProvider = Provider.of<GetDataProvider>(context, listen: false);
  dataProvider.fetchInitialData();
  _scrollController.addListener(() {
    if (!isLoading &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      // User has reached the end of the list, load more data
    dataProvider.fetchInitialData();
    }
  });
  
}




@override
  Widget build(BuildContext context) {
     final dataProvider = Provider.of<GetDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('DISCOVER',
         style:
          TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
        )),
      ),
      
      body: dataProvider.isLoading
      ?  MasonryGridView.count(
          controller: _scrollController ,
          crossAxisCount: 4,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          itemCount: 100,
            
            itemBuilder: (context, index ) {
              return loadingShimmer();
            }
      )
      : MasonryGridView.count(
        controller: _scrollController,
          crossAxisCount: 4,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
       itemCount:  isLoading ? dataProvider.animeData.length + 1 : dataProvider.animeData.length,
     itemBuilder: (BuildContext context, int index) {
    if (index >= 0 && index < dataProvider.animeData.length) {
    // The index is within the valid range of indices
    return Card(
      child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageView(
              imgUrl: dataProvider.animeData[index].file!,
            ),
          ),
        );
      },
      child: CachedNetworkImage(
        imageUrl: dataProvider.animeData[index].file!,
        fit: BoxFit.fill,
      ),
      ),
    );
    } else if (isLoading) {
    // Show a loading indicator while loading more data
    return const Center(
      child: CircularProgressIndicator(),
    );
    } else {
    // You've reached the end of available data
    return const Center(
      child: Text('No more data available'),
    );
    }
    },
      )
      );
      
      }
    
    }
    
   
        
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      /*
       FutureBuilder(
      future:dataProvider.fetchInitialData() ,
    builder: (BuildContext context, AsyncSnapshot<List<WallpaperModel>> dataProvider) {
    
    if(snapshot.connectionState == ConnectionState.waiting){
    
      return  Shimmer.fromColors(
        enabled: true,
    
        baseColor: Colors.black54,
        highlightColor: Colors.black87,
        child: MasonryGridView.count(
          controller: _scrollController ,
          crossAxisCount: 4,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          itemCount: 100,
            
            itemBuilder: (context, index ) {
              return Card(
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
       itemCount:  isLoading ? animeData.length + 1 : animeData.length,
     itemBuilder: (BuildContext context, int index) {
    if (index >= 0 && index < animeData.length) {
    // The index is within the valid range of indices
    return Card(
      child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageView(
              imgUrl: animeData[index].file!,
            ),
          ),
        );
      },
      child: CachedNetworkImage(
        imageUrl: animeData[index].file!,
        fit: BoxFit.fill,
      ),
      ),
    );
    } else if (isLoading) {
    // Show a loading indicator while loading more data
    return Center(
      child: CircularProgressIndicator(),
    );
    } else {
    // You've reached the end of available data
    return const Center(
      child: Text('No more data available'),
    );
    }
    },
      );}
    
    }
    
    else{
      return Utils.showError('No Internet Connection');
    }
      }));
        }
      }
      */

      