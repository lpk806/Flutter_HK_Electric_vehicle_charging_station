class EVStation{
  final String no,location,type,provider,parkingNo,districtL,districtS, lat,lng;

EVStation({this.districtL,this.districtS,this.lat,this.lng,this.location,this.no,this.parkingNo,this.provider,this.type});


factory EVStation.fromJson(Map<String, dynamic> parsedJson){
    return EVStation(
      districtL: parsedJson['districtL'],
      districtS : parsedJson['districtS'],
      lat : parsedJson['lat'],
      lng : parsedJson['lng'],
      location: parsedJson['location'],
      no : parsedJson['no'],
      parkingNo : parsedJson['parkingNo'],
      provider : parsedJson['provider'],
      type : parsedJson['type'],
    );
  }
}

class EVList {
  final List<EVStation> evStations;

  EVList({
    this.evStations,
  });

  factory EVList.fromJson(List<dynamic> parsedJson) {

    List<EVStation> evStations = new List<EVStation>();
    evStations = parsedJson.map((i)=>EVStation.fromJson(i)).toList();

    return new EVList(
      evStations: evStations
    );
  }
}
