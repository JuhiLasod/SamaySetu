import Requests from "../models/Requests.js";

const myRequests=async(req,res)=>{
    try{
        const{from}=req.body;
        const requests=await Requests.find(
            {from: from},
            {to:1 , service:1 , datetime:1 , place:1,status:1, _id:0}
        );
        console.log(requests);
        res.json(requests);
        // res.sendStatus(200);
    }
    catch(e)
    {
        console.log("server error");
        res.sendStatus(500);
    }
}
export default myRequests;