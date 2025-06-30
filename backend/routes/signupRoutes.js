import loginController from "../controllers/loginController.js";
import sendOtpController from "../controllers/sendOtpController.js";
import verifyOtpController from "../controllers/verifyOtpController.js";
import resetPassController from "../controllers/resetPassController.js";
import signupController from "../controllers/signupController.js";
import express from "express";

const signupRoutes=express.Router();

signupRoutes.post("/login",loginController);
signupRoutes.post("/send-otp",sendOtpController);
signupRoutes.post("/verify-otp",verifyOtpController);
signupRoutes.post("/reset-pass",resetPassController);
signupRoutes.post("/signup",signupController);

export default signupRoutes;