import Requests from "../models/Requests.js";

const reqToMe=async(req,res)=>{
    try{
        const {to}= req.body;
        const req=await Requests.find({
            to: to,
            from: 1, service: 1, datetime: 1, place: 1
        });
        res.json(req);
    }
    catch(e)
    {
        res.sendStatus(500);
    }
}
export default reqToMe;