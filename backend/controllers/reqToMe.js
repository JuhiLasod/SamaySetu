import Requests from "../models/Requests.js";

const reqToMe=async(req,res)=>{
    
        const {from}= req.body;try{
        console.log(from);
        const req=await Requests.find({
            to: from},{
            from: 1,to:1, service: 1, datetime: 1, place: 1,status: 1, _id:0
        });
        console.log(req);
        res.json(req);
    }
    catch(e)
    {
        console.log("error in backend");
        res.sendStatus(500);
    }
}
export default reqToMe;