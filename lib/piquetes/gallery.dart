import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Gallery extends StatefulWidget{
  List imagens;

  Gallery({Key? key, required this.imagens}) : super(key:key);

  @override
  _GalleryPageState createState() => _GalleryPageState();

}

class _GalleryPageState extends State<Gallery> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Color.fromARGB(255, 16, 40, 29),),
              body: Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 16, 40, 29)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                          "Imagens que serão utlizadas.",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,color:Colors.white
                        ),
                      ),
                      const SizedBox(height: 18.0,),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: StaggeredGridView.countBuilder(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                itemCount: widget.imagens.length,
                                itemBuilder: (context,index){
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.file(widget.imagens[index],fit: BoxFit.fill,),
                                    ),
                                  );
                                },
                                staggeredTileBuilder: (index) {
                                  return StaggeredTile.count(1, index.isEven ? 1 : 1);
                                }
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}