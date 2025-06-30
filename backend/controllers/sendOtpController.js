import Otps from "../models/Otps.js";
import Users from "../models/Users.js";
import nodemailer from "nodemailer";
// import Users from "../models/Users.js";
const sendOtpController=async(req,res)=>{
    try{
    const{email}=req.body;
    const exuser= await Users.findOne({email});
    if(exuser)
    {
        console.log("user exist");
        let exist=await Otps.findOne({email: email});
        const otp=Math.floor(100000 + Math.random()*900000);
        if(exist)
        {
            console.log('inside saving otp');
            exist.otp=otp;
            await exist.save();
        }
        else{
            console.log('new user saving new otp');
            exist=new Otps({email,otp});
            await exist.save();
        }
        res.send("otp saved successfully");
        const transporter=nodemailer.createTransport({
            service: "gmail",
            auth: {
                user:process.env.MAIL_ID,
                pass: process.env.PASS
            }
        });
        const mailOptions=({
            from: process.env.MAIL_ID,
            to: email,
            subject: "Password reset credentials from SamaySetu",
            text: `sdfg ${otp} sdfgherty`
        });
        try{
            console.log("sending mail...");
            await transporter.sendMail(mailOptions);
            
        }
        catch(e)
        {
            res.send("error sending mail");
        }
    }
    else{
        console.log("user do not exist in users list");
        res.send("User do not exist");
    }
    }
    catch(e)
    {
        console.log("server error");
        res.status(500);
    }
}
export default sendOtpController;