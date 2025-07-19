import express from 'express';
import myRequests from '../controllers/myRequests.js';
import reqToMe from "../controllers/reqToMe.js";
import reqStatus from "../controllers/reqStatus.js";
import MADController from '../controllers/MADController.js';

const requestRoutes=express.Router();

requestRoutes.post("/my-req",myRequests);
requestRoutes.post("/req-to-me",reqToMe);
requestRoutes.post("/set-status",reqStatus);
requestRoutes.post("/set-mad",MADController);


export default requestRoutes;