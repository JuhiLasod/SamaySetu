import express from "express";
import dotenv from "dotenv";
import  mongoose from "mongoose";
import signupRoutes from "./routes/signupRoutes.js"; 

dotenv.config();
const app=express();
mongoose .connect(process.env.MONGO_URI)
.then(()=>console.log("db connected"))
.catch(()=>console.log("error connecting"));

app.use(express.json());

app.use("/api",signupRoutes);

app.listen(process.env.PORT || 8000 ,()=>{
    console.log("server connected at ",process.env.PORT);
})