import Profiles from "../models/Profiles.js";

const loadProfileController=async(req,res)=>{
    try{
    const {email}=req.body;
    const exist=await Profiles.findOne({email});
    if(exist)
    {
        console.log("email exists");
        const user=await Profiles.findOne({email});
        return res.json({name: user.name, no: user.no, bio: user.bio, gender: user.gender,myServices: user.myskills});

    }
    else{
        console.log("not exists");
        return res.json({name: null, no: null, bio: null, gender: null});
    }
    return res.send();
}catch(e)
{
    return res.send("not okay");
}
}
export default loadProfileController;