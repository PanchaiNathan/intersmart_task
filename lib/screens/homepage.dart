import 'package:flutter/material.dart';
import 'package:Interview/models/imagemodel.dart';
import 'package:Interview/providers/get_images.dart';
import 'package:Interview/utils/search_bar.dart';
import 'package:Interview/widgets/photosgrid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final List<ImageModel> myImage = [];

  @override
  void initState() {
    super.initState();
    getAwesomeStart();

  }

  void getAwesomeStart() async {
    List<ImageModel> images = await image.getCollectionImages('2423569', 1, 20);
    setState(() {
      for (var image in images) {
        myImage.add(image);
      }
    });
  }



  final GetImages image = GetImages();
  ScrollController scrolls = ScrollController();

  @override
  void dispose() {
    scrolls.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          children: [
            const Text(
              "Inter",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Smart",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchBar());
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: PhotosView(
        images: myImage,
        scrollController: scrolls,
      ),
    );
  }
}
