import 'package:emojis/emojis.dart';

class User{
  String username;
  String profileImageLink;
  User({required this.username, required this.profileImageLink});
}

class PostUserDatabase{
  List<User> users = [
    User(username: 'Michelle Jonas', profileImageLink: 'https://images.pexels.com/photos/2709388/pexels-photo-2709388.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
    User(username: 'Jacob', profileImageLink: 'https://images.pexels.com/photos/3222422/pexels-photo-3222422.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
  ];
  List<String> postImage = [
    'images/uploaded_image.jpeg',
    'images/uploaded_image_2.jpeg'
  ];
  List<String> postText = [
    'This Store nearby my apartment looks so nice, cool, and makes me feel so happy!',
    'A day at the Amusement Park ${Emojis.sparkles}',
  ];
  List<String> postHashtags = [
    '#aesthetics #analog #colors',
    '#amusementpark #sky',
  ];

  String getUsername(int index)
  {
    return users[index - 1].username;
  }
  String getProfileImageLink(int index)
  {
    return users[index - 1].profileImageLink;
  }
  String getPostText(int index)
  {
    return postText[index - 1];
  }
  String getPostHashtags(int index)
  {
    return postHashtags[index - 1];
  }
  String getPostImage(int index)
  {
    return postImage[index - 1];
  }
}


class CommentUserDatabase{

  List<User> users= [
    User(username: 'Mameer', profileImageLink: 'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
    User(username: 'Dito Rahardian', profileImageLink: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
  ];
  List<String> commentText = [
    'Wow I love the color way ${Emojis.smilingFaceWithHeartEyes}',
    'I didn\'t know where it is, please tell me ${Emojis.foldedHands}',
  ];
  List<String> commentTime = [
    '30m', '12m',
  ];
  String getUsername(int index)
  {
    return users[index - 1].username;
  }
  String getProfileImageLink(int index)
  {
    return users[index - 1].profileImageLink;
  }
  String getCommentText(int index)
  {
    return commentText[index - 1];
  }
  String getCommentTime(int index)
  {
    return commentTime[index - 1];
  }
}