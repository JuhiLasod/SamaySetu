import Users from "../models/Users.js";

const loginController=async(req,res)=>{
    const {email,pass}=req.body;
    console.log(email);
    console.log(pass);
    const exist=await Users.findOne({email,pass});
    if(exist)
    {
        console.log("inside if");
        return res.sendStatus(200);
    }
    return res.sendStatus(500);
}

export default loginController;