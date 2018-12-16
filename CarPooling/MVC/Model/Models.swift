//
//  Models.swift
//  GigQwik
//
//  Created by KrishMac on 9/14/17.
//  Copyright © 2017 KrishMac. All rights reserved.
//

import Foundation

class Abc {
    
    
}

func convertRating(_ rating:String) -> String {
    
    if rating == "" || rating == "0"{
        return "0"
    }
    
    let pi: Double = Double(rating)!
    let srt  = String(format:"%.1f", pi)
    
    return srt
}


class UserData {
    var user_fname : String!
    var user_lname : String!
    var user_id : String!
    var user_email : String!
    var user_role_id : String!
    init(fromJson parseData: JSON!){
        if parseData.isEmpty{
            return
        }
        
        user_fname = parseData!["user_fname"].stringValue
        user_lname = parseData!["user_lname"].stringValue
        
        user_id = parseData!["user_id"].stringValue
        user_email = parseData!["user_email"].stringValue
        
        user_role_id = parseData!["user_role_id"].stringValue
        
    }
    
}


class Clinic {
    var id : String!
    var name : String!
    var clinic_code : String!
    var address : String!
    var gps_coordinate : String!
    var contact : String!
    var about_clinic : String!
    var time_type : String!
    var time_value : String!
    var email : String!
    var website : String!
    init(fromJson parseData: JSON!){
        if parseData.isEmpty{
            return
        }
        
        id = parseData!["id"].stringValue
        name = parseData!["name"].stringValue
        
        clinic_code = parseData!["clinic_code"].stringValue
        address = parseData!["address"].stringValue
        
        gps_coordinate = parseData!["gps_coordinate"].stringValue
        contact = parseData!["contact"].stringValue
        about_clinic = parseData!["about_clinic"].stringValue
        time_type = parseData!["time_type"].stringValue
        time_value = parseData!["time_value"].stringValue
        email = parseData!["email"].stringValue
        website = parseData!["website"].stringValue
    }
    
}


class Dashboard {
    var id : String!
    var username : String!
    var email : String!
    var name : String!
    var total_doctors : String!
    var total_apoinements : String!
    var waiting_list_count : String!
    var clinics_count : String!
    var messages : String!
    init(fromJson parseData: JSON!){
        if parseData.isEmpty{
            return
        }
        
        id = parseData!["id"].stringValue
        name = parseData!["name"].stringValue
        
        email = parseData!["email"].stringValue
        username = parseData!["username"].stringValue
        
        total_doctors = parseData!["total_doctors"].stringValue
        total_apoinements = parseData!["total_apoinements"].stringValue
        waiting_list_count = parseData!["waiting_list_count"].stringValue
        messages = parseData!["messages"].stringValue
        clinics_count = parseData!["clinics_count"].stringValue
    }

}



class Patient {
    
    var id : String!
    var name : String!
    var device_type : String!
    var email : String!
    var username : String!
    var health_id : String!
    var phone_no : String!
    var address : String!
    var dob : String!
    var image : String!
    var image_path : String!
    var token : String!
    var gender: String!
    init(fromJson parseData: JSON!){
        if parseData.isEmpty{
            return
        }
        
        id = parseData!["id"].stringValue
        name = parseData!["name"].stringValue
        device_type = parseData!["device_type"].stringValue
        email = parseData!["email"].stringValue
        username = parseData!["username"].stringValue
        health_id = parseData!["health_id"].stringValue
        phone_no = parseData!["phone_no"].stringValue
        address = parseData!["address"].stringValue
        dob = parseData!["dob"].stringValue
        image = parseData!["image"].stringValue
        image_path = parseData!["image_path"].stringValue
        token = parseData!["token"].stringValue
        gender = parseData!["gender"].stringValue
    }
    
}





class Specific {
    
    var doctor_specialty_id : String!
    var speciality : String!
  
