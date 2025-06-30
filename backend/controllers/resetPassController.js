import Users from "../models/Users.js";

const resetPassController=async(req,res)=>{
    try{
        const {email,pass}=req.body;
        const exist=await Users.findOne({email});
        exist.pass=pass;
        await exist.save();
        res.send("pass reset successfull");
    }
    catch(e)
    {
        res.status(500);
    }
}
export default resetPassController;