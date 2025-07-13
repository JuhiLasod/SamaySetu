import exploreController from "../controllers/exploreController.js";

import express from "express";
const exploreRoutes= express.Router();

exploreRoutes.post("/load-users",exploreController);
export default exploreRoutes;