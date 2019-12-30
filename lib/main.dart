import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';

void main() => runApp(home());

Widget home() {
  return CameraMain();
}



class CameraMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:ImageFilter()
    );
  }
}

class ImageFilter extends StatefulWidget {
  @override
  _ImageFilterState createState() => _ImageFilterState();
}

class _ImageFilterState extends State<ImageFilter> {
  imageLib.Image _image;
  String fileName;
  Filter _filter;
  List<Filter> filters = presetFiltersList;

  Future getImage() async{
    var imageFile= await ImagePicker.pickImage(source: ImageSource.gallery);
    fileName=basename(imageFile.path);
    var image=imageLib.decodeImage(imageFile.readAsBytesSync());
    setState(() {
      _image=image;
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Photo"),
      ),
      body: Container(
        alignment: Alignment(0.0,0.0),
        child: _image == null ? Text("No image selected") : PhotoFilterSelector(
          image: _image,
          filters: presetFiltersList,
          filename: fileName,
          loader: Center(child: CircularProgressIndicator(),),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}



