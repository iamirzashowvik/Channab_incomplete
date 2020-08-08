class CategoriesModel{
  String name;
  int id;
  CategoriesModel({this.id,this.name});
  CategoriesModel.fromApi(Map<String,dynamic>data)
  :id=data['id'],
  name=data['name_of_category'];
}

class MaleModel{
  int id;
  String tag;
  MaleModel({this.tag,this.id});
  MaleModel.fromApi(Map<String,dynamic>data)
  :id=data['id'],
  tag=data['tag_number'];
}

class FemaleModel{
  int id;
  String tag;
  FemaleModel({this.tag,this.id});
  FemaleModel.fromApi(Map<String,dynamic>data)
  :id=data['id'],
  tag=data['tag_number'];
}