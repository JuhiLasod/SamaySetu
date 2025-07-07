import Profiles from "../models/Profiles.js";

const isProfileController=async(req,res)=>{
    try{
        console.log(req.body.email);
    const {email}=req.body;
    const exist=await Profiles.findOne({email});
    if(exist)
    {
        return res.send("true");
    }
    else
    {
        return res.send("false");
    }
    }
    catch(e)
    {
        res.sendStatus(500);
    }
}
export default isProfileController;