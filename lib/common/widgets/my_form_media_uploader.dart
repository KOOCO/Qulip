import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qulip/common/widgets/my_text.dart';

class MyFormMediaUploader extends StatelessWidget {
  MyFormMediaUploader({Key? key}) : super(key: key);

  final double height = 40;
  final ImagePicker _picker = ImagePicker();
  final RxList _imageFileList = [].obs;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final itemWidth = context.width / 3;
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: height,
                    width: 100,
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        onImagePressed();
                      },
                      child: const MyText('Choose Files'),
                    ),
                  ),
                  SizedBox(
                    height: height,
                    child: const VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Obx(
                    () => MyText(
                      '${_imageFileList.isNotEmpty ? _imageFileList.length : 'No'} File${_imageFileList.length > 1 ? 's' : ''}',
                    ).paddingOnly(left: 10),
                  ),
                ],
              ),
            ),
            Obx(
              () => (_imageFileList.isNotEmpty)
                  ? GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: itemWidth,
                      ),
                      itemCount: _imageFileList.length,
                      itemBuilder: (context, index) {
                        final filePath = (_imageFileList[index] as XFile).path;
                        return Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              width: itemWidth,
                              height: itemWidth,
                              margin: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black87,
                                ),
                              ),
                              child: Image.asset(
                                filePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _imageFileList.removeAt(index);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 22,
                              ),
                            )
                          ],
                        );
                      },
                    ).paddingOnly(top: 1)
                  : Container(),
            ),
          ],
        );
      },
    );
  }

  Future<void> onImagePressed() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();
      _imageFileList.addAll(pickedFiles);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
