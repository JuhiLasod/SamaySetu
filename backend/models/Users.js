import mongoose from "mongoose";

const userSchema= new mongoose.Schema({
    email: {type: String},
    pass: {type: String}
});
export default mongoose.model("Users",userSchema);