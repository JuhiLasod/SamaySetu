import Profiles from "../models/Profiles.js";
const exploreController=async(req,res)=>{
    try{
    const {selected}=req.body;
    console.log("reached to controller");
    const matchingUsers=await Profiles.find(
        {myskills: selected},
        {name:1, email:1, _id: 0}
    );
    console.log(matchingUsers);
    res.json(matchingUsers); 
    //  res.sendStatus(200);
    console.log(matchingUsers);
    } 
    catch(e)
    {
        return res.sendStatus(500); 
    }
};
export default exploreController;