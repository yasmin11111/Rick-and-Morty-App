class CharactersModel {

late  int id;
late String name;
late  String status;
late String species;
late String type;
late String gender;
late  String image;
late List<String> episode;
late  String url;
late String created;
late String originName;
  CharactersModel(
      { required this.id,
     required   this.name,
      required  this.status,
        required  this.species,
        required  this.type,
        required   this.gender,
        required   this.image,
        required   this.episode,
        required  this.url,
        required this.originName,
        required this.created});

  CharactersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    image = json['image'];
    episode = json['episode'].cast<String>();
    url = json['url'];
    created = json['created'];
    originName=json['origin']?['name']??"";
  }

}
