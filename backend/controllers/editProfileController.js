import Profiles from "../models/Profiles.js";
const editProfileController=async(req,res)=>{
    try{
    // console.log('yay');
    const {email,_profileImage,name,_selectedGender,bio,no}=req.body;
    const myServices = JSON.parse(req.body.myServices);

    const exist= await Profiles.findOne({email});
    if(exist)
    {
        exist.name=name;
        exist.no=no;
        exist.bio=bio;
        exist.gender=_selectedGender;
        exist.myskills=myServices;
        await exist.save();
        return res.sendStatus(200);
    }
    const done= await new Profiles({
        email,
        name,
        no,
        gender: _selectedGender, 
        bio,
        balance:0,
        myskills:myServices,
        history: [], 
        dp: req.file?
            {
                data: req.file.buffer,
                contentType: req.file.mimeType
            }:undefined
        });
    await done.save();
    return res.sendStatus(200);
    
    }
    catch(e)
    {
        return res.sendStatus(500);
    }
}
export default editProfileController;