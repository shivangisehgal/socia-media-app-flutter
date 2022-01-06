import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'users.dart';

bool likePressed = true;

PostUserDatabase _postUsersDatabase = PostUserDatabase();
CommentUserDatabase _commentUserDatabase = CommentUserDatabase();

class CommentPage extends StatelessWidget {

  int clickedPostNumber;
  CommentPage({required this.clickedPostNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomLeft,
            children: [
              CoverPost(postNumber: clickedPostNumber),
              Positioned(
                left: 30,
                bottom: -40,
                child: PostProfileImage(postNumber: clickedPostNumber),
              ),
            ],
          ),
          ProfileNameAndActions(postNumber: clickedPostNumber),
          SizedBox(
            height: defaultSizedBoxHeight,
          ),
          PostText(postNumber: clickedPostNumber),
          PostHashtags(postNumber: clickedPostNumber),
          SizedBox(
            height: defaultSizedBoxHeight - 5,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CommentCard(commentNumber: 1),
                  CommentCard(commentNumber: 2),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CommentBar(appUserImage: 'https://media-exp1.licdn.com/dms/image/C4D03AQEW20t7ky50dQ/profile-displayphoto-shrink_800_800/0/1639582631477?e=1646870400&v=beta&t=nbtBK5bF49TuFvToPAMXKWl5_KAALB53gEwzElXR_uI'),
    );
  }
}

class CoverPost extends StatelessWidget {
  int postNumber;
  CoverPost({required this.postNumber});

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        child: Image.asset(
          _postUsersDatabase.getPostImage(postNumber),
          height: deviceInfo.size.height * 0.5,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ProfileNameAndActions extends StatefulWidget {
  Color buttonColor = Colors.pinkAccent;

  int postNumber;
  ProfileNameAndActions({required this.postNumber});

  @override
  State<ProfileNameAndActions> createState() => _ProfileNameAndActionsState();
}
class _ProfileNameAndActionsState extends State<ProfileNameAndActions> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 120, right: 28, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              _postUsersDatabase.getUsername(widget.postNumber),
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (likePressed == true) {
                    widget.buttonColor = iconThemeColor;
                    likePressed = false;
                  }
                  else {
                    widget.buttonColor = Colors.pinkAccent;
                    likePressed = true;
                  }
                });
              },
              child: Icon(
                FontAwesomeIcons.solidHeart,
                color: widget.buttonColor,
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: Icon(
              FontAwesomeIcons.paperPlane,
              color: iconThemeColor,
            ),
          ),
        ],
      ),
    );
  }
}

class PostProfileImage extends StatelessWidget {
  int postNumber;
  PostProfileImage({required this.postNumber});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: commentpagePostAvatarRadius,
      foregroundImage:
      NetworkImage(_postUsersDatabase.getProfileImageLink(postNumber)),
      backgroundColor: Colors.transparent,
    );
  }
}


class PostText extends StatelessWidget {
  int postNumber;
  PostText({required this.postNumber});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Text(
        _postUsersDatabase.getPostText(postNumber),
        overflow: TextOverflow.fade,
        style: TextStyle(
          color: Colors.black,
          fontSize: bodyFontSize,
          height: defaultLineSpacing,
        ),
      ),
    );
  }
}

class PostHashtags extends StatelessWidget {
  int postNumber;
  PostHashtags({required this.postNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Text(
        _postUsersDatabase.getPostHashtags(postNumber),
        overflow: TextOverflow.fade,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: bodyFontSize,
          height: defaultLineSpacing + 1,
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  int commentNumber;
  CommentCard({required this.commentNumber});

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Card(
      elevation: 0,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          foregroundImage: NetworkImage(
              _commentUserDatabase.getProfileImageLink(commentNumber)),
          backgroundColor: Colors.transparent,
        ),
        title: Text(
          _commentUserDatabase.getUsername(commentNumber),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          _commentUserDatabase.getCommentText(commentNumber),
          style: TextStyle(
            color: commentThemeColor,
          ),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(bottom: defaultPadding * 0.6),
          child: Text(
            _commentUserDatabase.getCommentTime(commentNumber),
            style: TextStyle(
              color: commentThemeColor,
            ),
          ),
        ),
      ),
    );
  }
}

class CommentBar extends StatelessWidget {

  final String appUserImage;
  CommentBar({required this.appUserImage});

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Container(
      color: Colors.grey.shade100,
      height: deviceInfo.size.height * 0.12,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding/2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              foregroundImage: NetworkImage(appUserImage),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              width: 17,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: Colors.white,
                ),
                child: Text(
                  'Write Comment Here..',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: commentThemeColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}