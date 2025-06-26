import loginController from "../controllers/loginController.js";
import express from "express";

const signupRoutes=express.Router();

signupRoutes.post("/login",loginController);

export default signupRoutes;