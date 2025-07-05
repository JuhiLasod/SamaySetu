import editProfileController from "../controllers/editProfileController.js";
import multer from "multer";
import express from "express";
const profileRoutes= express.Router();
const storage=multer.memoryStorage();
const upload=multer({storage});

profileRoutes.post("/set-profile", upload.single('dp'), editProfileController);
export default profileRoutes;