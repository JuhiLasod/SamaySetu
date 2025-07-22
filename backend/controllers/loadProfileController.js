import Profiles from "../models/Profiles.js";

const loadProfileController=async(req,res)=>{
    try{
    const {email}=req.body;
    const exist=await Profiles.findOne({email});
    if(exist)
    {
        console.log("email exists");
        const user=await Profiles.findOne({email});
        const dpBase64 = user.dp?.data
        ? `data:${user.dp.contentType};base64,${user.dp.data.toString('base64')}`
        : null;
        return res.json({name: user.name,balance: user.balance, no: user.no, bio: user.bio, gender: user.gender,myServices: user.myskills, dp: dpBase64});

    }
    else{
        console.log("not exists");
        return res.json({name: null, no: null, bio: null, gender: null, dp: null});
    }
    return res.send();
}catch(e)
{
    return res.send("not okay");
}
}
export default loadProfileController;