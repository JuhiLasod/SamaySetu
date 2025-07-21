import Requests from "../models/Requests.js";
const disputeController=async(req,res)=>{
    try{
    const{from,to,service, datetime,place,status}=req.body;
    const found = await Requests.findOneAndUpdate(
        { from, to, service, datetime, place,status: { $in: ['accept', 'mad'] } },
        { $set: { status: 'dispute' } },
        { new: true }
    );
    if(found)
    {
        res.sendStatus(200);
    }
    else
        {
            res.sendStatus(500)
    }
    }
    catch(e)
    {
        res.sendStatus(500);
    }
}
export default disputeController;