import editProfileController from "../controllers/editProfileController.js";
import isProfileController from "../controllers/isProfileController.js";
import loadProfileController from "../controllers/loadProfileController.js";
import multer from "multer";
import express from "express";
const profileRoutes= express.Router();
const storage=multer.memoryStorage();
const upload=multer({storage});

profileRoutes.post("/set-profile", upload.single('dp'), editProfileController);
profileRoutes.post("/isprofile",isProfileController);
profileRoutes.post("/loadprofile",loadProfileController);
export default profileRoutes;