class expense{
  
  int _state;
  int _cost;
  String _exp;
  int _id;
  expense(this._cost,this._exp,this._state);
 

  expense.map(dynamic obj){
   
    this._id=obj["id"];
    this._state=obj["state"];
    this._cost=obj["cost"];
    this._exp=obj["exp"];
    
  }

  
  int get id=>_id;
  int get cost=>_cost;
  int get state=>_state;
  String get exp=>_exp;
  

  Map<String,dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map["id"] = _id;
    }
 
    map["id"]  =_id;
    map["cost"]=_cost;
    map["state"]=_state;
    map["exp"]=_exp;
    

    return map;
  }

  expense.fromMap(Map<String,dynamic> map){
   
    this._id=map["id"];
    this._cost=map["cost"];
    this._state=map["state"];
    this._exp=map["exp"];
    

  }
}