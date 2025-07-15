import nodemailer from 'nodemailer';
import dotenv from "dotenv";
import { text } from 'express';

dotenv.config();
const askForService=async(req,res)=>{
    
        const {email,datetime,place}=req.body;
        console.log(email);
        console.log(datetime);
        console.log(place);
        const transporter=nodemailer.createTransport({
            service: "gmail",
            auth:{
                user: process.env.MAIL_ID,
                pass: process.env.PASS
            }
        });
        console.log("trns created");
        const mailOptions={
            from: process.env.MAIL_ID,
            to: email,
            subject:"asking for your availibility",
            text:`mail from SamaySetu date time is ${datetime} and place is ${place}`
        }
        try{
            console.log("insode try");
        await transporter.sendMail(mailOptions);
        console.log("mail succ sent");
        res.sendStatus(200);
    } 
    catch(e)
    {
        res.sendStatus(500);
    }
}
export default askForService;