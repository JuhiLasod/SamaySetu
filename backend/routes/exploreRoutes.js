import exploreController from "../controllers/exploreController.js";
import askForService from "../controllers/askForService.js";

import express from "express";
const exploreRoutes= express.Router();

exploreRoutes.post("/load-users",exploreController);
exploreRoutes.post("/ask-for-service",askForService);
export default exploreRoutes;