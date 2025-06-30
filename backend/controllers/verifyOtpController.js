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
        res.send("Otp verified successfully.") 
    }
    else{
        console.log("Otp verification failed. Try sending otp again");
        res.send("failed");
    }
    }
    catch(e)
    {
        res.status(500);
    }
}
export default verifyOtpController;