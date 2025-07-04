import editProfileController from "../controllers/editProfileController.js";
import express from "express";
const profileRoutes= express.Router();
profileRoutes.post("/set-profile",editProfileController);
export default profileRoutes;