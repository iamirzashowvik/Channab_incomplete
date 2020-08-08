class AnimalModel{
  int id;
  String tag;
  String gender;
  String image;
  bool status;
  String type;
  String breed;

  AnimalModel({this.breed,this.gender,this.id,this.image,this.status,this.tag,this.type});

  AnimalModel.fromApi(Map<String,dynamic>data)
  :id=data['id'],
  tag=data['animal_tag'],
  gender=data['gender'],
  image=data['image'],
  status=data['status'],
  type=data['animal_type'],
  breed=data['animal_breed'];
}