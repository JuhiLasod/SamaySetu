import Requests from "../models/Requests.js";

const reqStatus=async(req,res)=>{
    try{
        const{from,to,service,datetime,place,status}=req.body;
        console.log(from);
        console.log(to);
        console.log(service);
        console.log(datetime);
        console.log(place);
        console.log(status);


        const updatedReq = await Requests.findOneAndUpdate(
            { from, to, service, datetime, place },
            { $set: { status: status } },
            { new: true }
        );
        if(updatedReq)
        { console.log("inside if");
        res.sendStatus(200)
        }
        else
            res.sendStatus(500);
    }
    catch(e)
    {
        res.sendStatus(500);
    }
}
export default reqStatus;