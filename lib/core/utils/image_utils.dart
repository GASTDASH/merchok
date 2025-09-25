import 'package:flutter/foundation.dart';
import 'package:image/image.dart';

abstract class ImageUtils {
  static const int maxImageWidth = 400;
  static const int maxImageHeight = 400;
  static const int jpegQuality = 85;
  static const int thumbnailSize = 150;

  static Future<Uint8List> compressImage(Uint8List rawImage) async {
    final Uint8List compressedImage = await compute(
      (message) => _compressImageInIsolate(message),
      rawImage,
    );
    return compressedImage;
  }

  static Uint8List _compressImageInIsolate(Uint8List rawImage) {
    try {
      final image = decodeImage(rawImage);
      if (image == null) return rawImage;

      final double aspectRatio = image.width / image.height;
      int newWidth, newHeight;

      if (image.width > image.height) {
        newWidth = maxImageWidth;
        newHeight = (newWidth / aspectRatio).round();
      } else {
        newHeight = maxImageHeight;
        newWidth = (newHeight * aspectRatio).round();
      }

      Image resizedImage;
      // Если был изменён размер
      if (image.width > newWidth || image.height > newHeight) {
        resizedImage = copyResize(
          image,
          width: newWidth,
          height: newHeight,
          interpolation: Interpolation.cubic,
        );
      } else {
        resizedImage = image;
      }

      final compressedImage = encodeJpg(resizedImage, quality: jpegQuality);
      return compressedImage;
    } catch (e) {
      return rawImage;
    }
  }

  static Future<Uint8List> createThumbnail(Uint8List rawImage) async {
    final Uint8List thumbnail = await compute(
      (message) => _createThumbnailInIsolate(rawImage),
      rawImage,
    );
    return thumbnail;
  }

  static Uint8List _createThumbnailInIsolate(Uint8List rawImage) {
    try {
      final image = decodeImage(rawImage);
      if (image == null) return rawImage;

      final thumbnail = copyResizeCropSquare(image, size: thumbnailSize);
      final thumbnailImage = encodeJpg(thumbnail, quality: jpegQuality);

      return thumbnailImage;
    } catch (e) {
      return rawImage;
    }
  }
}
