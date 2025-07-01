import Profiles from "../models/Profiles.js";

const isProfileController=async(req,res)=>{
    try{
    const {email}=req.body;
    const exist=await Profiles.findOne({email});
    if(exist)
    {
        res.send("true");
    }
    else
    {
        res.send("false");
    }
    }
    catch(e)
    {
        res.status(500);
    }
}
export default isProfileController;