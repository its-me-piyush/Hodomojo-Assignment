class DataDefination {
  // The following mentioned as coverUrl in the api under data
  String headerImage;
  // The following mentioned as title in the api under data
  String headerTitle;
  // The following mentioned as url in the api under data/component and in
  // first map with type: 'image'
  String imageUrl;
  // The following mentioned as title in the api under data/component and in
  // second map with type: 'text'
  String textTitle;
  // The following mentioned as title in the api under data/component and in
  // second map with type: 'text'
  String textDescription;

  // Constructer for the fields

  DataDefination({
    this.headerImage = '',
    this.headerTitle = '',
    this.imageUrl = '',
    this.textTitle = '',
    this.textDescription = '',
  });
}
