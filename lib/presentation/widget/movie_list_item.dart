import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MovieListItem extends StatelessWidget {
  final VoidCallback onPressed;
  final Map<String, dynamic> item;
  final String imageBaseUrl;

  const MovieListItem({Key? key, required this.onPressed, required this.item, required this.imageBaseUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 5.0),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Row(
          children: [
            // CachedNetworkImage(imageUrl: state.imageBaseUrl!! + item['poster_path']),
            ExtendedImage.network(
              (imageBaseUrl ?? '') + 'original/' + (item['poster_path'] as String).substring(1),
              fit: BoxFit.cover,
              cache: true,
              borderRadius: BorderRadius.all(Radius.circular(6)),
              loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return SpinKitDoubleBounce(
                      color: Colors.black,
                      size: 16.0,
                    );
                  case LoadState.completed:
                    return ExtendedRawImage(
                      image: state.extendedImageInfo?.image,
                    );
                  case LoadState.failed:
                    return Container(
                      child: Center(
                        child: Icon(
                          Icons.error_rounded,
                          color: Colors.red,
                        ),
                      ),
                    );
                  default:
                    return SizedBox();
                }
              },
            ),
            SizedBox(width: 8.0),
            Text(item['title']),
          ],
        ),
      ),
    );
  }
}