    var icon : String!
    
 
    init(fromJson parseData: JSON!){
        if parseData.isEmpty{
            return
        }
        
        doctor_specialty_id = parseData!["doctor_specialty_id"].stringValue
        speciality = parseData!["speciality"].stringValue
       
        icon = parseData!["icon"].stringValue
    }
    
}


class Doctor{
    
    var doctor_id : String!
    var clinic_id : String!
    var doctor_name : String!
    var specialization : String!
    init(fromJson parseData: JSON!){
        if parseData.isEmpty{
            return
        }
        
        
        doctor_id = parseData!["doctor_id"].stringValue
        clinic_id = parseData!["clinic_id"].stringValue
        doctor_name = parseData!["doctor_name"].stringValue
        specialization = parseData!["specialization"].stringValue
        
    }
    
    
}



class Appointment{
    
    var id : String!
    var clinic_id : String!
    var doctor_id : String!
    var staff_id : String!
    var patient_id : String!
    var booking_for_member : String!
    var booking_time : String!
    var created_at : String!
    var updated_at : String!
    var status: String!
    var booking_status: String!
    
    var deleted_at : String!
    var name : String!
    var members : String!
    var specialization: String!
    var booking_date: String!
    init(fromJson parseData: JSON!){
        if parseData.isEmpty{
            return
        }
        
        
        
        id = parseData!["id"].stringValue
        clinic_id = parseData!["clinic_id"].stringValue
        doctor_id = parseData!["doctor_id"].stringValue
        staff_id = parseData!["staff_id"].stringValue
        patient_id = parseData!["patient_id"].stringValue
        
        booking_for_member = parseData!["booking_for_member"].stringValue
        booking_time = parseData!["booking_time"].stringValue
        
        created_at = parseData!["created_at"].stringValue
        updated_at = parseData!["updated_at"].stringValue
        status = parseData!["status"].stringValue
        booking_status = parseData!["booking_status"].stringValue
        deleted_at = parseData!["deleted_at"].stringValue
        
        name = parseData!["name"].stringValue
        members = parseData!["members"].stringValue
        specialization = parseData!["specialization"].stringValue
        booking_date = parseData!["booking_date"].stringValue
        
    }
    
    
}


class NotificationData{
    
    var notification_text : String!
    var title : String!
    var add_date : String!
   
    init(fromJson parseData: JSON!){
        if parseData.isEmpty{
            return
        }
        
        
        
        notification_text = parseData!["notification_text"].stringValue
        title = parseData!["title"].stringValue
        add_date = parseData!["add_date"].stringValue
        
    }
    
    
}

class User{
    
    var user_id : String!
    var name : String!
    var email : String!
    var contact_number : String!
    var address : String!
    var latitude : String!
    var longitude : String!
    var token : String!
    var shipping_address : String!
    var profile_image: String!
    var password: String!
    init(fromJson parseData: JSON!){
        if parseData.isEmpty{
            return
        }
        
        let json = parseData["data"]
        
        user_id = json[ServiceKeys.user_id].stringValue
        token = json[ServiceKeys.keyToken].stringValue
        contact_number = json[ServiceKeys.keyContactNumber].stringValue
        address = json[ServiceKeys.address].stringValue
        email = json[ServiceKeys.keyEmail].stringValue
        
        name = json[ServiceKeys.name].stringValue
        profile_image = json[ServiceKeys.profile_image].stringValue
        
    }
    
    
}


class CarImages {
    
    var ID : String!
    var TYPE_ID : String!
    var ORDERKEY : String!
    var PICTURE : String!
    var MODIFYDATE : String!
    
    init(fromJson parseData: JSON!){
        if parseData.isEmpty{
            return
        }
        
        ID = parseData!["ID"].stringValue
        TYPE_ID = parseData!["TYPE_ID"].stringValue
        
        ORDERKEY = parseData!["ORDERKEYicon"].stringValue
        PICTURE = parseData!["PICTURE"].stringValue
        MODIFYDATE = parseData!["MODIFYDATE"].stringValue
    }
    
}

