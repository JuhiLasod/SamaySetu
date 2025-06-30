import Otps from "../models/Otps.js";

const verifyOtpController=async(req,res)=>{
    try{
        console.log("verify otp backend");
    const{email,otp}=req.body;
    console.log(email);
    console.log(otp);
    const exist=await Otps.findOne({email,otp});
    if(exist)
    {
        console.log("the user and otp do exist");
        res.send("success") 
    }
    else{
        console.log("otp verification failed.try sending otp again");
        res.send("failed");
    }
    }
    catch(e)
    {
        res.status(500);
    }
}
export default verifyOtpController;