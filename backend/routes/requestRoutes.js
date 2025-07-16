import express from 'express';
import myRequests from '../controllers/myRequests.js';
import reqToMe from "../controllers/reqToMe.js";

const requestRoutes=express.Router();

requestRoutes.post("/my-req",myRequests);
requestRoutes.post("/req-to-me",reqToMe);

export default requestRoutes;