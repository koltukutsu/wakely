import 'package:flutter/material.dart';
import 'package:wakely/ui/theme/colors.dart';
import 'package:wakely/ui/widgets/atoms/custom_animated_button.dart';

class LandingCommonScreen extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback buttonFunction;
  final String imagePath;

  const LandingCommonScreen(
      {Key? key,
      required this.text,
      required this.imagePath,
      required this.buttonFunction,
      required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String middleText =
        """In order to be able to use Wakely, you are supposed to have a Premium Spotify account. So, you gotta sign in your Spotify Account my little fella!!!""";
    return Scaffold(
      backgroundColor: AppColors.mainBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Stack(
            children: const [
              Align(
                  alignment: Alignment(-1.05, 0),
                  child: Image(
                      image: AssetImage("assets/images/left_pholder.png"))),
              Center(child: Text("Wakely", style: TextStyle(fontSize: 64))),
              Align(
                  alignment: Alignment(1.05, 0),
                  child: Image(
                      image: AssetImage("assets/images/right_pholder.png"))),
            ],
          ),
          Image(image: AssetImage(imagePath)),
          Padding(padding: EdgeInsets.all(10), child: Text(text)),
          CustomButtonAnimated(label: buttonText, onPressed: buttonFunction)
        ],
      ),
    );
  }
}
