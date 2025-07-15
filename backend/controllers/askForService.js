import nodemailer from 'nodemailer';
import dotenv from "dotenv";
import Requests from '../models/Requests.js';
import { text } from 'express';

dotenv.config();
const askForService=async(req,res)=>{
    
        const {from, service, to,datetime,place}=req.body;
        console.log("saving below content");
        console.log(from);
        console.log(service);
        console.log(to);
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
            to: to,
            subject:"asking for your availibility",
            text:`${from} asked for service to ${to} for ${service}mail from SamaySetu date time is ${datetime} and place is ${place}`
        }
        try{
            console.log("insode try");
        await transporter.sendMail(mailOptions);

        console.log("mail succ sent");
        try{
        const newreq= new Requests({from,to, service, datetime, place});
        await newreq.save();
        console.log("saved in req db");
        }catch(e)
        {
            console.log("couldnt save in req db");
        }
        res.sendStatus(200);
    } 
    catch(e)
    {
        res.sendStatus(500);
    }
}
export default askForService;