class CarList {
    var ID : String!
    var NAME : String!
    var MODEL_NAME : String!
    var MANUFACTURER_NAME : String!
    var PICTURE : String!
    
    var MODEL_ID : String!
    var PUBLISHDATE : String!
    var SOP : String!
    var EOP : String!
    var KAROSSERIE : String!
    var HUB : String!
    var PS : String!
    var KW : String!
    var KWL : String!
    
    var RADSTAND : String!
    var SPURWEITEV : String!
    var SPURWEITEH : String!
    var BODENFREIHEIT : String!
    var WENDEKREISDURCHMESSER : String!
    var HUBRAUM :String!
   var HOECHSTGESCHWINDIGKEIT :String!
    var LEERGEWICHT:String!
    var BENZINLI00KM_MAX:String!
    var PREIS:String!
    init(fromJson parseData: JSON!){
        if parseData.isEmpty{
            return
        }
        
        
        ID = parseData["ID"].stringValue
        NAME = parseData["NAME"].stringValue
        MODEL_NAME = parseData["MODEL_NAME"].stringValue
        MANUFACTURER_NAME = parseData["MANUFACTURER_NAME"].stringValue
        PICTURE = parseData["PICTURE"].stringValue
        
        MODEL_ID = parseData["MODEL_ID"].stringValue
        PUBLISHDATE = parseData["PUBLISHDATE"].stringValue
        SOP = parseData["SOP"].stringValue
        EOP = parseData["EOP"].stringValue
        KAROSSERIE = parseData["KAROSSERIE"].stringValue
        HUB = parseData["HUB"].stringValue
        PS = parseData["PS"].stringValue
        KW = parseData["KW"].stringValue
        KWL = parseData["KWL"].stringValue
        
        RADSTAND = parseData["RADSTAND"].stringValue
        SPURWEITEV = parseData["SPURWEITEV"].stringValue
        SPURWEITEH = parseData["SPURWEITEH"].stringValue
        BODENFREIHEIT = parseData["BODENFREIHEIT"].stringValue
        WENDEKREISDURCHMESSER = parseData["WENDEKREISDURCHMESSER"].stringValue
        HUBRAUM = parseData["HUBRAUM"].stringValue
        HOECHSTGESCHWINDIGKEIT = parseData["HOECHSTGESCHWINDIGKEIT"].stringValue
        LEERGEWICHT = parseData["LEERGEWICHT"].stringValue
        BENZINLI00KM_MAX = parseData["BENZINLI00KM_MAX"].stringValue
        PREIS = parseData["PREIS"].stringValue
    }
}



class AskMe {
    var TYPE_ID : String!
    var TYPE_NAME : String!
    var MODEL_ID : String!
    var MODEL_NAME : String!
    var FIRM_ID : String!
    
    var MANUFACTURER_NAME : String!
    var PICTURE : String!
    
    init(fromJson parseData: JSON!){
        if parseData.isEmpty{
            return
        }
        
        TYPE_ID = parseData!["TYPE_ID"].stringValue
        TYPE_NAME = parseData!["TYPE_NAME"].stringValue
        
        MODEL_ID = parseData!["MODEL_ID"].stringValue
        MODEL_NAME = parseData!["MODEL_NAME"].stringValue
        FIRM_ID = parseData!["FIRM_ID"].stringValue
        MANUFACTURER_NAME = parseData!["MANUFACTURER_NAME"].stringValue
        PICTURE = parseData!["PICTURE"].stringValue
    }
}
class BodyDesign {
    var ID : String!
    var title : String!
    
    init(fromJson parseData: JSON!){
        if parseData.isEmpty{
            return
        }
        
        ID = parseData!["ID"].stringValue
        title = parseData!["title"].stringValue
    }
}





