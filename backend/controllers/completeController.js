import Requests from '../models/Requests.js';
import Profiles from "../models/Profiles.js";
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
            const rec=await Profiles.findOne(
                {'email':from},
                
            )   
            const recbal=rec.balance-1;
            const provider=await Profiles.findOneAndUpdate(
                {'email':to},
             
            )
            const probal=provider.balance+1;
            await Profiles.updateOne({ email: from }, { $set: { balance: recbal } });
            await Profiles.updateOne({ email: to }, { $set: { balance: probal } });
            console.log("found the record");
            
            return res.sendStatus(200);
        
            res.sendStatus(500);
        
            
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