import Requests from '../models/Requests.js';
const completeController=async(req,res)=>{
    try{
        const{from ,to ,service, datetime, place,status}=req.body;
        console.log(from);
        console.log(to);
        console.log(service);
        console.log(datetime);
        console.log(status);
        console.log(place);
        // status='mad' || 'accept';
        // console.log("reched to mad controller")
        const found = await Requests.findOneAndUpdate(
                    { from, to, service, datetime, place,status: { $in: ['accept', 'mad'] } },
                    { $set: { status: 'complete' } },
                    { new: true }
                );
        if(found)
        {
            console.log("found the record");
            return res.sendStatus(200);
            
        }
        else{
            // console.log("nit found");
            res.sendStaus(500);
        }
        }
        catch(e)
        {
            res.sendStatus(500);
        }
}
export default completeController;