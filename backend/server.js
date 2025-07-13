import express from "express";
import dotenv from "dotenv";
import  mongoose from "mongoose";
import signupRoutes from "./routes/signupRoutes.js"; 
import profileRoutes from "./routes/profileRoutes.js";
import exploreRoutes from "./routes/exploreRoutes.js";

dotenv.config();
const app=express();
mongoose .connect(process.env.MONGO_URI)
.then(()=>console.log("db connected"))
.catch(()=>console.log("error connecting"));

app.use(express.json());

app.use("/api",signupRoutes);
app.use("/profile",profileRoutes);
app.use("/explore",exploreRoutes);

app.listen(process.env.PORT || 8000 ,()=>{
    console.log("server connected at ",process.env.PORT);
})