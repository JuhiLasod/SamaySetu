import Users from "../models/Users.js";

const signupController=async(req,res)=>{
    try{
    const{email,pass}=req.body;
    const exist=await Users.findOne({email});
    if(exist){
        res.status(500).send("This email id already have an account. Try using another email id.");
    }
    else{
        const newuser= await new Users({email,pass});
        await newuser.save();
        res.status(200).send("Signup successfull");
    }
    }
    catch(e)
    {
        res.status(500)
    }
}
export default signupController;