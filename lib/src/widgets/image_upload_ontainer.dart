import 'dart:io';
import 'package:flutter/material.dart';

class ImageUploadContainer extends StatelessWidget {
  final List<File> images;
  final VoidCallback onUploadTap;

  const ImageUploadContainer({
    super.key,
    required this.images,
    required this.onUploadTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUploadTap,
      child: Container(
        height: 120,
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (images.isNotEmpty)
              SizedBox(
                height: 70,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.file(
                        images[index],
                        width: 50,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            const Spacer(),
            const Center(child: Icon(Icons.cloud_upload)),
          ],
        ),
      ),
    );
  }
}
