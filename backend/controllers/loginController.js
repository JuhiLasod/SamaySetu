import Users from "../models/Users.js";
import dotenv from "dotenv";
import jwt from 'jsonwebtoken';

dotenv.config();
const loginController=async(req,res)=>{
    const {email,pass}=req.body;
    console.log(email);
    console.log(pass);
    const exist=await Users.findOne({email,pass});
    
    if(exist)
    {
        const token=jwt.sign({id: exist._id, email: exist.email},process.env.JWT_SECRET);
        console.log(token);
        return res.status(200).json({token});
    }
    return res.sendStatus(500);
}

export default loginController;