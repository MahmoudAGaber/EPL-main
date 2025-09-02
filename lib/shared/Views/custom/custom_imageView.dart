

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/Constants.dart';

class CustomImageView extends StatefulWidget {
  List<dynamic> imagesUrl;
  CustomImageView({super.key,required this.imagesUrl});

  @override
  State<CustomImageView> createState() => _CustomImageViewState();
}

class _CustomImageViewState extends State<CustomImageView> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: PageView.builder(
        itemCount: widget.imagesUrl.length,
          itemBuilder: (context, index){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*.85,
                  child: Image.network(widget.imagesUrl[index].path,fit: BoxFit.cover,))]);
          },



      ),
    );
  }
}

class CustomChatImageView extends StatefulWidget {
  String imageUrl;
  CustomChatImageView({super.key,required this.imageUrl});

  @override
  State<CustomChatImageView> createState() => _CustomChatImageViewState();
}

class _CustomChatImageViewState extends State<CustomChatImageView> {
  @override
  Widget build(BuildContext context) {
    return  PageView(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.network(widget.imageUrl,fit: BoxFit.fitWidth,))
      ],

    );
  }
}



class CustomImage extends StatelessWidget {
  String imgUrl;
  double? height;
  double? width;
  CustomImage({super.key,required this.imgUrl, this.width, this.height});

  @override
  Widget build(BuildContext context) {
     try {
      return CachedNetworkImage(
        height: height ?? null ,
        width: width ?? null,
        imageUrl: imgUrl,
        fit: BoxFit.contain,
        placeholder: (context, url) => SizedBox(),
        errorWidget: (context, url, error) => CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.image_not_supported, color: Colors.white),
        ),
      );
    } catch (_) {
      return CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(Icons.image_not_supported, color: Colors.white),
      );
    }
    return CircleAvatar();

  }
}

