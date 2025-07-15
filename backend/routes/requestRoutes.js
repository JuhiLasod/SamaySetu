import express from 'express';
import myRequests from '../controllers/myRequests.js';

const requestRoutes=express.Router();

requestRoutes.post("/my-req",myRequests);

export default requestRoutes;