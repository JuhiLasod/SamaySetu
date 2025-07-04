import Profiles from "../models/Profiles.js";
const editProfileController=async(req,res)=>{
    try{
    // console.log('yay');
    const {email,_profileImage,name,_selectedGender,bio,no,myServices}=req.body;
    // console.log('ok');
    // console.log(email,_profileImage,name,_selectedGender,bio,no,myServices);
    const done= await new Profiles({email,name,no,gender: _selectedGender, bio,balance:0,myskills:myServices,history: [], dp:_profileImage})
    await done.save();
    if(done)
    {
        return res.status(200);
    }
    else
    {
        return res.status(500);
    }
    }
    catch(e)
    {
        return res.status(500);
    }
}
export default editProfileController;