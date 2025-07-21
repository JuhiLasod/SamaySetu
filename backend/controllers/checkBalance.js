import Profiles from "../models/Profiles.js";

const checkBalance=async(req,res)=>{
    try{
    const {email}=req.body;
    console.log("rec email at check balance bakcend is ");
    console.log(email);
    const find=await Profiles.findOne({email});
    if(find)
    {
        const balance=find.balance;
        console.log(balance);
        if(balance>0)
        {
            return res.sendStatus(200);
        }
        else
        {
            return res.sendStatus(500);
        }
    }
    else
    {
        return res.sendStatus(500);
    }
    }
    catch(e)
    {
        res.sendStatus(500);
    }
}
export default checkBalance;