import 'package:flutter/material.dart';
import 'package:neko_poster/views/_widgets.dart';
import 'package:image_picker/image_picker.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({Key? key}) : super(key: key);

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  final TextEditingController _postText = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? pickedImage;

  @override
  void dispose() {
    super.dispose();
    _postText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle(title: "Намурчать пост 🐈"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.cancel_sharp,
            size: 32,
          ),
          color: Colors.white70,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.blue.shade400,
              size: 32,
            ),
            onPressed: () {
              // TODO: Submit post with current date and postData
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
                child: TextField(
                  controller: _postText,
                  enableSuggestions: true,
                  autocorrect: true,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Сегодня я победил клубок...'),
                  style: const TextStyle(fontSize: 20),
                  showCursor: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
            ),
            bottomEditPanel()
          ],
        ),
      ),
    );
  }

  StatefulWidget bottomEditPanel() => Material(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.white12),
              ),
            ),
            child: SizedBox(
              height: 64,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () async {
                        pickedImage = await _picker.pickImage(
                          source: ImageSource.camera,
                        );
                      },
                      icon: const Icon(
                        Icons.camera_outlined,
                        color: Colors.white70,
                        size: 32,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        pickedImage = await _picker.pickImage(
                          source: ImageSource.gallery,
                        );
                      },
                      icon: const Icon(
                        Icons.image_outlined,
                        color: Colors.white70,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ));
}
