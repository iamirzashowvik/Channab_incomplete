class CurrentUser{
  String token;
  int userId;
  String userEmail;
  String phone;

  CurrentUser({this.phone,this.token,this.userEmail,this.userId});
  CurrentUser.fromApi(Map<String,dynamic>user)
  :userId=user['user_id'],
  token=user['token'],
  userEmail=user['user_email'],
  phone=user['phone'];

}