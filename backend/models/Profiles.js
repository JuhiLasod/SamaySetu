import mongoose from "mongoose";
const ProfilesSchema=new mongoose.Schema({
    email:{type:String},
    name: {type:String},
    no: {type:String},
    gender: {type: String},
    bio: {type: String},
    balance: {type: Number},
    myskills: {type: [String]},
    servicesUsed: {type: [String]},
    history: [ {service: String , amount: Number} ],
    dp: { data: Buffer , contentType: String}
});
export default mongoose.model("Profiles", ProfilesSchema);