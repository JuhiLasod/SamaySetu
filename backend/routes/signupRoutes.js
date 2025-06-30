import loginController from "../controllers/loginController.js";
import sendOtpController from "../controllers/sendOtpController.js";
import express from "express";

const signupRoutes=express.Router();

signupRoutes.post("/login",loginController);
signupRoutes.post("/send-otp",sendOtpController);

export default signupRoutes;