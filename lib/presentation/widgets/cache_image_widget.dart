import 'package:datacoup/export.dart';
import 'package:extended_image/extended_image.dart';

class CacheImageWidget extends StatelessWidget {
  final String? imageUrl;
  final int? i;
  final double? imgheight;
  final double? imgwidth;
  final Widget? errorWidget;
  final BoxFit? cFit;
  final bool? fromAsset;
  final Color? color;
  final BlendMode? colorBlendMode;

  const CacheImageWidget({
    Key? key,
    this.imageUrl,
    this.imgheight,
    this.imgwidth,
    this.colorBlendMode,
    this.color,
    this.errorWidget,
    this.fromAsset = false,
    this.cFit,
    this.i,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fromAsset!
        ? ExtendedImage.asset(
            imageUrl!,
            width: imgwidth ?? double.infinity,
            height: imgheight,
            fit: cFit ?? BoxFit.fill,
            color: color,
          )
        : ExtendedImage.network(
            imageUrl!,
            width: imgwidth ?? double.infinity,
            height: imgheight,
            fit: cFit ?? BoxFit.fill,
            cache: true,
            retries: 5,
            color: color,
            colorBlendMode: colorBlendMode,

            //cancelToken: cancellationToken,
          );
    //     // Image(
    //     //   image: NetworkImageWithRetry(
    //     //     imageUrl!,
    //     //   ),
    //     //   width: imgwidth ?? double.infinity,
    //     //   height: imgheight,
    //     //   fit: cFit ?? BoxFit.fill,
    //     // );
    //     CachedNetworkImage(
    //   key: Key(Uri.parse(imageUrl!).pathSegments.last),
    //   imageUrl: imageUrl!,
    //   //?? "https://source.unsplash.com/random?sig=$i",
    // width: imgwidth ?? double.infinity,
    // height: imgheight,
    // fit: cFit ?? BoxFit.fill,
    //   placeholder: (context, url) => const Center(
    //     child: CircularProgressIndicator(
    //       backgroundColor: Colors.black,
    //       color: Colors.white,
    //       strokeWidth: 1,
    //     ),
    //   ),
    //   errorWidget: (context, url, error) =>
    //       errorWidget ??
    //       // Image.network(
    //       //   imageUrl ?? "https://source.unsplash.com/random?sig=$i",
    //       //   width: imgwidth ?? double.infinity,
    //       //   height: imgheight,
    //       //   fit: cFit ?? BoxFit.fill,
    //       // ),
    //       const Center(child: Icon(Icons.error_outline_rounded)),
    // );
  }
}
