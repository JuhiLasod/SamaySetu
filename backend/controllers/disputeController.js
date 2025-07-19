import Requests from "../models/Requests.js";
const disputeController=async(req,res)=>{
    const{from,to,service, datetime,place,status}=req.body;
    console.log("at dispute backend");
}
export default disputeController;