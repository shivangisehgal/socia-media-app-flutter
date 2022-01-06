import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';
import '../constants.dart';
import '../users.dart';
import 'comment_page.dart';

PostUserDatabase _usersDatabase = PostUserDatabase();

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              defaultPadding, defaultPadding, defaultPadding, 0),
          child: Column(
            children: <Widget>[
              AppHeader(
                  appUserName: '@shivangi',
                  appUserImage:
                  'https://media-exp1.licdn.com/dms/image/C4D03AQEW20t7ky50dQ/profile-displayphoto-shrink_800_800/0/1639582631477?e=1646870400&v=beta&t=nbtBK5bF49TuFvToPAMXKWl5_KAALB53gEwzElXR_uI'),
              SizedBox(
                height: defaultSizedBoxHeight,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      HomePostCard(postNumber: 1),
                      SizedBox(
                        height: defaultSizedBoxHeight,
                      ),
                      HomePostCard(postNumber: 2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppFooter(),
    );
  }
}

class AppHeader extends StatelessWidget {
  final String appUserName;
  final String appUserImage;
  AppHeader({required this.appUserName, required this.appUserImage});

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: (deviceInfo.size.width) * 0.4,
          height: 50.0,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            color: secondaryThemeColor,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: appUserAvatarRadius,
                    foregroundImage: NetworkImage(
                      appUserImage,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  Text(
                    appUserName,
                    style: TextStyle(
                      fontSize: bodyFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: smallIconSize,
                  ),
                ],
              ),
            ),
          ),
        ),
        Icon(
          Icons.notifications_none,
          size: iconSize,
        ),
      ],
    );
  }
}

class AppFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.only(bottom: defaultPadding / 3),
      width: double.infinity,
      color: secondaryThemeColor,
      height: deviceInfo.size.height * 0.12,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding / 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FooterIcon(
                iconName: Icons.home_rounded, colorName: primaryThemeColor),
            FooterIcon(iconName: Icons.search, colorName: iconThemeColor),
            GradientFloatingButton(),
            FooterIcon(
                iconName: Icons.mail_outline_outlined,
                colorName: iconThemeColor),
            FooterIcon(
                iconName: Icons.person_outline, colorName: iconThemeColor),
          ],
        ),
      ),
    );
  }
}

class FooterIcon extends StatelessWidget {
  final IconData iconName;
  Color colorName;
  FooterIcon({required this.iconName, required this.colorName});
  @override
  Widget build(BuildContext context) {
    return Icon(
      iconName,
      size: iconSize,
      color: colorName,
    );
  }
}

class GradientFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: primaryThemeColor.withOpacity(0.2),
            offset: Offset(0, 10),
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(90),
        gradient: LinearGradient(
          colors: [primaryThemeColor, primaryThemeColor, Color(0xFFC3E1F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        elevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        child: Icon(
          Icons.add_circle,
          size: iconSize,
        ),
      ),
    );
  }
}

class HomePostCard extends StatelessWidget {

  int postNumber;
  HomePostCard({required this.postNumber});

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CommentPage(clickedPostNumber: postNumber)),
        );
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: deviceInfo.size.width * 1.2,
          width: deviceInfo.size.width,
          child: Stack(
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                    ],
                  ).createShader(
                      Rect.fromLTRB(0, 200, rect.width, rect.height - 1));
                },
                blendMode: BlendMode.darken,
                child: Container(
                  height: deviceInfo.size.width * 1.2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          _usersDatabase.getPostImage(postNumber)),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 15,
                top: (deviceInfo.size.width * 1.2) * 0.15,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Colors.white.withOpacity(0.2),
                      height: deviceInfo.size.width * 0.6,
                      width: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SideFeatureButton(
                              iconChild: FontAwesomeIcons.solidHeart),
                          Text(
                            '735',
                          ),
                          SideFeatureButton(
                              iconChild: FontAwesomeIcons.solidCommentDots),
                          Text('63'),
                          SideFeatureButton(
                              iconChild: FontAwesomeIcons.solidPaperPlane),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: homepagePostAvatarRadius,
                          foregroundImage: NetworkImage(
                            _usersDatabase
                                .getProfileImageLink(postNumber),
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          _usersDatabase.getUsername(postNumber),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: bodyFontSize + 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      _usersDatabase.getPostText(postNumber),
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: bodyFontSize,
                        height: defaultLineSpacing,
                      ),
                    ),
                    Text(
                      _usersDatabase.getPostHashtags(postNumber),
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: bodyFontSize,
                        height: defaultLineSpacing + 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SideFeatureButton extends StatelessWidget {

  final IconData iconChild;

  SideFeatureButton({required this.iconChild});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){},
      shape: CircleBorder(),
      padding: EdgeInsets.all(defaultPadding / 3),
      color: Colors.white.withOpacity(0.4),
      elevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      child: Icon(
        iconChild,
        color: iconChild == FontAwesomeIcons.solidHeart ? Colors.pinkAccent : Colors.white,
        size: smallIconSize,
      ),
    );
  }
}
