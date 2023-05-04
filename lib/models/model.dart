class ModelAR {
  late int id;
  late String url;
  late String name;
  late String detail;
  late double xScale;
  late double yScale;
  late double zScale;
  late double xPosition;
  late double yPosition;
  late double zPosition;

  ModelAR(
      this.id,
      this.url,
      this.name,
      this.detail,
      this.xScale,
      this.yScale,
      this.zScale,
      this.xPosition,
      this.yPosition,
      this.zPosition);

  ModelAR.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    name = json['name'];
    detail = json['detail'];
    xScale = json['x_scale'];
    yScale = json['y_scale'];
    zScale = json['z_scale'];
    xPosition = json['x_position'];
    yPosition = json['y_position'];
    zPosition = json['z_position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['x_scale'] = this.xScale;
    data['y_scale'] = this.yScale;
    data['z_scale'] = this.zScale;
    data['x_position'] = this.xPosition;
    data['y_position'] = this.yPosition;
    data['z_position'] = this.zPosition;
    return data;
  }
}