import 'package:filex/utils/operation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<MediaFile> selectedMedias = [];
  int pageIndex = 0;
  var controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    if (selectedMedias.isEmpty) {
      Future.delayed(Duration.zero, () async {
        await pickMedia();
      });
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Stack(children: [
                if (selectedMedias.isNotEmpty)
                  PageView(
                    controller: controller,
                    children: [
                      for (var media in selectedMedias)
                        Stack(alignment: Alignment.center, children: [
                          Center(
                            child: MediaProvider(
                              media: media,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                                onPressed: () {
                                  if (media.file != null) {
                                    openEditor(context, media.file!);
                                  }
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.teal.shade900,
                                  shadows: List.generate(
                                    10,
                                    (index) => Shadow(
                                      blurRadius: 2,
                                      color: Colors.teal.shade100,
                                    ),
                                  ),
                                )),
                          )
                        ])
                    ],
                  ),
                if (selectedMedias.isNotEmpty)
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        if (pageIndex < selectedMedias.length - 1) {
                          pageIndex++;
                          controller.animateToPage(pageIndex,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                          setState(() {});
                        }
                      },
                      icon: Icon(
                        Icons.chevron_right,
                        size: 100,
                        color: Colors.teal.shade900,
                        shadows: List.generate(
                          10,
                          (index) => Shadow(
                            blurRadius: 2,
                            color: Colors.teal.shade100,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (selectedMedias.isNotEmpty)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        onPressed: () {
                          if (pageIndex > 0) {
                            pageIndex--;
                            controller.animateToPage(pageIndex,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                            setState(() {});
                          }
                        },
                        icon: Icon(
                          Icons.chevron_left,
                          size: 100,
                          color: Colors.teal.shade900,
                          shadows: List.generate(
                            10,
                            (index) => Shadow(
                              blurRadius: 2,
                              color: Colors.teal.shade100,
                            ),
                          ),
                        )),
                  ),
                if (selectedMedias.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: pickMedia,
                          icon: Icon(
                            Icons.close_outlined,
                            color: Colors.teal.shade900,
                            shadows: List.generate(
                              5,
                              (index) => Shadow(
                                blurRadius: 2,
                                color: Colors.teal.shade100,
                              ),
                            ),
                          )),
                    ),
                  ),
                if (selectedMedias.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () async =>
                              await shareGalleryFile(selectedMedias),
                          icon: Icon(
                            Icons.share,
                            color: Colors.teal.shade900,
                            shadows: List.generate(
                              5,
                              (index) => Shadow(
                                blurRadius: 2,
                                color: Colors.teal.shade100,
                              ),
                            ),
                          )),
                    ),
                  )
              ]),
            ),
            SizedBox(
              height: 65,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (int i = 0; i < selectedMedias.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextButton(
                        onPressed: () {
                          pageIndex = i;
                          controller.animateToPage(pageIndex,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                          setState(() {});
                        },
                        child: Container(
                            width: 65,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: pageIndex == i
                                        ? Colors.red
                                        : Colors.black)),
                            child: ThumbnailMedia(
                              media: selectedMedias[i],
                            )),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickMedia() async {
    List<MediaFile>? media = await GalleryPicker.pickMedia(
        config: Config(
            mode: Theme.of(context).brightness == Brightness.dark
                ? Mode.dark
                : Mode.light),
        context: context,
        initSelectedMedia: selectedMedias,
        extraRecentMedia: selectedMedias,
        startWithRecent: true);
    if (media != null) {
      setState(() {
        selectedMedias += media;
      });
    }
  }
}
